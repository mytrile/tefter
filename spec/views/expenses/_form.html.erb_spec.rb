require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/expenses/_form" do
  it "should render correct form location" do
    assigns[:expense] = stub_model(Expense)
    assigns[:category] = stub_model(Category)
    render :partial => "expenses/form"
    response.should have_selector "form", :action => category_expense_path(assigns[:category], assigns[:expense])
  end
end
