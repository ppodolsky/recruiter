require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/chruby'
require 'mina/scp'

server = ENV['to']

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, [
  'config/database.yml',
  'config/application.yml',
  'log',
  'pids',
  'tmp'
]

set :deploy_to, '/u/apps/recruiter'
set :repository, 'git@github.com:jrhorn424/recruiter.git'
set :branch, 'master'
set :app_root, File.expand_path('../../', __FILE__)
set :application, 'recruiter'
set :rails_env, 'production'
set :user, 'deploy'
set :forward_agent, true

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # Ensure that a server has been set
  unless server
    print_error "A server needs to be specified. (to=production or to=staging)"
    exit
  end

  # Set the basic environment variables based on the server and version
  case server
  when 'staging'
    set :domain, 'staging.ices-experiments.org'
  when 'production'
    set :domain, 'ices-experiments.org'
  end

  invoke :'chruby[ruby-2.0]'
end

desc "Create shared folders and files."
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]
end

desc "Upload secret configuration files."
task :config => :environment do
  scp_upload "#{app_root}/config/{application,database}.yml", "#{deploy_to}/shared/config/", verbose: true
end

namespace :bower do
  desc "Install dependencies with bower."
  task :install => :environment do
    queue %[echo "-----> Installing static assets with bower"]
    queue %[bower install]
  end
end

namespace :nginx do
  desc "Restart nginx."
  task :restart => :environment do
    queue %{
      echo "-----> Restarting nginx"
      #{echo_cmd %[sudo service nginx restart]}
    }
  end
end

namespace :unicorn do
  desc "Zero-downtime restart of Unicorn"
  task :restart => :environment do
    queue %{
      echo "-----> Restarting unicorn app server"
      #{echo_cmd %[kill -s USR2 `cat #{deploy_to}/shared/pids/unicorn.pid`]}
      }
  end

  desc "Start unicorn"
  task :start => :environment do
    queue %{
      echo "-----> "
      #{echo_cmd %[cd #{deploy_to}/current ; bundle exec unicorn -c config/unicorn.rb -D -E production]}
      }
  end

  desc "Stop unicorn"
  task :stop => :environment do
    queue %{
      echo "-----> "
      #{echo_cmd %[kill -s QUIT `cat #{deploy_to}/shared/pids/unicorn.pid`]}
      }
  end
end

desc "Shows logs"
task :logs do
  queue %[cd #{deploy_to!} && tail -f shared/log/production.log]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'bower:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue %{touch #{deploy_to}/shared/tmp/restart.txt}
      invoke :'unicorn:restart'
      invoke :'nginx:restart'
    end
  end
end

# docs: http://nadarei.co/mina/helpers
