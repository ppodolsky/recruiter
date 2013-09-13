set :rails_env, 'production'
set :branch, 'b-ices'

set :user, "deploy"  # The server's user for deploys

server "recruiter.ices-experiments.org", :app, :web, :db, :primary => true
