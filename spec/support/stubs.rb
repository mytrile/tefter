module Tefter
  module Stubs
    def self.let(name, &block)
      define_method name do
        @assignments ||= {}
        @assignments[name] ||= instance_eval(&block)
      end
    end

    let :new_user do
      mock_model(User, :errors => stub(ActiveRecord::Errors, :null_object => true), :null_object => true).as_new_record
    end

    let :user do
      mock_model(User)
    end

  end
end

Spec::Runner.configure { |config| config.include Tefter::Stubs }
