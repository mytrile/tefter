namespace :tefter do
  desc "bootstrap test account and launch mongrel"
  task :start_dev => :environment do
    User.destroy_all
    User.create(:email => 'user@example.com', :password => 'example', :password_confirmation => "example")
    sh "script/server &"
    sleep 3
    sh "open http://localhost:3000/sign_in"
  end

end
