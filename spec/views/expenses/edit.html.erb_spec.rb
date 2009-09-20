require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/expenses/edit" do
  before do
    assigns[:expense] = stub_model(Expense, :title => "Talisker", :amount => 50, :category_name => "Booze")
    render "expenses/edit"
  end

  it "should render edit title" do
    response.should have_text /Editing 50.00 for Talisker \(Booze\)/
  end

  it "should render edit form" do
    response.should have_selector "form", :action => expense_path(assigns[:expense]) do |form|
      form.should have_selector 'input', :id => "expense_amount", :value => "50"
      form.should have_selector 'input', :value => "Change"
    end
  end

end
