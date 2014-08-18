Recruiter::Application.routes.draw do

  # user accounts and profiles
  devise_for :users, :controllers => { :passwords => 'passwords', :registrations => 'custom_registrations' , :confirmations => 'confirmations'},
             :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get 'dictionaries/:id', to: 'dictionaries#show', as: :dictionary
  post 'dictionaries/:dictionary_id/:item_id', to: 'dictionaries#update', as: :dictionary_item
  get 'dictionaries', to: 'dictionaries#index'

  get 'settings', to: 'settings#index'

  put 'labs/:id', to: 'labs#update', as: 'lab'
  put 'labs', to: 'labs#create', as: 'labs'
  put 'categories/:id', to: 'categories#update', as: 'category'
  put 'categories', to: 'categories#create', as: 'categories'
  put 'majors/:id', to: 'majors#update', as: 'major'
  put 'majors', to: 'majors#create', as: 'majors'
  put 'professions/:id', to: 'professions#update', as: 'profession'
  put 'professions', to: 'professions#create', as: 'professions'
  put 'emails/:id', to: 'emails#update', as: 'email'
  put 'emails', to: 'emails#create', as: 'emails'

  resources :sessions do
    get 'report'
    get 'online', to: 'sessions#online'
    post 'finish', to: 'sessions#finish'
    delete 'users/:user_id', to: 'users#unregister', as: 'user'
    post 'users/:user_id', to: 'users#register'
    post 'join', to: 'sessions#join'
    resources :registrations
  end

  get 'timeline', to: 'timeline#index'


  post 'invite', to: 'users#invite_users', as: 'invite'
  get 'users/:id/reset', to: 'users#reset_user', as: 'user_reset'
  post 'users/reset', to: 'users#reset_users', as: 'users_reset'
  post 'users/deactivate', to: 'users#deactivate', as: 'users_deactivate'
  resources :users, only: [:index, :update, :search, :show]

  get 'experiments/all', to: 'experiments#all', as: 'experiments_all'
  get 'experiments/calendar', to: 'experiments#calendar'

  post 'assignments/:user_id,:experiment_id', to: 'assignments#update'
  resources :experiments do
    post 'users', to: 'users#assign'
    delete 'users/:user_id', to: 'users#unassign', as: 'user'
    get 'users', to: 'users#assigned'
    get 'invite', to: 'experiments#invite'
    post 'invite', to: 'experiments#send_invite'
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
  resources :pages, path: ''                    #
  root to: 'pages#index'                        #
end
