class PasswordsController < Devise::PasswordsController
  def create
    is_secondary = false
    user = User.find_by_email(resource_params[:email])
    if user.nil?
      is_secondary = true
      user = User.find_by_secondary_email(resource_params[:email])
    end
    if user.present?
      user.reset_password(secondary_email: is_secondary)
      flash[:notice] = "Email with instructions has been sent to #{resource_params[:email]}"
    else
      flash[:error] = "Email #{resource_params[:email]} is not registered"
    end
    redirect_to root_path
  end
  def edit
    self.resource = User.new
    resource.reset_password_token = params[:reset_password_token]
  end
end