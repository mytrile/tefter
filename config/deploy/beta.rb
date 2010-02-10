set :branch, :beta

set :deploy_to, "/var/www/beta.tefterapp.com"

set :rails_env, :staging

server 'li-1', :app, :web, :db, :primary => true
