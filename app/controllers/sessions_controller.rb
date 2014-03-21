class SessionsController < InheritedResources::Base
  belongs_to :experiment
  respond_to :js, :only => :destroy
  actions :index, :show, :update, :create, :new, :destroy

  def update
    update! do |success, failure|
      success.html { redirect_to experiment_path @session.experiment }
      failure.html { render 'sessions/show' }
    end
  end
  def create
    create! do |success, failure|
      success.html { redirect_to experiment_path @session.experiment }
      failure.html { render 'sessions/show' }
    end
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
