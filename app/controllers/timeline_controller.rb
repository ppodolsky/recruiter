class TimelineController < ApplicationController
  respond_to :json, :only => [:calendar]

  before_action :authenticate_user!

  def index
    @incoming = current_user.sessions.where(finished: false).order('start_time ASC')
    @opened = Session
      .where(experiment_id: current_user.experiments)
      .where('registration_deadline > ?', Time.now)
      .where.not(id: current_user.sessions)
      .where.not(experiment_id: current_user.sessions.pluck(:experiment_id))
      .order('start_time ASC')
  end

end
