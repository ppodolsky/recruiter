class PagesController < InheritedResources::Base

  before_action :load_user_resource
  before_action :raise_if_not_admin, only: [:create, :update, :assigned, :edit, :new]
  actions :create, :update, :index, :show, :edit, :new

  def index
    if not user_signed_in?
      redirect_to '/users/login'
    else
      redirect_to self.after_sign_in_path_for(current_user)
    end
  end
  def show
    @page = Page.friendly.find(params[:id])
    show!
  rescue ActiveRecord::RecordNotFound => e
    if @user.is_administrator? then
      @page = Page.new(name: params[:id].to_s.capitalize)
      render 'new'
    else
      raise e
    end
  end
  def edit
    @page = Page.friendly.find(params[:id])
    edit!
  end
  def update
    @page = Page.friendly.find(params[:id])
    update!
  end

  private

  def permitted_params
    params.permit(:page => [:name, :content])
  end

  def load_user_resource
    @user = current_user || User.new
  end
end
