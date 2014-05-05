class ProfessionsController < InheritedResources::Base
  respond_to :json, :only => [:create, :update]

  actions :create, :update

  def permitted_params
    params.permit(:profession => [:name])
  end
end
