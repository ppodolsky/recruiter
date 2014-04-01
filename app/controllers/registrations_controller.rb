class RegistrationsController < Devise::RegistrationsController
  before_action :create_if_nil, only: [:edit,:update]
  before_action :configure_permitted_parameters

  def after_update_path_for(resource)
  end
  def update
    @user = resource
    profile_params = permitted_profile_params[:profile]
    user_params = devise_parameter_sanitizer.sanitize(:account_update)
    # We've got a problem right now. If we try to update @user directly
    # by @user.update(permitted_params), then unique validation of nested
    # profile starts AFTER the update experession. It fails, because
    # new secondary email IS SUDDENLY equals to new secondary email HOT DAMN SHIT
    puts permitted_profile_params[:profile]
    if(profile_params.present?) then
      @user.profile.update(profile_params)
    end
    if user_params.present?
      if needs_password?(@user, user_params)
        @user.update_with_password(user_params)
      else
        user_params.delete :current_password
        @user.update_without_password(user_params)
      end
    end
    render "edit"
  end

  def create_if_nil
    if resource.is_subject? then
      resource.build_profile if resource.profile.nil?
    end
  end
  def permitted_profile_params
    params.permit(:profile => [
                       :secondary_email,
                       :phone,
                       :gender,
                       :ethnicity,
                       :birth_year,
                       :class_year,
                       :year_started,
                       :current_gpa,
                       :years_resident,
                       :profession,
                       :major
                ])
  end
  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    (params[:email].present? and user.email != params[:email]) or
    params[:password].present?
  end
  def configure_permitted_parameters
    registration_params = [:first_name, :last_name, :gsharp, :second_name, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
          |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
          |u| u.permit(registration_params)
      }
    end
  end
end