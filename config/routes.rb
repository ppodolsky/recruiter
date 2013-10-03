Recruiter::Application.routes.draw do
  devise_for :users
  root :to => 'pages#show', :id => 'welcome'

  resources :users do
    resource :profile
  end
end
