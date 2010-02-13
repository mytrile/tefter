require 'spec_helper'

describe "/expenses/index" do

  before(:each) do
    assigns[:expenses] = expenses
    render 'expenses/index'
  end

  it "should display table with all the expenses" do
    response.should have_selector("table#expenses tbody tr.expense", :count => expenses.count)
  end
end
