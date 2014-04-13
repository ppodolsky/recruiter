class TimelineController < ApplicationController
  before_action :authenticate_user!

  def index
    @incoming = current_user.sessions.where(finished: false).order('start_time ASC')
    @opened = Session
      .where(experiment_id: current_user.experiments)
      .where('registration_deadline > ?', Time.now)
      .order('start_time ASC')
  end
end
