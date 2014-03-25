Recruiter::Application.routes.draw do

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  # user accounts and profiles
  devise_for :users

  resources :sessions

  get 'experiments/all', to: 'experiments#all'
  resources :experiments do
    post 'subjects', to: 'subjects#assign'
    get 'subjects', to: 'subjects#index'
    delete 'subjects', to: 'subjects#delete'
    delete 'subjects/:subject_id', to: 'subjects#delete'
    post 'left', to: 'subjects#left'
    resources :sessions do
      get 'online', to: 'sessions#online'
    end
  end
  resource :profile, only: [:show, :create, :update]


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
