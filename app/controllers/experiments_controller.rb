class ExperimentsController < InheritedResources::Base
  actions :index,:show,:update

  def index
    @experiments = Experiment.all
  end
  def show
    @experiment = Experiment.find(params[:id])
    @sessions = @experiment.sessions
  end
end
