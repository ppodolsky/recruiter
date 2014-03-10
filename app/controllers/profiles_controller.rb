class ProfilesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_current_profile
  actions :show, :update

  def set_current_profile
    @user = current_user
    @profile = @user.profile
  end

  def update
    redirect_to :back
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
        :age,
        :class_year,
        :total_years,
        :year_started,
        :current_gpa,
        :years_resident,
        :profession,
        :major])
    end
end
