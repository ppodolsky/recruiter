require 'exceptions'
class ProfilesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :check_permissions
  defaults :singleton => true
  actions :show, :update

  def show
    if(current_user.profile.nil?)
      @profile = Profile.new(user: current_user)
    else
      @profile = current_user.profile
    end
    show!
  end
  def update
    if(current_user.profile.nil?)
      @profile = Profile.new(user: current_user)
    else
      @profile = current_user.profile
    end
    update!
  end

  private
    def check_permissions
      raise Exceptions::Permission.new "Only subjects can have profile" if not current_user.is_subject?
    end
    def permitted_params
      params.permit(:profile => [
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
