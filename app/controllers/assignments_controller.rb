class AssignmentsController < InheritedResources::Base
  respond_to :js, :only => [:update]
  actions :update

  def update
    assignment = Assignment.find([params[:user_id], params[:experiment_id]])
    assignment.update!(permitted_params)
  end

  def permitted_params
    params.permit(
        :current_session
    )
  end
end
