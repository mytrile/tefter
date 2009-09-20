require 'cucumber/rake/task'
require 'spec/rake/spectask'

namespace :ci do
  Cucumber::Rake::Task.new({:features => 'db:test:prepare'}, 'Run cucumber features') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.cucumber_opts = "--color --tags ~@wip --tags ~@pending --strict --format pretty --no-source"
  end

  desc "Run all specs in spec directory (excluding plugin specs)"
  Spec::Rake::SpecTask.new(:spec => 'db:test:prepare') do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/ci.opts\""]
    t.spec_files = FileList['spec/**/*_spec.rb']
  end

end

desc "Runs all features and examples, generating HTML reports for CI"
task :ci => ['db:migrate:reset', 'ci:features', 'ci:spec']
