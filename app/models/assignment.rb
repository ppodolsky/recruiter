require 'composite_primary_keys'
class Assignment < ActiveRecord::Base
  belongs_to :subject, class_name: 'User', foreign_key: 'user_id'
  belongs_to :experiment

  self.primary_keys = :user_id, :experiment_id
end
