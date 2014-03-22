class SessionsController < InheritedResources::Base
  belongs_to :experiment
  respond_to :js, :only => :destroy
  actions :index, :edit, :show, :update, :create, :new, :destroy

  def update
    update! { experiment_path @session.experiment }
  end
  def create
    create! { experiment_path @session.experiment }
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
