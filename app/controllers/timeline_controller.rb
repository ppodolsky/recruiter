class TimelineController < ApplicationController
  respond_to :json, :only => [:calendar]

  before_action :authenticate_user!

  def index
    @incoming = current_user.sessions.where(finished: false).order('start_time ASC')
    @opened = Session
      .where(reservation: false)
      .where(finished: false)
      .where(experiment_id: current_user.experiments)
      .where('registration_deadline > ?', Time.now)
      .where.not(id: current_user.sessions)
      .where.not(experiment_id: current_user.current_experiments)
      .where.not(experiment_id: current_user.participated_experiments)
      .order('start_time ASC').select { |i| i.users.size < i.required_subjects }
  end

end
