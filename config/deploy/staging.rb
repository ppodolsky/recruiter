set :user, "deploy"  # The server's user for deploys

server "www.example.com", :app, :web, :db, :primary => true
