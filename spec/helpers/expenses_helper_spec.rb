require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesHelper do

  it "should print money fields with correct format" do
    helper.to_money(10).should == '10.00'
  end

end
