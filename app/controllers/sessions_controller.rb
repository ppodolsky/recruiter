class SessionsController < InheritedResources::Base
  belongs_to :experiment
  respond_to :js, :only => [:destroy, :add]
  actions :index, :edit, :show, :update, :create, :new, :destroy, :add

  def finish
    @session = Session.find(params[:session_id])
    @session.finished = true
    @session.save!
    redirect_to :back
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
  def add
    @session = Session.find(params[:session_id])
    @subjects = Subject.where("email = '#{permitted_add_params[:cred]}' or gsharp = '#{permitted_add_params[:cred]}'")
    if @subjects.count == 1
      @subject = @subjects.first
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
  def permitted_add_params
    params.permit(:cred)
  end
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
