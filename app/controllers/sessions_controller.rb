class SessionsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :raise_if_not_experimenter, only: [:online, :finish, :update, :create, :new, :destroy, :show]

  belongs_to :experiment
  respond_to :js, :only => [:send_message]

  actions :assigned, :edit, :show, :update, :create, :new, :destroy

  def join
    current_user.sessions << Session.find(params[:session_id])
    redirect_to :back
  end
  def finish
    session = Session.find(params[:session_id])
    session.finished = true
    session.save!
    redirect_to session_online_path(session)
  end
  def online
    @session = Session.find(params[:session_id])
    respond_to do |format|
      format.html do
        render 'online'
      end
    end
  end
  def report
    @session = Session.find(params[:session_id])
    respond_to do |format|
      format.pdf do
        render :pdf => 'pdf_report', :template => 'sessions/report.pdf.slim'
      end
    end
  end
  def send_message
    session = Session.find(params[:session_id])
    users = session.users
    users.all.each do |user|
      UserMailer.delay.send_custom(user.email, params[:subject], params[:email][:value])
    end
  end
  def create
    create! { experiment_path(@session.experiment) + '#sessions'  }
  end
  def update
    update! { experiment_path(@session.experiment) + '#sessions'  }
  end
  def destroy
    destroy! { experiment_path(@session.experiment) + '#sessions'}
  end
  private
  def permitted_params
    params.permit(session: [
        :start_time,
        :end_time,
        :duration,
        :remind_at,
        :required_subjects,
        :registration_deadline,
        :lab_id,
        :reservation
    ])
  end

end
