class PasswordsController < Devise::PasswordsController
  def create
    user = User.find_by_email(resource_params[:email])
    user.reset_password
    flash[:notice] = "Email with instructions has been sent to #{resource_params[:email]}"
    redirect_to root_path
  end
  def edit
  end
end