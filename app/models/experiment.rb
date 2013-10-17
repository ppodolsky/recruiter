class Experiment < ActiveRecord::Base
  
  validates_presence_of :name
  
# parent of sessions (one-to-many) 
  has_many :sessions, inverse_of: :experiment
  
# many to many with experimenters, join table: CreateExperimentsExperimentersJoinTable 
  has_and_belongs_to_many :experimenters, :join_table => :experiments_experimenters

#  many to many with categories (tags), join table: 
  has_and_belongs_to_many :categories, :join_table => :categories_experiments
  
  normalize_attributes :name
end
