class RegistrationsController < InheritedResources::Base
  respond_to :js, :only => [:create]
  respond_to :json, :only => [:update]
  actions :create, :update
  def create
    @session = Session.find(params[:session_id])
    @users = Subject.find_by_cred(params[:cred])
    if @users.count == 0
      @error_msg = "Subject not found"
      render 'create_fail'
    else
      @user = @users.first
      @registration = Registration.new(user_id: @user.id, session_id: @session.id)
      if not @registration.valid?
        @error_msg = @registration.errors.messages[:session].first
        render 'create_fail'
      else
        create!
      end
    end
  end
  def update
    @registration = Registration.find(params[:id].split(','))
    update!
  end

  def permitted_params
    params.permit(:cred, :session_id, registration: [:shown_up, :participated, :paid])
  end
end
