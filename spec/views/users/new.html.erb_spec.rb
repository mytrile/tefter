require 'spec_helper'

describe "/users/new" do
  before(:each) do
    assigns[:user] = new_user
    render 'users/new'
  end

  it { should respond_with :success }

  it "should display a form for sign up" do
    response.should have_selector "form", :action => users_path
  end
end
