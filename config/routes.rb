Recruiter::Application.routes.draw do

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  # user accounts and profiles
  devise_for :users, :controllers => { :registrations => "custom_registrations" },
             :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get 'dictionaries/:id', to: 'dictionaries#show', as: :dictionary
  post 'dictionaries/:dictionary_id/:item_id', to: 'dictionaries#update', as: :dictionary_item
  get 'dictionaries', to: 'dictionaries#index'
  resources :labs, only: [:create, :update]
  resources :categories, only: [:create, :update]



  resources :sessions do
    get 'online', to: 'sessions#online'
    post 'finish', to: 'sessions#finish'
    delete 'users/:user_id', to: 'users#unregister', as: 'user'
    post 'users/:user_id', to: 'users#register'
    post 'join', to: 'sessions#join'
    resources :registrations
  end

  get 'timeline', to: 'timeline#index'

  resources :users, only: [:index, :update, :search, :show]

  get 'experiments/all', to: 'experiments#all', as: 'experiments_all'
  get 'experiments/calendar', to: 'experiments#calendar'

  post 'assignments/:user_id,:experiment_id', to: 'assignments#update'
  resources :experiments do
    post 'users', to: 'users#assign'
    delete 'users/:user_id', to: 'users#unassign', as: 'user'
    get 'users', to: 'users#assigned'
    get 'invite', to: 'experiments#invite'
    get 'send_invite', to: 'experiments#send_invite'
    delete 'users', to: 'users#unassign_all'
    post 'users/remained', to: 'users#remained'
    resources :sessions do
      post 'users', to: 'users#register'
    end
  end

  # static page overrides for CMS
  get 'help',      to: 'pages#help'
  get 'dashboard', to: 'pages#dashboard'

  # light CMS
  # http://railscasts.com/episodes/117-semi-static-pages-revised
  # WARNING: order is crucial, do not rearrange #
  get ':id', to: 'pages#show', as: :page        #
  resources :pages, except: [:index, :show]     #
  root to: 'pages#index'                        #
end
