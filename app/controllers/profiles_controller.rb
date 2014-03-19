class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    nonempty_params = search_params.reject{|a| search_params[a] == ''}
    @profiles = Profile.where(nonempty_params)
    respond_to do |format|
      format.js
    end
  end
  def show
    if(current_user.profile.nil?)
      @profile = Profile.new
    else
      @profile = current_user.profile
    end
  end
  def update
    @profile = current_user.profile
    @profile.update! permitted_params
    render 'profiles/show'
    flash[:notice] = 'Please, correct fields marked by red color'
  rescue
    render 'profiles/show'
  end
  def create
    @profile = Profile.create(user_id: current_user.id)
    @profile.update! permitted_params
    render 'profiles/show'
  rescue
    flash[:notice] = 'Please, correct fields marked by red color'
    render 'profiles/show'
  end

  private
    def permitted_params
      params.permit(profile: [
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
