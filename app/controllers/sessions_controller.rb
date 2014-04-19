class SessionsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :raise_if_not_experimenter, only: [:online, :finish, :update, :create, :new, :destroy, :show]
  belongs_to :experiment
  respond_to :js, :only => [:destroy]
  actions :assigned, :edit, :show, :update, :create, :new, :destroy


  def join
    current_user.sessions << Session.find(params[:session_id])
    redirect_to :back
  end

  def finish
    session = Session.find(params[:session_id])
    session.finished = true
    session.save!
    redirect_to experiment_path(session.experiment) + '#sessions'
  end
  def online
    @session = Session.find(params[:session_id])
    render 'online'
  end
  def update
    update! { experiment_path(@session.experiment) + '#sessions' }
  end
  def create
    create! { experiment_path(@session.experiment) + '#sessions'  }
  end
  def destroy
    @session_id = params[:id]
    destroy!
  end
  def edit_user
    @session = Session.find(params[:session_id])
    @user = Subject.find(params[:user_id])
    @registration = Registration.find(session: @session, user: @user)
    @registration.update(permitted_edit_user_params)
    @registration.save!
  end
  def add_user
    @session = Session.find(params[:session_id])
    @users = Subject.where("email = '#{permitted_add_params[:cred]}' or gsharp = '#{permitted_add_params[:cred]}'")
    if @users.count == 1
      @user = @users.first
      @session.experiment.users << @user
      @session.users << @user
      @session.save!
      render 'add_success'
    elsif @users.count == 0
      @error_msg = 'This user cannot be found'
      render 'add_fail'
    else
      @error_msg = 'Too many found were found'
      render 'add_fail'
    end
  end
  private
  def permitted_params
    params.permit(session: [
        :start_time,
        :end_time,
        :duration,
        :required_subjects,
        :registration_deadline,
        :lab_id,
    ])
  end

end
