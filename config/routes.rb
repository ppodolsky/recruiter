Recruiter::Application.routes.draw do

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  # user accounts and profiles
  devise_for :users, :controllers => { :registrations => :registrations }

  resources :sessions do
    get 'online', to: 'sessions#online'
    post 'finish', to: 'sessions#finish'
    post 'add', to: 'sessions#add'
  end

  get 'managers', to: 'managers#index'
  get 'managers/find', to: 'managers#find'
  post 'managers', to: 'managers#add'
  delete 'managers/:manager', to: 'managers#destroy', as: 'manager'


  get 'experiments/all', to: 'experiments#all', as: 'experiments_all'

  resources :experiments do
    post 'subjects', to: 'subjects#assign'
    get 'subjects', to: 'subjects#index'
    get 'invite', to: 'experiments#invite'
    delete 'subjects', to: 'subjects#destroy_all'
    delete 'subjects/:subject', to: 'subjects#destroy', as: 'subject'
    post 'remained', to: 'subjects#remained'
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
  root to: 'pages#login'                        #
end
