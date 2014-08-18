class User < ActiveRecord::Base
  has_paper_trail


  has_many :created_experiments, :foreign_key => 'creator_id', :class_name => "Experiment"

  has_many :registrations
  has_many :sessions, through: :registrations

  has_many :assignments
  has_many :experiments, through: :assignments


  attr_reader :attendance, :never_been

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :profile_filled, -> {
    where("COALESCE(first_name,'') <> '' and COALESCE(last_name,'') <> '' and COALESCE(gsharp,'') <> '' and
          COALESCE(secondary_email,'') <> '' and COALESCE(phone,'') <> '' and COALESCE(gender,'') <> '' and
          COALESCE(ethnicity,'') <> '' and birth_year is not null and class_year is not null and
          year_started  is not null and years_resident is not null and current_gpa  is not null and
          COALESCE(major,'') <> '' and COALESCE(profession,'') <> ''")
  }

  before_validation :set_canonical_name
  before_update :change_type_service
  before_update :activate_on_login

  validates_uniqueness_of :username, :case_sensitive => false
  validates_presence_of :email, :first_name, :last_name


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
    registrations.count != 0 ? registrations.where(shown_up: true).count / registrations.count : 100
  end
  def never_been
    registrations.where(shown_up: true).count == 0
  end
  def registrations_count
    attributes['registrations_count']
  end
  def shown_up_count
    attributes['shown_up_count']
  end
  def profile_full?
    first_name.present? and last_name.present? and gsharp.present? and secondary_email.present? and
        phone.present? and gender.present? and ethnicity.present? and birth_year.present? and class_year.present? and
        year_started.present? and years_resident.present? and current_gpa.present? and major.present? and profession.present?
  end
  def age
    (Time.now.year - self.birth_year)
  end
  def set_canonical_name
    self.username = self.email.split(/@/).first
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