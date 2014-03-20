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
  def permitted_params
    params.permit(subject: [
        :attendance,
        profile: [
          :secondary_email,
          :first_name,
          :last_name,
          :phone,
          :gender,
          :ethnicity,
          :birth_year,
          :class_year,
          :year_started,
          :current_gpa,
          :years_resident,
          :profession,
          :major
        ]
    ])
  end
  private
  def search_params
    params.permit(
        :gender,
        :birth_year,
        :class_year,
        :year_started,
        :current_gpa,
        :years_resident,
        :profession,
        :major,
        :ethnicity => []
    )
  end
end
