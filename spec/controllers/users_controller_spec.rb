require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    before { User.should_receive(:new).and_return(new_user) }

    before do
      get 'new'
    end

    it { should respond_with(:success) }
    it { should assign_to(:user).with(new_user) }
  end

  describe "POST 'create'" do
    before { User.should_receive(:new).and_return(new_user) }

    describe "success" do
      before { new_user.should_receive(:save).and_return(true) }

      before do
        post 'create', :user => { :email => "user@example.com" }
      end

      it { should redirect_to root_path }
      it { should set_the_flash }
    end

    describe "failure" do
      before { new_user.should_receive(:save).and_return(false) }

      before do
        post 'create', :user => { :email => "user@example.com" }
      end

      it { should render_template("new") }
      it { should assign_to :user }
    end
  end
end
