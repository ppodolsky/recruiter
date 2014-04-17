class TimelineController < ApplicationController
  respond_to :json, :only => [:calendar]

  before_action :authenticate_user!

  def index
    @incoming = current_user.sessions.where(finished: false).order('start_time ASC')
    @opened = Session
      .where(experiment_id: current_user.experiments)
      .where('registration_deadline > ?', Time.now)
      .where.not(id: current_user.sessions)
      .order('start_time ASC')
  end

  def calendar
    events = Session
      .includes(:experiment => :creator)
      .where(start_time: DateTime.strptime(params[:start],'%s')..DateTime.strptime(params[:end],'%s'))
    respond_to do |format|
      format.json {
        render :json => events.to_json(
            :only => [:start_time, :end_time, :duration],
            :include => {
              :experiment => {
                  :only => [:name],
                  :include => {
                      :creator => {
                          :only => [:first_name, :last_name]
                      }
                  },
              }
          }
        )
      }
    end
  end
end
