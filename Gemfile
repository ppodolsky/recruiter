source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# My gems

gem 'bson_ext'     # needed by mongoid
gem 'sass'         # stylesheet processor
gem 'devise'       # authentication
gem 'cancan'       # authorization
gem 'high_voltage' # static pages
gem 'mongoid',          github: 'mongoid/mongoid' # database
gem 'mongoid-paranoia', github: 'simi/mongoid-paranoia' # before first release
gem 'actionpack-action_caching'
gem 'actionpack-page_caching'

# test
group :test do
  gem 'minitest-rails'
end

# dev
group :development do
  gem 'powder'
  gem 'git-up'
end
