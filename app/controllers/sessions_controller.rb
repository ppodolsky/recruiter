class SessionsController < InheritedResources::Base
  actions :index,:show,:update,:create,:new,:destroy,:edit

  def index
    @sessions = Session.all
  end
  def update
  end
  def show
    @session = Session.find(params[:id])
  end
  def edit
    @session = Session.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  def new
    @experiment = Experiment.find(params[:experiment_id])
    @session = @experiment.sessions.new
    respond_to do |format|
      format.js
    end
  end
  def create
    @experiment = Experiment.find(params[:experiment_id])
    @session = @experiment.sessions.create(session_params)
    @session.save
    redirect_to experiment_path(@experiment)
  end
  def destroy
    @experiment = Experiment.find(params[:experiment_id])
    @session = Session.find(params[:id])
    @session.destroy
    redirect_to experiment_path(@experiment)
  end
  private
  def session_params
    params.require(:session).permit(
        :date_start,
        :date_finish,
        :registration_start,
        :registration_finish,
        :session_length,
        :lab,
        :required_subjects
    )
  end

end
