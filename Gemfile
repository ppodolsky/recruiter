source 'https://rubygems.org'
ruby '2.1.2'

##
# Rails
##

# http://rubyonrails.org/
gem 'rails', '4.1.1'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier'
gem 'coffee-rails'
##

##
# Backend
##

# https://github.com/bernat/best_in_place
gem 'best_in_place', :git => 'https://github.com/aaronchi/best_in_place.git'

# http://unicorn.bogomips.org/
gem 'unicorn', group: :production # server

# heroku dependencies
gem 'rails_12factor', group: :production

# https://bitbucket.org/ged/ruby-pg/wiki/Home
gem 'pg' # datastore

# https://github.com/drnic/composite_primary_keys
gem 'composite_primary_keys'

# https://github.com/josevalim/inherited_resources
gem 'inherited_resources' # DRY controllers

# https://github.com/mdeering/attribute_normalizer
gem 'attribute_normalizer', github: 'mdeering/attribute_normalizer' # various utilities to clean data

# https://github.com/mbleigh/seed-fu
gem 'seed-fu', github: 'mbleigh/seed-fu' # for seed data

# https://github.com/norman/friendly_id
gem 'friendly_id', '~> 5.0.0' # slugs

# https://github.com/PashaPodolsky/rails-bootstrap-markdown
gem 'rails-bootstrap-markdown', github: 'PashaPodolsky/rails-bootstrap-markdown'

# https://github.com/huacnlee/social-share-button
gem 'social-share-button'

# https://github.com/mislav/will_paginate
gem 'will_paginate', '~> 3.0'

# https://github.com/mileszs/wicked_pdf
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'

# https://github.com/airblade/paper_trail
gem 'paper_trail', '~> 3.0.0'
##

##
# Frontend
##

# https://github.com/indirect/jquery-rails
gem 'jquery-rails'

# https://github.com/joliss/jquery-ui-rails
gem 'jquery-ui-rails'

# https://github.com/slim-template/slim-rails
gem 'slim-rails' # slim templating, generate templates

# https://github.com/gettalong/kramdown
gem 'kramdown' # for slim's markdown engine

# https://github.com/plataformatec/responders
gem 'responders' # flash messages, among other things

# https://github.com/decioferreira/bootstrap-generators
gem 'bootstrap-generators', github: 'decioferreira/bootstrap-generators'
##

##
# Authentication, authorization
##

# http://devise.plataformatec.com.br/
gem 'devise', '~> 3.1.0' # authentication

# https://github.com/nathanl/authority
gem 'authority'
##

##
# Utitlities
##

# https://github.com/collectiveidea/delayed_job
gem 'delayed_job'
gem 'daemons' # required

# https://github.com/collectiveidea/delayed_job_active_record
gem 'delayed_job_active_record'

# https://github.com/mhfs/devise-async
gem 'devise-async' # send e-mails in background

# https://github.com/matthuhiggins/foreigner
gem 'foreigner'

# https://github.com/binarylogic/settingslogic
gem 'settingslogic' # manage application configuration, useful for whitelabeling

# https://github.com/schneems/maildown
gem 'maildown'

# https://github.com/37signals/mail_view
# this shouldn't be outside development, but otherwise we get constant errors in
# production
gem 'mail_view'
##

group :development do
  # http://nadarei.co/mina/
  gem 'mina',     github: "nadarei/mina",  :require => false # deployment

  # https://github.com/adie/mina-scp
  gem 'mina-scp', github: "adie/mina-scp", :require => false

  # https://github.com/evrone/quiet_assets
  gem 'quiet_assets' # make logs a little more readable

  # https://github.com/charliesome/better_errors
  gem "better_errors"
  gem "binding_of_caller" # required

  # https://github.com/presidentbeef/brakeman
  gem 'brakeman', :require => false

  # https://github.com/guard/guard-livereload
  gem 'guard-livereload', require: false
  gem "rack-livereload"

  # https://github.com/ranmocy/guard-rails
  gem 'guard-rails'

    # https://github.com/guard/guard-bundler
  gem 'guard-bundler'

  # https://github.com/guard/guard-rspec
  gem 'guard-rspec'

  # https://github.com/sporkrb/spork-rails
  gem 'spork-rails'

  # https://github.com/guard/guard-spork
  gem 'guard-spork'

  # https://github.com/preston/railroady
  gem 'railroady' # erd generator
end


group :development, :test do
  # https://github.com/bkeepers/dotenv
  gem 'dotenv-rails'

  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails'

  # https://github.com/jnicklas/capybara
  gem 'capybara'

  # https://github.com/bmabey/database_cleaner
  gem 'database_cleaner'

  # https://github.com/suranyami/guard-delayed
  gem 'guard-delayed', github: 'jasl/guard-delayed'
end

group :darwin do
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', require: false
end

group :linux do
  gem 'rb-inotify'
  gem 'libnotify'
end
