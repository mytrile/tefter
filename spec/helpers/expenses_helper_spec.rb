require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesHelper do

  it "should print money correctly" do
    helper.to_money(10).should == '10.00'
  end
  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(ExpensesHelper)
  end

end
