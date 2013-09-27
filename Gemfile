source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', github: "rails/rails"
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# My gems
gem 'pg'           # datastore
gem 'responders'   # flash messages, among other things
gem 'high_voltage' # static pages

gem 'devise',  '~> 3.1.0' # authentication
gem 'rolify'              # authorization
gem 'authority'           #authorization

gem 'simple_form', '~> 3.0.0.rc'

gem 'interactor'
gem 'interactor-rails'

gem 'settingslogic' # manage application configuration
gem 'whenever'      # manage cron jobs

group :production do
  gem 'unicorn' # production server
end

group :development do
  gem 'mina', github: "nadarei/mina" # deployment
  gem 'mina-scp', github: "adie/mina-scp"

  gem 'passenger' # development server

  gem 'spring'    # don't use with `bundle exec`
  gem 'listen'    # needed for spring to watch for fsevents

  gem 'guard'
  gem 'guard-livereload'

  gem 'mailcatcher'   # swanky app for checking mail sent by your app in dev
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
