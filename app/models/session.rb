class Session < ActiveRecord::Base
  has_paper_trail
  belongs_to :lab, inverse_of: :sessions
end
