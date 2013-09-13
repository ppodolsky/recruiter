require 'bundler/capistrano'
require 'capistrano-unicorn'

default_run_options[:shell] = '/bin/bash' # important!

require 'capistrano/ext/multistage'
set :stages, ["staging", "production"]
set :default_stage, "staging"

set :application, "recruiter"

set :repository,  "git@github.com:jrhorn424/recruiter.git"
# set :git_enable_submodules, 1 # tell cap to use submodules if you're using them
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm_verbose, true
set :deploy_via, :remote_cache # deploy by asking remote to checkout repo. requires key auth.
set :ssh_options, { :forward_agent => true } # use local keys instead of the ones on the server.
default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work

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

after "deploy:restart", "deploy:cleanup"
after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'   # app preloaded
after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)

# Run rake tasks
def run_rake(task, options={}, &block)
  command = "cd #{latest_release} && #{bundle_cmd} rake #{task}"
  run(command, options, &block)
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :bower_install do
    run "cd #{latest_release} && #{bower_cmd} install"
  end
  task :symlink_attachments do
    run "ln -nfs #{shared_path}/attachments #{release_path}/public/attachments"
  end
end
