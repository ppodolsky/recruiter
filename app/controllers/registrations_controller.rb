class RegistrationsController < InheritedResources::Base
  respond_to :js, :only => [:create, :update]
  actions :create, :update
  def create
    @session = Session.find(params[:session_id])
    @subjects = Subject.where("(
      email = '#{permitted_params[:cred]}' or
      gsharp = '#{permitted_params[:cred]}')")
    if @subjects.count == 0
      @error_msg = "Subject not found"
      render 'create_fail'
    else
      @subject = @subjects.first
      if @session.subjects.exists?(id: @subject.id) then
        @error_msg = "Already added"
        render 'create_fail'
      else
        @registration = Registration.new(user_id: @subject.id, session_id: @session.id)
        create!
      end
    end
  end

  def permitted_params
    params.permit(:cred, :session_id, registration: [:shown_up, :participated, :paid])
  end
end
