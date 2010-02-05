require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    context "user is signed out" do
      before { controller.should_receive(:signed_in?).and_return(false) }

      before do 
        get :index
      end

      it { should respond_with :success }
    end

    context "user is signed in" do 
      before { controller.should_receive(:signed_in?).and_return(true) }

      before do
        get :index
      end

      it { should redirect_to new_expense_path }
    end
  end
end
