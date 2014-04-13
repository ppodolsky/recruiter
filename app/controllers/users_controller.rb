class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :raise_if_not_admin
  respond_to :js, :only => [:add, :update, :find]

  def index_managers
    @users = User.where(type: %w[Administrator Experimenter])
    render 'index'
  end
  def find
    @users = User.where("email LIKE '%#{permitted_params[:user][:cred]}%' or gsharp LIKE '%#{permitted_params[:user][:cred]}%'")
  end
  def update
    @user = User.find(params[:id])
    @generic_user = @user.becomes(User)
    @generic_user.update(permitted_params[:user])
    @generic_user.save!
  end
  def add
    find
    if @users.count == 1
      @user = @users.first
      params[:id] = @user.id
      params[:user].delete :cred
      update
    elsif @users.count == 0
      @error_msg = 'This user cannot be found'
      render 'add_fail'
    else
      @error_msg = 'Too many were found'
      render 'add_fail'
    end
  end
  private
  def permitted_params
    params.permit(:id, :user => [:cred, :type])
  end
end