class SessionsController < InheritedResources::Base
  actions :index,:show,:update,:create,:new,:destroy,:edit

  def index
    @sessions = Session.all
  end
  def update
    @session = Session.find(params[:id])
    @session.update_attributes!(session_params)
    @experiment = Experiment.find(@session.experiment_id)
    redirect_to experiment_path(@experiment)
  end
  def show
    @session = Session.find(params[:id])
  end
  def edit
    @session = Session.find(params[:id])
  end
  def new
    @experiment = Experiment.find(params[:experiment_id])
    @session = @experiment.sessions.new
  end
  def create
    @experiment = Experiment.find(params[:experiment_id])
    @session = @experiment.sessions.create(session_params)
    redirect_to experiment_path(@experiment)
  end
  def destroy
    @session_id = params[:id]
    @session = Session.find(params[:id])
    @session.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js   { render :layout=>false }
    end
    @sessions = Session.all
  end
  private
  def session_params
    params.require(:session).permit(
        :start_time,
        :end_time,
        :duration,
        :required_subjects,
        :registration_deadline,
        :lab,
    )
  end

end
