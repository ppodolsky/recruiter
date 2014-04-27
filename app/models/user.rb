class User < ActiveRecord::Base
  has_paper_trail

  has_many :created_experiments, :foreign_key => 'creator_id', :class_name => "Experiment"

  has_many :registrations
  has_many :sessions, through: :registrations

  has_many :assignments
  has_many :experiments, through: :assignments


  attr_reader :attendance, :never_been


  before_validation :set_canonical_name
  before_update :change_type_service

  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :gsharp
  validates_presence_of :email, :first_name, :last_name, :gsharp


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

  def self.find_by_cred(cred)
    where("email = ? or gsharp = ?", cred, cred)
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
end