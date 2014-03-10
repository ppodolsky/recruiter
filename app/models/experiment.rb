class Experiment < ActiveRecord::Base
  validates_inclusion_of :context, :in => %w( field lab )
  has_many :sessions
end
