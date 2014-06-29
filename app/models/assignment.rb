require 'composite_primary_keys'
class Assignment < ActiveRecord::Base

  self.primary_keys = :user_id, :experiment_id

  belongs_to :user
  belongs_to :experiment

  attr_writer :current_session

  def current_session
    registration = Registration.where(user_id: user, session_id: experiment.sessions, shown_up: nil)
    registration.first ? registration.first.session : nil
  end
  def current_session=(session)
    user.sessions.delete current_session if current_session
    user.sessions << Session.find(session) if not session.empty?
  end

  self.primary_keys = :user_id, :experiment_id

  def as_json(options = { })
    super((options || { }).merge({
      :methods => [:current_session]
    }))
  end
end
