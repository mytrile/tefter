require 'spec_helper'

describe "Sign in page" do
  before(:each) do
    assigns[:user_session] = new_user_session
    render 'user_sessions/new'
  end

  it { should respond_with :success }

  it "should display a form for sign up" do
    response.should have_selector "form", :action => user_session_path
  end
end
