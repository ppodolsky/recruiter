set :rails_env, 'production'
set :branch, 'b-ices'

set :user, "deploy"  # The server's user for deploys

server "recruiter.ices-experiments.org", :app, :web, :db, :primary => true

# chruby
set :ruby_version, "2.0.0"
set :chruby_config, "/etc/profile.d/chruby.sh"
set :set_ruby_cmd, "source #{chruby_config} && chruby #{ruby_version}"
set(:bundle_cmd) {
  "#{set_ruby_cmd} && exec bundle"
}

# bower
set :bower_cmd, "/usr/bin/bower"

before 'deploy:assets:precompile', 'deploy:bower_install'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :bower_install do
    run "cd #{latest_release} && #{bower_cmd} install"
  end
end
