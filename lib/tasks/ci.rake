require 'cucumber/rake/task'
require 'spec/rake/spectask'

namespace :ci do
  Cucumber::Rake::Task.new({:cucumber => 'db:test:prepare'}, 'Run cucumber features') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.cucumber_opts = "--color --tags ~@wip --strict --format progress"
  end

  desc "Run all specs in spec directory (excluding plugin specs)"
  Spec::Rake::SpecTask.new(:spec => 'db:test:prepare') do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/ci.opts\""]
    t.spec_files = FileList['spec/**/*_spec.rb']
  end

  desc "Symlinks database configs for ci server"
  task :symlink_db_config do
    sh "cp config/database.yml.example config/database.yml"
  end

  desc "Deploy to current environment"
  task :deploy do
    sh "cap #{ENV['DEPLOY_ENV']} deploy:migrations"
  end

  desc "Run all features and specs against the .net engine"
  task :acceptance do
    Rake::Task['ci:spec'].invoke
    Rake::Task['ci:cucumber'].invoke
  end

end

desc "Task meant to be run by CI; Runs all features and examples, and deploys if successful."
task :ci => ['ci:make_temp_dir', 'ci:symlink_db_config', 'db:create', 'db:migrate', 'ci:acceptance', 'ci:deploy']
