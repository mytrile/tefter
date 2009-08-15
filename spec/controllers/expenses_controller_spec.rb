require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesController do

  it "should use ExpensesController" do
    controller.should be_an_instance_of(ExpensesController)
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end
