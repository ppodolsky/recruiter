class Session < ActiveRecord::Base
  validates_presence_of :date_start
  validates_presence_of :date_stop
  
  belongs_to :experiment
end
