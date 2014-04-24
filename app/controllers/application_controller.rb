require 'exceptions'
require 'application_responder'
class ApplicationController < ActionController::Base
  self.responder = ActionController::Responder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    return experiments_path if user.is_experimenter?
    return edit_user_registration_path
  end
  protected
  def raise_if_not_admin
    raise Exceptions::Permission.new "Only administrators can access this action" if not current_user.is_administrator?
  end
  def raise_if_not_experimenter
    raise Exceptions::Permission.new "Only experimenters can access this action" if not current_user.is_experimenter?
  end
  def raise_if_not_subject
    raise Exceptions::Permission.new "Only subjects can access this action" if not current_user.is_subject?
  end
end
