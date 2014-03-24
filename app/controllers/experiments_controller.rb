class ExperimentsController < InheritedResources::Base
  actions :new, :create, :index, :show, :update, :destroy
  custom_actions :collection => :all
  respond_to :js, :only => :destroy

  def create
    @experiment
  end
  def index
    @experiments = Experiment.where(creator_id: current_user.id)
    @filter_title = 'show all'
    @filter_url = experiments_path + '/all'
    index!
  end
  def all
    @experiments = Experiment.all
    @filter_title = 'show only my'
    @filter_url = experiments_path
    render 'index'
  end
  def destroy
    @experiment_id = params[:id]
    destroy!
  end
  private
  def permitted_params
    params.permit(experiment: [
        :name,
        :description,
        :type,
        :finished
    ])
  end
end
