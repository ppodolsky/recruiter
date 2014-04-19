class RegistrationsController < InheritedResources::Base
  respond_to :js, :only => [:create, :update]
  actions :create, :update
  def create
    @session = Session.find(params[:session_id])
    @users = Subject.where("(
      email = '#{permitted_params[:cred]}' or
      gsharp = '#{permitted_params[:cred]}')")
    if @users.count == 0
      @error_msg = "Subject not found"
      render 'create_fail'
    else
      @user = @users.first
      if @session.users.exists?(id: @user.id) then
        @error_msg = "Already added"
        render 'create_fail'
      else
        @registration = Registration.new(user_id: @user.id, session_id: @session.id)
        create!
      end
    end
  end

  def permitted_params
    params.permit(:cred, :session_id, registration: [:shown_up, :participated, :paid])
  end
end
