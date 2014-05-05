class PagesController < InheritedResources::Base

  before_action :load_user_resource
  respond_to :json, :only => [:create, :update]
  actions :create, :update, :index, :show

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
  end
  def update
    @page = Page.friendly.find(params[:id])
    update!
  end

  private

  def permitted_params
    params.permit(:page => [:name, :value])
  end

  def load_user_resource
    @user = current_user || User.new
  end
end
