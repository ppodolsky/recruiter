require 'exceptions'
class ProfilesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :check_permissions
  before_action :create_if_nil
  defaults :singleton => true
  actions :show, :update

  private
    def create_if_nil
      if(current_user.profile.nil?)
        @profile = Profile.new(user: current_user)
      else
        @profile = current_user.profile
      end
    end
    def check_permissions
      raise Exceptions::Permission.new "Only subjects can have profile" if not current_user.is_subject?
    end
    def permitted_params
      params.permit(:profile => [
        :secondary_email,
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
