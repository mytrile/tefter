set :branch, :production

set :deploy_to, "/var/www/tefterapp.com"

set :rails_env, :production

server 'li-1', :app, :web, :db, :primary => true
