class SubjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    nonempty_params = search_params.reject{|a| search_params[a] == ''}
    @profiles = Profile.where(nonempty_params)
    respond_to do |format|
      format.js
    end
  end
  private
  def search_params
    params.permit(
        :gender => [],
        :birth_year => (),
        :class_year => (),
        :year_started => (),
        :current_gpa => (),
        :years_resident => (),
        :profession => [],
        :major => [],
        :ethnicity => []
    )
  end
end
