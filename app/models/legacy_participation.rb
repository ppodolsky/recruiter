class LegacyParticipation < ActiveRecord::Base
  belongs_to :legacy_user
  belongs_to :experiment
  belongs_to :session
end
