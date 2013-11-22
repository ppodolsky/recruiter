source 'https://rubygems.org'
ruby '2.0.0'

##
# Rails
##

# http://rubyonrails.org/
gem 'rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
##

##
# Backend
##

# http://unicorn.bogomips.org/
gem 'unicorn', require: false, group: :production # server

# https://bitbucket.org/ged/ruby-pg/wiki/Home
gem 'pg' # datastore

# https://github.com/josevalim/inherited_resources
gem 'inherited_resources' # DRY controllers

# https://github.com/mdeering/attribute_normalizer
gem 'attribute_normalizer' # various utilities to clean data
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

# https://github.com/justinfrench/formtastic
gem 'formtastic', github: 'justinfrench/formtastic'

# https://github.com/nickl-/formtastic-bootstrap3
gem 'formtastic-bootstrap', github: 'nickl-/formtastic-bootstrap3'

# https://github.com/decioferreira/bootstrap-generators
gem 'bootstrap-generators', github: 'decioferreira/bootstrap-generators'
##

##
# Authentication, authorization
##

# http://devise.plataformatec.com.br/
gem 'devise', '~> 3.1.0' # authentication

# https://github.com/EppO/rolify
gem 'rolify', github: 'EppO/rolify'

# https://github.com/nathanl/authority
gem 'authority'
##

##
# Utitlities
##

# https://github.com/collectiveidea/delayed_job
# https://github.com/collectiveidea/delayed_job_active_record
gem 'delayed_job_active_record'

# https://github.com/mhfs/devise-async
gem 'devise-async' # send e-mails in background

# https://github.com/evrone/quiet_assets
gem 'quiet_assets' # make logs a little more readable

# https://github.com/binarylogic/settingslogic
gem 'settingslogic' # manage application configuration

group :development do
  # http://nadarei.co/mina/
  gem 'mina',     github: "nadarei/mina",  :require => false # deployment

  # https://github.com/adie/mina-scp
  gem 'mina-scp', github: "adie/mina-scp", :require => false
end
##
