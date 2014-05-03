class LabsController < InheritedResources::Base
  respond_to :json, :only => [:create, :update]

  actions :create, :update

  def permitted_params
    params.permit(:lab => [:name])
  end
end
