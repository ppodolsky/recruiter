class ExperimentsController < InheritedResources::Base
  actions :new, :create, :index, :show, :update, :destroy
  respond_to :js, :only => :destroy

  def destroy
    @experiment_id = params[:id]
    destroy!
  end
  private
  def permitted_params
    params.permit(experiment: [
        :name,
        :description,
        :type,
        :finished
    ])
  end
end
