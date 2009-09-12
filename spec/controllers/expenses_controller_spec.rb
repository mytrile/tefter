require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpensesController do

  describe "Home page" do
    before do
      get 'index'
    end

    it { should assign_to(:expenses).with_kind_of(Array) }
    it { should assign_to(:totals).with_kind_of(Hash) }
    it { should assign_to(:stats).with_kind_of(Hash) }
    it { should respond_with(:success) }

    it "should pass paginated expenses and totals for each day" do
      Expense.should_receive(:in_pages_with_totals).and_return([[], {}])
      get :index
    end

    it "should pass statistics" do
      Expense.should_receive(:stats).and_return({})
      get :index
    end

  end

  describe "New expense (successful)" do
    it "should create a new expense" do
      expense_params = { :title => 'Talisker 18yrs', :amount => 50, :category_name => 'Booze' }
      Expense.should_receive(:create).with(expense_params.stringify_keys).and_return(stub(:valid? => true))
      post 'create', :expense => expense_params
    end

    it "should redirect back to the homepage after successful attempt, with notice" do
      expense = mock_model(Expense, :valid? => true)
      Expense.should_receive(:create).and_return(expense)
      post 'create'
      should redirect_to(root_path)
      should set_the_flash.to(/Expense added/)
    end
  end

  describe "New expense (failure)" do
    before do 
      expense = mock_model(Expense, :valid? => false)
      Expense.should_receive(:create).and_return(expense)
      post 'create'
    end

    it "should render the form again" do
      should render_template(:index)
    end

    it "should provide error message" do
      should set_the_flash.to(/Expense not added/)
    end
  end

end
