Recruiter::Application.routes.draw do
  # user accounts and profiles
  devise_for :users
  scope :users do
    resource :profile
  end
end
