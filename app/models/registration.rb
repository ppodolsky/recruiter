require 'composite_primary_keys'
class Registration < ActiveRecord::Base
  has_paper_trail
  belongs_to :subject
  belongs_to :session


  self.primary_keys = :subject_id, :session_id
end
