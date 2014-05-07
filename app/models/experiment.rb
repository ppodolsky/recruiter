class Experiment < ActiveRecord::Base
  before_save :default_values
  has_paper_trail
  has_many :sessions, :dependent => :delete_all
  has_many :assignments, :dependent => :delete_all
  has_many :users, through: :assignments
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id', inverse_of: :experiments

  has_and_belongs_to_many :categories

  validates_presence_of :name, :type, presence: true
  validates :reward, :numericality => { :greater_than_or_equal_to => 0 }

  def opened_sessions
    sessions.where("registration_deadline > ?", Time.now)
  end
  def type_name
    self.type.gsub("Experiment", "")
  end
  def default_values
    self.default_invitation ||=
'#### Hello, @name!
You are being invited to participate in an experiment in which you will make economic decisions.
In addition to your cash earnings from the experiment, you will be paid a on-time bonus of **@reward** for showing up on time.
The session(s) is scheduled for the following time(s):
@session_list
If you want to participate in one of the sessions, you can register [here](@timeline_url).
Thank you for signing up to receive information about our experiments.
If you have any questions about this experiment, please reply directly to this invitation.
We hope to see you soon!

Sincerely, ICES Experimenters'
  end
end
