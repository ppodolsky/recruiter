class User < ActiveRecord::Base
  before_validation :set_canonical_name

  has_one :profile, inverse_of: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :async

  validates_presence_of   :email
  validates_uniqueness_of :email, :case_sensitive => false

  validates_uniqueness_of :username, :case_sensitive => false

  def is_admin?
    false
  end

  def set_canonical_name
    self.username = get_canonical_name
  end

  private

  def get_canonical_name
    email = self.email.split(/@/)
    email.first
  end
end
