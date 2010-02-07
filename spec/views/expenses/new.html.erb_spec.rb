require 'spec_helper'

describe "/expenses/new" do

  before(:each) do
    assigns[:expense] = new_expense
    render 'expenses/new'
  end

  it { should respond_with :success }

  it "should display a form for the new expense" do
    response.should have_selector "form", :action => expenses_path
  end

end
