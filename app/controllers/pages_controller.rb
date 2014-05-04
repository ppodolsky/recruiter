class PagesController < InheritedResources::Base
  # Unfortunately, we need to load two objects for most of these actions. The
  # one CRUD cares about is @page, but our site-wide modal sign-up and sign-in
  # need access to @user.
  before_action :load_user_resource

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

  def edit
    @page = Page.friendly.find(params[:id])
    edit!
  end

  def dashboard
  end

  private

  def permitted_params
    defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  end

  def load_user_resource
    @user = current_user || User.new
  end
end
