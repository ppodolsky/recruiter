class Experiment < ActiveRecord::Base
  has_paper_trail
  has_many :sessions
  has_many :assignments
  has_many :subjects, through: :assignments
  has_and_belongs_to_many :categories
end
