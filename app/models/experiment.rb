class Experiment < ActiveRecord::Base
  
  validates_presence_of :name
  has_many :sessions
  has_and_belongs_to_many :experimenters, inverse_of: :experimenters
end
