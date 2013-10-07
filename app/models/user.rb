class User < ActiveRecord::Base
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  validates_presence_of   :email
  validates_uniqueness_of :email, :case_sensitive => false

# users participate in sessions (many-to-many)
  has_and_belongs_to_many :sessions, :join_table => :sessions_users
# connection to experimenter (one-to-one)
 has_one :experimenter, inverse_of: :experimenter
# connection to profile
 has_one :profile, inverse_of: :user
end
