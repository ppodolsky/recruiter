class EmailsController < InheritedResources::Base
  respond_to :json, :only => [:create, :update]

  actions :create, :update

  def permitted_params
    params.permit(:email => [:value, :subject])
  end
end
