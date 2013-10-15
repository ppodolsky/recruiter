Recruiter::Application.routes.draw do
  devise_for :users
  resources :users do
    resource :profile
  end

  root :to => 'pages#show', :id => 'welcome'
  get "/*id" => 'pages#show', :as => :page, :format => false
end
