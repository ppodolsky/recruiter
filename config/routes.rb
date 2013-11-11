Recruiter::Application.routes.draw do
  # user accounts and profiles
  devise_for :users
  scope :users do
    resource :profile
  end

  # static content pages, provided by high_voltage
  root :to => 'pages#show', :id => 'welcome'
  get "/*id" => 'pages#show', :as => :page, :format => false
end
