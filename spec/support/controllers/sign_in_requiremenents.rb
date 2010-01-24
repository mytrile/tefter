module Tefter

  module SignInRequirements

    shared_examples_for "signed in user is required" do

      def current_user(stubs = {:null_object => true})
        @current_user ||= stub_model(User, stubs)
      end

      before :each do
        controller.should_receive(:require_user).and_return(current_user)
        controller.stub!(:current_user).and_return(current_user)
      end

    end

    shared_examples_for "non-signed in user is required" do

      def current_user()
        nil
      end

      before :each do
        controller.should_receive(:require_no_user).and_return(true)
        controller.stub!(:current_user).and_return(current_user)
      end

    end

  end

end

Spec::Runner.configure { |config| config.include Tefter::SignInRequirements, :type => :controllers }
