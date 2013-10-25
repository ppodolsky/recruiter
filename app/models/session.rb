class Session < ActiveRecord::Base
  validates_presence_of :date_start
  validates_presence_of :date_stop

#associations:
# one experiment has many sessions  
  belongs_to :experiment, inverse_of: :sessions
# many users participate in many sessions => experiments. may be reasonable make many-to-many through
  has_and_belongs_to_many :subjects, :join_table => :sessions_subjects
end
