class User < ActiveRecord::Base

  has_many :created_experiments, :foreign_key => 'creator_id', :class_name => "Experiment"

  has_many :registrations
  has_many :sessions, through: :registrations

  has_many :assignments
  has_many :experiments, through: :assignments


  attr_reader :attendance, :never_been

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :not_locked, -> { where(locked_at: nil) }
  scope :locked, -> { where.not(locked_at: nil) }
  scope :not_suspended, -> { where(suspended: false) }
  scope :suspended, -> { where(suspended: true) }
  scope :profile_full, -> {
    where("COALESCE(first_name,'') <> '' and COALESCE(last_name,'') <> '' and
          COALESCE(gsharp,'') <> '' and COALESCE(gender,'') <> '' and
          COALESCE(ethnicity,'') <> '' and birth_year is not null and class_year is not null and
          year_started  is not null and years_resident is not null and current_gpa  is not null and
          COALESCE(major,'') <> '' and COALESCE(profession,'') <> ''")
  }

  before_validation :set_canonical_name
  before_update :change_type_service
  before_update :activate_on_login
  after_update :check_legacy

  validates_uniqueness_of :username, :case_sensitive => false
  validates_presence_of :email, :first_name, :last_name


  validate :is_corporate_email?
  validates :secondary_email, format: {
      with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i,
      multiline: true,
      message: 'Not a valid e-mail address.'
  }
  validates :secondary_email, uniqueness: true, allow_blank: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :async
  [:first_name, :last_name].each do |attribute|
    normalize_attribute attribute do |value|
      value.is_a?(String) ? value.titleize.strip : value
    end
  end
  def is_corporate_email?
    if not self.email.end_with? "@masonlive.gmu.edu" and not self.email.end_with? "@gmu.edu"
      errors.add(:email, 'is not allowed. It can be only at masonlive.gmu.edu or gmu.edu')
    end
  end
  def reset_password(opts = {})
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)
    self.reset_password_token = enc
    self.reset_password_sent_at = Time.now.utc
    self.save!(:validate => false)
    UserMailer.delay.reset_password_instructions(self, raw, opts)
  end

  normalize_attributes :secondary_email

  self.per_page = 10

  def self.find_by_cred(cred)
    where("email = ? or gsharp = ?", cred, cred)
  end

  def self.find_by_query(query)
    where("email ilike '%'||?||'%' or gsharp ilike '%'||?||'%' or (first_name||' '||last_name) ilike '%'||?||'%' or (last_name ||' '||first_name) ilike '%'||?||'%'",
    query,query,query,query)
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def is_experimenter?
    self.type == "Administrator" or self.type == "Experimenter"
  end
  def is_administrator?
    self.type == "Administrator"
  end
  def is_subject?
    self.type == "Subject"
  end

  def attendance
    registrations.count != 0 ? registrations.finished.where(shown_up: true).count / registrations.count : 100
  end
  def never_been
    registrations.finished.where(shown_up: true).count == 0
  end
  def registrations_count
    attributes['registrations_count']
  end
  def shown_up_count
    attributes['shown_up_count']
  end
  def profile_full?
    first_name.present? and last_name.present? and gsharp.present? and gender.present? and ethnicity.present? and birth_year.present? and class_year.present? and
        year_started.present? and years_resident.present? and current_gpa.present? and major.present? and profession.present?
  end
  def age
    if self.birth_year.present? then
      (Time.now.year - self.birth_year)
    else
      nil
    end
  end
  def set_canonical_name
    self.username = self.email.split(/@/).first
  end
  def check_legacy
    if self.secondary_email_changed? and self.secondary_email.present?
      legacy_user = LegacyUser.find_by_email(self.secondary_email)
      if legacy_user.present?
        legacy = LegacyParticipation.where(legacy_user_id: legacy_user.id)
        if legacy.present?
          legacy.each do |participation|
            model = Assignment.new(experiment_id: participation.experiment_id, user_id: self.id, invited: participation.invited)
            model.save(validate: false)
            model = Registration.new(session_id: participation.session_id, user_id: self.id,
                                     shown_up: participation.shown_up, participated: participation.participated)
            model.save(validate: false)
          end
        end
      end
    end
  end
  def check_and_suspend!
    previous = self.sessions.select('*').includes(:registrations).where(finished: true).where('start_time > ?', self.suspended_at).order(start_time: :desc)
    if self.registrations.finished.where(shown_up: false).where(session_id: self.sessions.where('start_time > ?', self.suspended_at).pluck(:id)).count >= 3 or
        (previous.size >= 2 and previous[0,2].all? {|x| x.present? and not x.shown_up})
      self.suspend!
    end
    self.suspended
  end
  def suspend!
    self.suspended = true
    self.suspended_at = Time.now
    self.save(validate: false)
    UserMailer.delay.suspend(self)
  end
  def unsuspend!
    self.suspended = false
    self.suspended_at = Time.now
    self.save(validate: false)
    UserMailer.delay.unsuspend(self)
  end
  def current_experiments
    self.sessions.where(finished: false).pluck(:experiment_id)
  end
  def participated_experiments
    self.sessions.where(finished: true).where(id: self.registrations.where(participated: true).pluck(:session_id)).pluck(:experiment_id)
  end
  def change_type_service
    if self.type_changed? and self.type_was == 'Subject' then
      self.sessions.delete (self.sessions.where(finished: false))
      self.experiments.delete (self.experiments.where(finished: false))
    end
  end
  def activate_on_login
    if self.last_sign_in_at_changed? then
      self.active = true
    end
  end
end