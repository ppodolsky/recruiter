class ProfilesController < InheritedResources::Base
  # before_filter :authenticate_user!
  defaults singleton: true
  belongs_to :user
  actions :all, :except => [:index, :destory]

  private
    def permitted_params
      params.permit(:profile => [
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
        :profession])
    end
end
