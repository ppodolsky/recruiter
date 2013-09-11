require 'bundler/capistrano'

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

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# after 'deploy:update', 'deploy:symlink_attachments'

# Run rake tasks
def run_rake(task, options={}, &block)
  command = "cd #{latest_release} && #{bundle_cmd} rake #{task}"
  run(command, options, &block)
end

namespace :deploy do
  task :symlink_attachments do
    run "ln -nfs #{shared_path}/attachments #{release_path}/public/attachments"
  end
end
