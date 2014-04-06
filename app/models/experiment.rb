class Experiment < ActiveRecord::Base
  before_save :default_values
  has_paper_trail
  has_many :sessions
  has_many :assignments
  has_many :subjects, class_name: 'User', through: :assignments
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id', inverse_of: :experiments
  has_and_belongs_to_many :categories

  validates_presence_of :name, :type, presence: true

  def default_values
  end
end
