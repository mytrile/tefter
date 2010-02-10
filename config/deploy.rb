set :application, "tefter"
set :repository,  "git@github.com:underlog/tefter.git"
set :scm, :git
set :use_sudo, false

require 'capistrano/ext/multistage'

default_run_options[:pty] = true

set :stages, %w(beta production)
set :default_stage, "beta"


# Passenger
namespace :deploy do

  task :start do; end

  task :stop do; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp', 'restart.txt')}"
  end

  task :link_database_yml do
    run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

end

after 'deploy:update_code', 'deploy:link_database_yml'
after 'deploy', 'deploy:cleanup'


