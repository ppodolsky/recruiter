class User < ActiveRecord::Base
  has_paper_trail

  before_validation :set_canonical_name

  has_one :profile

  validates_presence_of   :email
  validates_uniqueness_of :email, :case_sensitive => false

  validates_uniqueness_of :username, :case_sensitive => false

  def name
    "#{self.profile.first_name} #{self.profile.last_name}"
  end

  def is_experimenter?
    self.type == "Administrator" or self.type == "Experimenter"
  end
  def is_administrator?
    self.type == "Administrator"
  end
  def is_subject
    self.type == "Subject"
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :async

private
  def set_canonical_name
    self.username = self.email.split(/@/).first
  end
end
