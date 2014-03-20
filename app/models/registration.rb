class Registration < ActiveRecord::Base
  has_paper_trail
  belongs_to :subject
  belongs_to :session

  self.primary_key = [:subject_id, :session_id]
end
