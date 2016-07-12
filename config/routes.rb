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
		post 'send_message', to: 'sessions#send_message'
		delete 'users/:user_id', to: 'users#unregister', as: 'user'
		post 'users/:user_id', to: 'users#register'
		post 'join', to: 'sessions#join'
		resources :registrations
	end

	get 'timeline', to: 'timeline#index'


	post 'invite', to: 'users#invite_users', as: 'invite'
	post 'remind_to_fill', to: 'users#remind_to_fill_users', as: 'remind_to_fill'
	get 'users/:id/reset', to: 'users#reset_user', as: 'user_reset'
	post 'users/reset', to: 'users#reset_users', as: 'users_reset'
	get 'users/suspended', to: 'users#suspended', as: 'users_suspended'
	post 'users/deactivate', to: 'users#deactivate_users', as: 'users_deactivate'
	post 'users/unsuspend', to: 'users#unsuspend_users', as: 'users_unsuspend'
	get 'users/:id/suspend', to: 'users#suspend_user', as: 'suspend_user'
	get 'users/:id/unsuspend', to: 'users#unsuspend_user', as: 'unsuspend_user'
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
		get 'assigned', to: 'experiments#assigned'
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

# additional api for the app
	namespace :api do
		namespace :v1 do
			post 'user/login', to: 'user#login'
			post 'user/index', to: 'user#index'
			post 'user/update_account', to: 'user#update_account'
			post 'user/update_personal', to: 'user#update_personal'
			post 'user/update_education', to: 'user#update_education'
			post 'user/registration', to: 'user#registration'
			post 'calendar/index', to: 'calendar#index'
			post 'session/join', to: 'session#join'
		end
	end


	# light CMS
	# http://railscasts.com/episodes/117-semi-static-pages-revised
	# WARNING: order is crucial, do not rearrange #
	resources :pages, path: ''                    #
	root to: 'pages#index'                        #
end
