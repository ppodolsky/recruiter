require "application_responder"

class ApplicationController < ActionController::Base
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  self.responder = ActionController::Responder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    return dashboard_path if user.is_administrator?
    return experiments_path if user.is_experimenter?
    return profile_path
  end

  protected

  def configure_devise_permitted_parameters
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
