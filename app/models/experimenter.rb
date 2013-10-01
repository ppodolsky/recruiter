class Experimenter < ActiveRecord::Base
  
  has_and_belongs_to_many :experiments, inverse_of: :experiments
end
