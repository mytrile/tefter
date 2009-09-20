require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesHelper do

  it "should print money fields with correct format" do
    helper.to_money(10).should == '10.00'
  end

  it "should print link to category expenses" do
    category = stub_model(Category, :name => "Booze")
    helper.link_to_category(category).should == "<a href=\"#{category_expenses_path(category)}\">Booze</a>"
  end

end
