source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# My gems
gem 'passenger'                                         # server

gem 'responders'                                        # flash messages
gem 'high_voltage'                                      # static pages

gem 'mongoid',          github: 'mongoid/mongoid'       # database
gem 'bson_ext'                                          # needed by mongoid
gem 'mongoid-paranoia', github: 'simi/mongoid-paranoia'

gem 'simple_form', '~> 3.0.0.rc'
gem 'kramdown'     # copy styling

gem 'interactor'
gem 'interactor-rails'

gem 'devise',  '~> 3.1.0' # authentication
gem 'rolify'              # authorization
gem 'authority'           #authorization

# dev
group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'guard'
  gem 'guard-livereload'
end

# test
group :test do
  gem 'minitest-rails'
end

# production
group :production do
  gem 'rack-cache'
end
