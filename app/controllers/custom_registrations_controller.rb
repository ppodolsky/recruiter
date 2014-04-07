class CustomRegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def after_update_path_for(resource)
  end
  def update
    @user = resource
    user_params = devise_parameter_sanitizer.sanitize(:account_update)
    if needs_password?(@user, user_params)
      @user = @user.becomes(User)
      @user.update_with_password(user_params)
    else
      user_params.delete :current_password
      @user.update_without_password(user_params)
    end
    render "edit"
  end
  def needs_password?(user, params)
    (params[:email].present? and user.email != params[:email]) or
    (params[:first_name].present? and user.first_name != params[:first_name]) or
    (params[:last_name].present? and user.last_name != params[:last_name]) or
    (params[:gsharp].present? and user.gsharp != params[:gsharp]) or
    params[:password].present?
  end
  def configure_permitted_parameters
    registration_params = [:first_name,
                           :last_name,
                           :gsharp,
                           :second_name,
                           :email,
                           :password,
                           :password_confirmation,
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
                           :major,
                           :type]
    devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
    }
    devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
    }
  end
end