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

  describe "filtered by category" do 
    before do
      @category = stub_model(Category)
      Category.stub! :find => @category
      @category.expenses.should_receive(:in_pages_with_totals).and_return([[], {}])
      get 'index', :category_id => @category.id
    end

    it { should assign_to(:category).with(@category) }

    describe "updating expense" do 
      it "send back to the right category" do 
        @category = stub_model(Category, :name => "Booze")
        @expense = stub_model(Expense, :title => "Talisker", :amount => "50", :category_name => "Booze")
        Category.should_receive(:find).with(@category.id.to_s).and_return(@category)
        @category.expenses.should_receive(:find).with(@expense.id.to_s).and_return(@expense)
        @expense.should_receive(:update_attributes).with(@params)
        put "update", :expense => @params, :id => @expense.id, :category_id => @category.id
        should redirect_to category_expenses_path(@category)
        should set_the_flash.to("Expense updated")
      end
    end

  end

  describe "editing expense" do
    it "should pass the right expense to the view" do
      @expense = stub_model(Expense, :title => "Talisker", :amount => "50", :category_name => "Booze")
      Expense.should_receive(:find).with(@expense.id.to_s).and_return(@expense)
      get 'edit', :id => @expense.id
    end
  end

  describe "updating expense" do 
    it "should update the right record" do 
      @expense = stub_model(Expense, :title => "Talisker", :amount => "50", :category_name => "Booze")
      Expense.should_receive(:find).with(@expense.id.to_s).and_return(@expense)
      @params = { "title" => "Lagavulin", "amount" => "30", "category_name" => "Recr." }
      @expense.should_receive(:update_attributes).with(@params)
      put "update", :expense => @params, :id => @expense.id
      should redirect_to root_path
      should set_the_flash.to("Expense updated")
    end
  end


end
