class SessionsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :raise_if_not_experimenter, only: [:online, :finish, :update, :create, :new, :destroy, :show]
  belongs_to :experiment
  respond_to :js, :only => [:destroy]
  actions :index, :edit, :show, :update, :create, :new, :destroy


  def join
    @opened = Session
    .where(id: params[:session_id])
    .where(experiment_id: current_user.experiments)
    .where('registration_deadline > ?', Time.now)
    .where.not(id: current_user.sessions)
    .where.not(experiment_id: current_user.sessions.pluck(:experiment_id))
    if(@opened.count == 1)
      current_user.sessions << @opened.first
    end
    redirect_to :back
  end

  def finish
    @session = Session.find(params[:session_id])
    @session.finished = true
    @session.save!
    redirect_to experiment_path(@session.experiment) + '#sessions'
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
  def edit_subject
    @session = Session.find(params[:session_id])
    @subject = Subject.find(params[:subject_id])
    @registration =  Registration.find(session: @session, user: @subject)
    @registration.update(permitted_edit_subject_params)
    @registration.save!
  end
  def add_subject
    @session = Session.find(params[:session_id])
    @subjects = Subject.where("email = '#{permitted_add_params[:cred]}' or gsharp = '#{permitted_add_params[:cred]}'")
    if @subjects.count == 1
      @subject = @subjects.first
      @session.experiment.subjects << @subject
      @session.subjects << @subject
      @session.save!
      render 'add_success'
    elsif @subjects.count == 0
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
