set :rails_env, 'production'
set :branch, "master"

set :user, "deploy"  # The server's user for deploys

server "recruiter.ices-experiments.org", :app, :web, :db, :primary => true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
