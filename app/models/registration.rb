require 'composite_primary_keys'
class Registration < ActiveRecord::Base
  has_paper_trail
  belongs_to :user
  belongs_to :session

  before_save :validate_allowness

  def validate_allowness
    if Time.now > self.session.registration_deadline
      errors.add(:session_deadline, "is over")
    end
    if not self.user.experiments.find(self.session.experiment).nil?
      errors.add(:user, "isn't assigned to the corresponding experiment")
    end
    if not (self.session.experiment.sessions & self.user.sessions).empty?
      errors.add(:session, "already registred")
    end
  end

  self.primary_keys = :user_id, :session_id
end
