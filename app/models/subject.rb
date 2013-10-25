class Subject < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_subjects
  belongs_to :resource, :polymorphic => true
  
  has_and_belongs_to_many :sessions, :join_table => :sessions_subjects
  
  scopify
end
