require 'composite_primary_keys'
class Registration < ActiveRecord::Base
  after_create :send_email
  self.primary_keys = :user_id, :session_id

  belongs_to :user
  belongs_to :session

  validate :validate_allowness

  scope :finished, -> { includes(:session).where('sessions.finished = ?', true) }

  def send_email
    UserMailer.delay.registered_on_session(self.user, self.session)
  end

  def validate_allowness
    if not self.user.experiments.exists?(id: self.session.experiment.id)
      errors.add(:session, "User have not been assigned to #{self.session.experiment.name}")
    end
    if Registration.where.not(session_id: self.session).exists?(session_id: self.session.experiment.sessions.where(finished: true), user_id: self.user.id, participated: true)
      errors.add(:session, "User is already participated")
    end
    reg = Registration.where.not(session_id: self.session).where(session_id: self.session.experiment.sessions.where(finished: false), user_id: self.user.id)
    if reg.count > 0
      errors.add(:session, "User is already registered for #{reg.first.session.start_time_display}")
    end
  end
end
