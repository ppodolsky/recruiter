require "application_responder"

class ApplicationController < ActionController::Base
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
end
