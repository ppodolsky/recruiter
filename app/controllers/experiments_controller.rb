class ExperimentsController < InheritedResources::Base
  actions :new,:create,:index,:show,:update

  def index
    @experiments = Experiment.all
  end
  def new
    @experiment = Experiment.new
  end
  def show
    @experiment = Experiment.find(params[:id])
    @sessions = @experiment.sessions
  end
  def create
    @experiment = Experiment.create(experiment_params)
    redirect_to experiment_path @experiment
  end
  def update
    @experiment = Experiment.find(params[:id])
    @experiment.update_attributes!(experiment_params)
    flash[:notice] = 'Changes has been saved'
    redirect_to experiment_path @experiment
  end
  private
  def experiment_params
    params.require(:experiment).permit(
        :name,
        :description,
        :type,
        :finished
    )
  end
end
