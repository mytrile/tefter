require 'spec_helper'

describe "/home/index" do

  before(:each) do
    render 'home/index'
  end

  it { should respond_with :success }

  it "should link to sign up" do
    response.should have_selector "a", :href => sign_up_path
  end

end
