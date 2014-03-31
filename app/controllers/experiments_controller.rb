class ExperimentsController < InheritedResources::Base
  actions :new, :create, :index, :show, :update, :destroy
  custom_actions :collection => :all, :resource => [:invite]
  respond_to :js, :only => :destroy

  def create
    @experiment = Experiment.new(permitted_params[:experiment])
    @experiment.user = current_user
    create!
  end
  def index
    @experiments = Experiment.where(user: current_user)
    @filter_title = 'show all'
    @filter_url = experiments_all_path
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
  def invite
    @experiment = Experiment.find(params[:experiment_id])
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
