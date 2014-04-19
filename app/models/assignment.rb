require 'composite_primary_keys'
class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :experiment

  self.primary_keys = :user_id, :experiment_id
end
