class User < ActiveRecord::Base
# roles for user:
  rolify :role_cname => 'Admin'
  rolify :role_cname => 'Subject'
  rolify :role_cname => 'Experimenter'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  validates_presence_of   :email
  validates_uniqueness_of :email, :case_sensitive => false

# connection to profile
 has_one :profile, inverse_of: :user
end
