class ExperimentsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :raise_if_not_experimenter
  actions :all
  custom_actions :collection => [:assigned, :calendar], :resource => [:invite]
  respond_to :json, :only => [:update]

  def permitted_params
    params.permit(experiment: [
        :name,
        :description,
        :type,
        :reward,
        :default_invitation,
        :finished,
        {category_ids: []}
    ])
  end
  def assigned
    @experiment = Experiment.find(params[:experiment_id])
    @users = @experiment.users.order("last_name ASC, first_name ASC").paginate(:page => params[:page], :per_page => 200)
  end
  def create
    @experiment = Experiment.new(permitted_params[:experiment])
    @experiment.creator = current_user
    create!
  end
  def index
    @experiments = Experiment.where(creator: current_user).order("created_at DESC")
    @filter_title = 'show all'
    @filter_url = experiments_all_path
    index!
  end
  def all
    @experiments = Experiment.all.order("created_at DESC")
    @filter_title = 'show only my'
    @filter_url = experiments_path
    render 'index'
  end
  def destroy
    @experiment_id = params[:id]
    destroy! { experiments_path }
  end
  def invite
    @experiment = Experiment.find(params[:experiment_id])
  end
  def send_invite
    experiment = Experiment.find(params[:experiment_id])
    stack = experiment.assignments.where.not(user_id: experiment.participated_users_ids).where.not(user_id: experiment.current_users_ids).where.not(user_id: Subject.where(suspended: true).pluck(:id)).order('random(), invited').limit(params[:amount])
    stack.each do |a|
      UserMailer.delay.invitation(a.user, experiment, params[:subject], params[:experiment][:default_invitation])
      a.update!(invited: true)
    end
    UserMailer.delay.experimenter_invitation(experiment, stack.collect{|x| x.user.email}.map {|x| "* #{x.to_s}"}.join("\n") + "\n", params[:subject], params[:experiment][:default_invitation])
    flash[:success] = 'Mailing has been started'
    redirect_to :back
  end
  def calendar
    events = Session
    .includes(:experiment => :creator)
    .where(start_time: DateTime.strptime(params[:start],'%s')..DateTime.strptime(params[:end],'%s'))
    respond_to do |format|
      format.json {
        render :json => events.to_json(
            :only => [:start_time, :end_time, :duration, :finished, :id, :required_subjects, :registered_subjects],
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
