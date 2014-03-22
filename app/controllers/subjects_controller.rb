class SubjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    puts search_params[:subject][:profile].to_a
    @subjects = Subject.all
    respond_to do |format|
      format.js
    end
  end
  private
  def search_params
    params.permit(
      subject: [
        profile: [
          :birth_year_from => (),
          :birth_year_to => (),
          :year_started_from => (),
          :year_started_to => (),
          :years_resident_from => (),
          :years_resident_to => (),
          :current_gpa_from => (),
          :current_gpa_to => (),
          :gender => [],
          :class_year => [],
          :profession => [],
          :major => [],
          :ethnicity => []
        ],
        :attendance_gpa_from => (),
        :attendance_gpa_to => (),
        :never_been => ()
      ]
    )
  end
end
