require 'spec_helper'

describe UserSessionsController do

  context "sign in actions" do

    it_should_behave_like "non-signed in user is required"

    describe "GET 'new'" do
      before { UserSession.should_receive(:new).and_return(new_user_session) }

      before do
        get 'new'
      end

      it { should respond_with(:success) }
      it { should assign_to(:user_session).with(new_user_session) }
    end

    describe "POST 'create'" do
      before { UserSession.should_receive(:new).and_return(new_user_session) }

      describe "success" do
        before { new_user_session.should_receive(:save).and_return(true) }

        before do
          post 'create', :user_session => { :email => "user@example.com" }
        end

        it { should redirect_to root_path }
        it { should set_the_flash }
      end

      describe "failure" do
        before { new_user_session.should_receive(:save).and_return(false) }

        before do
          post 'create', :user_session => { :email => "user@example.com" }
        end

        it { should render_template("new") }
        it { should assign_to :user_session }
      end
    end

  end

  describe "DELETE 'destroy'" do
    it_should_behave_like "signed in user is required"

    before { current_user_session.should_receive(:destroy) }

    before do
      delete 'destroy'
    end

    it { should redirect_to(root_path) }
    it { should set_the_flash }
  end


end
