class User < ActiveRecord::Base
  has_paper_trail

  before_validation :set_canonical_name

  has_one :profile

  validates_presence_of   :email
  validates_uniqueness_of :email, :case_sensitive => false

  validates_uniqueness_of :username, :case_sensitive => false

  def is_admin?
    false
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :async

private

  def set_canonical_name
    self.username = self.email.split(/@/).first
  end
end
