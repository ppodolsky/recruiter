class ExperimentsController < InheritedResources::Base
  before_action :authenticate_user!
  actions :index,:show,:update

  def index
    @experiments = Session.all
  end
  def edit
    @experiment = Session.find(params[:id])
  end
end
