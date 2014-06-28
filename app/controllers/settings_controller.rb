class SettingsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :raise_if_not_admin

  def index
    @dictionaries = [Category, Lab, Major, Profession]
  end

end
