require 'composite_primary_keys'
class Assignment < ActiveRecord::Base
  has_paper_trail
  self.primary_keys = :subject_id, :experiment_id
  belongs_to :subject
  belongs_to :experiment

end
