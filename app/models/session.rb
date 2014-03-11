class Session < ActiveRecord::Base
  has_paper_trail
  belongs_to :experiment
  belongs_to :lab, inverse_of: :sessions
  has_and_belongs_to_many :subjects
end
