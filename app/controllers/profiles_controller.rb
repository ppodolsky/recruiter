class ProfilesController < InheritedResources::Base
  before_action :authenticate_user!
  actions :show, :update, :create

  def show
    if(current_user.profile.nil?)
      @profile = Profile.new
    else
      @profile = current_user.profile
    end
  end
  def update
    @profile = current_user.profile
    @profile.update(profile_params)
    @profile.save
    flash[:notice] = 'Profile has been saved'
    redirect_to :back
  end
  def create
    @profile = Profile.new(profile_params)
    @profile.update(user_id: current_user.id)
    @profile.save
    flash[:notice] = 'Profile has been saved'
    redirect_to :back
  end

  private
    def profile_params
      params.require(:profile).permit(
        :secondary_email,
        :first_name,
        :last_name,
        :phone,
        :gender,
        :ethnicity,
        :birth_year,
        :class_year,
        :total_years,
        :year_started,
        :current_gpa,
        :years_resident,
        :profession,
        :major
      )
    end
end
