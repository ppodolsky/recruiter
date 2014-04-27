class ExperimentsController < InheritedResources::Base
  before_action :authenticate_user!
  actions :all
  custom_actions :collection => [:assigned, :calendar], :resource => [:invite]
  respond_to :js, :only => [:destroy, :update, :calendar]

  def permitted_params
    params.permit(experiment: [
        :name,
        :description,
        :type,
        :default_invitation,
        :finished,
        {category_ids: []}
    ])
  end

  def create
    @experiment = Experiment.new(permitted_params[:experiment])
    @experiment.creator = current_user
    create!
  end
  def index
    @experiments = Experiment.where(creator: current_user, finished: false).order("created_at DESC")
    @filter_title = 'show all'
    @filter_url = experiments_all_path
    index!
  end
  def all
    @experiments = Experiment.all.where(finished: false).order("created_at DESC")
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
  def send_invite

  end
  def calendar
    events = Session
    .includes(:experiment => :creator)
    .where(start_time: DateTime.strptime(params[:start],'%s')..DateTime.strptime(params[:end],'%s'))
    respond_to do |format|
      format.json {
        render :json => events.to_json(
            :only => [:start_time, :end_time, :duration, :finished],
            :include => {
                :experiment => {
                    :only => [:name],
                    :include => {
                        :creator => {
                            :only => [:first_name, :last_name]
                        }
                    },
                },
                :lab => {
                    :only => [:location]
                }
            }
        )
      }
    end
  end
end
