class AssignmentsController < InheritedResources::Base
  respond_to :json, :only => [:update]
  actions :update

  def update
    @assignment = Assignment.find([params[:user_id], params[:experiment_id]])
    update!
  end
  def permitted_params
    params.permit(:assignment => [:current_session])
  end
end
