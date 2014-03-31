class ManagersController < ApplicationController
  before_action :authenticate_user!
  before_action :raise_if_not_admin

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
      Assignment.where(subject_id: @manager.id, experiment: Experiment.where(finished: false).pluck(:id)).destroy_all
      Registration.where(subject_id: @manager.id, session: Session.where(finished: false).pluck(:id)).destroy_all
      @manager.type = permitted_params[:type]
      @manager.save!
      render 'add_success'
    elsif @managers.count == 0
      @error_msg = 'This user cannot be found'
      render 'add_fail'
    else
      @error_msg = 'Too many found were found'
      render 'add_fail'
    end
  end
  private
  def permitted_params
    params.permit(:cred, :type)
  end
end
