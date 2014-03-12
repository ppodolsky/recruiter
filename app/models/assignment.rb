class Assignment < ActiveRecord::Base
  has_paper_trail
  belongs_to :subject
  belongs_to :experiment
end
