require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/expenses/index" do
  before(:each) do
    assigns[:expense] = mock_model(Expense)
    render 'expenses/index'
  end

  it { should respond_with :success }

end
