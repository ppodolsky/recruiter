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
  def update
    self.resource = User.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_resetting_password_path_for(resource)
    else
      respond_with resource
    end
  end
end