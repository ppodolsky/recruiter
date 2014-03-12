class Session < ActiveRecord::Base
  has_paper_trail
  belongs_to :experiment
  belongs_to :lab, inverse_of: :sessions
  has_many :registrations
  has_many :subjects, through: :registrations
end
