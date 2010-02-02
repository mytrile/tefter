module Tefter
  module Stubs
    def self.let(name, &block)
      define_method name do
        @assignments ||= {}
        @assignments[name] ||= instance_eval(&block)
      end
    end

    let :new_user do
      mock_model(User, :errors => stub_errors, :null_object => true).as_new_record
    end

    let :new_user_session do
      stub(UserSession, :null_object => true, :errors => stub_errors, :id => nil)
    end

    let :stub_errors do
      stub(ActiveRecord::Errors, :null_object => true, :count => 0)
    end

    let :user do
      mock_model(User)
    end

  end
end

Spec::Runner.configure { |config| config.include Tefter::Stubs }
