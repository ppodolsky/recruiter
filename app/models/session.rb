class Session < ActiveRecord::Base
  belongs_to :experiment
  has_and_belongs_to_many :users
end
