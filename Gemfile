source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', github: "rails/rails"
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# My gems
gem 'pg'           # datastore
gem 'slim-rails'   # slim templating, generate templates
gem 'kramdown'     # for slim's markdown engine
gem 'responders'   # flash messages, among other things
gem 'high_voltage', github: "thoughtbot/high_voltage" # static pages
gem 'bootstrap-sass', :github => 'thomas-mcdonald/bootstrap-sass' # style

gem 'devise',  '~> 3.1.0' # authentication
gem 'rolify'              # authorization
gem 'authority'           #authorization

gem 'inherited_resources'

gem 'simple_form', '~> 3.0.0.rc'

gem 'interactor'
gem 'interactor-rails'

gem 'settingslogic' # manage application configuration
gem 'whenever'      # manage cron jobs

gem 'attribute_normalizer' # various utilities to clean data

group :production do
  gem 'unicorn', :require => false # production server
end

group :development do
  gem 'sqlite3' # database for general development branch

  gem 'mina', github: "nadarei/mina", :require => false  # deployment
  gem 'mina-scp', github: "adie/mina-scp", :require => false

  gem 'passenger' # development server

  gem 'mailcatcher', :require => false    # swanky app for checking mail sent by your app in dev
  gem 'quiet_assets' # make logs a little more readable

  gem 'better_errors'       # nice debug pages
  gem 'binding_of_caller'   # optional dependency for better_errors

  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git', :require => false
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
