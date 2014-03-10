class User < ActiveRecord::Base
  has_paper_trail

  before_validation :set_canonical_name

  has_one :profile, inverse_of: :user
  has_and_belongs_to_many :sessions
  has_and_belongs_to_many :roles, join_table: 'users_roles'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :async

  validates_presence_of   :email
  validates_uniqueness_of :email, :case_sensitive => false

  validates_uniqueness_of :username, :case_sensitive => false


  after_initialize do |user|
    @roles_s = roles.map{|r| r.name}
  end

  def admin?
    @roles_s.include?('admin')
  end
  def experimenter?
    @roles_s.include?('experimenter')
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
