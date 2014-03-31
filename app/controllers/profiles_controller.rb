require 'exceptions'
class ProfilesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :raise_if_not_subject
  before_action :create_if_nil
  defaults :singleton => true
  actions :show, :update

  def create_if_nil
    if(current_user.profile.nil?)
      @profile = Profile.new(user: current_user)
    else
      @profile = current_user.profile
    end
  end
  private
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
        :major,
        :user_attributes => [
            :first_name,
            :last_name,
            :gsharp
        ],
      ])
    end
  private
end
