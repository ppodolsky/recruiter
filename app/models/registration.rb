require 'composite_primary_keys'
class Registration < ActiveRecord::Base
  has_paper_trail
  belongs_to :subject, class_name: 'User', foreign_key: 'user_id'
  belongs_to :session

  self.primary_keys = :user_id, :session_id
end
