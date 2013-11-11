source 'https://rubygems.org'
ruby '2.0.0'

##
# Rails
##
gem 'rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
##

##
# Backend
##
gem 'unicorn', require: false, group: :production # server
gem 'sqlite3', group: :development                # database for master branch
gem 'pg'                                          # datastore
gem 'inherited_resources'                         # DRY controllers
gem 'interactor'                                  # thin models
gem 'interactor-rails'                            #
gem 'attribute_normalizer'                        # various utilities to clean data
##

##
# Frontend
##
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'slim-rails'                                               # slim templating, generate templates
gem 'kramdown'                                                 # for slim's markdown engine
gem 'responders'                                               # flash messages, among other things
gem 'high_voltage',   github: 'thoughtbot/high_voltage'        # static pages
gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass' # style
gem 'formtastic', github: 'justinfrench/formtastic'
gem 'formtastic-bootstrap', github: 'nickl-/formtastic-bootstrap3'

##

##
# Authentication, authorization
##
gem 'devise',  '~> 3.1.0' # authentication
gem 'rolify'              # authorization
gem 'authority'           #
##

##
# Utitlities
##
gem 'delayed_job_active_record'
gem 'daemons'
gem 'devise-async'  # send e-mails in background
gem 'quiet_assets'  # make logs a little more readable
gem 'settingslogic' # manage application configuration
gem 'whenever'      # manage cron jobs
gem 'roadie'        # inline css processor for e-mail templates
group :development do
  gem 'mina',     github: "nadarei/mina",  :require => false # deployment
  gem 'mina-scp', github: "adie/mina-scp", :require => false #
end
##
