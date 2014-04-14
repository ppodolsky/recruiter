Recruiter::Application.routes.draw do

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  # user accounts and profiles
  devise_for :users, :controllers => { :registrations => "custom_registrations" },
             :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  resources :sessions do
    get 'online', to: 'sessions#online'
    post 'finish', to: 'sessions#finish'
    resources :subjects
    resources :registrations
  end

  get 'managers', to: 'users#index_managers'

  get 'timeline', to: 'timeline#index'
  get 'calendar', to: 'timeline#calendar'

  resources :users, only:[:update, :add, :find]
  get 'users/find', to: 'users#find'
  post 'users/add', to: 'users#add'
  put 'users/:id', to: 'users#update'

  get 'experiments/all', to: 'experiments#all', as: 'experiments_all'
  resources :experiments do
    post 'subjects', to: 'subjects#assign'
    get 'subjects', to: 'subjects#index'
    get 'invite', to: 'experiments#invite'
    delete 'subjects', to: 'subjects#destroy_all'
    delete 'subjects/:subject', to: 'subjects#destroy', as: 'subject'
    post 'subjects/remained', to: 'subjects#remained'
    resources :sessions
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
