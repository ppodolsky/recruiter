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
