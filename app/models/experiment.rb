class Experiment < ActiveRecord::Base
  has_paper_trail
  validates_inclusion_of :context, :in => %w( field lab )
  has_many :sessions
  has_and_belongs_to_many :categories
end
