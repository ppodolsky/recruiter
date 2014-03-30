class ManagersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permissions

  def index
    @managers = User.where(type: %w[Administrator Experimenter])
    render 'index'
  end
  def find
    @managers = User.where("email LIKE '%#{permitted_params[:cred]}%' or gsharp LIKE '%#{permitted_params[:cred]}%'")
  end
  def add
    @managers = User.where("email = '#{permitted_params[:cred]}' or gsharp = '#{permitted_params[:cred]}'")
    if @managers.count == 1
      @manager = @managers.first
      @manager.type = permitted_params[:type]
      @manager.save!
      index
    else @managers.count != 1
      render 'add_fail'
    end
  end
  def check_permissions
    raise Exceptions::Permission.new "Only administrators can manage this list" if not current_user.is_administrator?
  end
  private
  def permitted_params
    params.permit(:cred, :type)
  end
end
