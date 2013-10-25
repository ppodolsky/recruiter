class Experimenter < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_experimenters
  belongs_to :resource, :polymorphic => true

# many-to-many with experiments  
  has_and_belongs_to_many :experiments, :join_table => :experiments_experimenters
  
  scopify

# association with users & think on migration!!!
  belongs_to :user inverse_of: :experimenter
end
