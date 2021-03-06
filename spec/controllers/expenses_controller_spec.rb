require 'spec_helper'

describe ExpensesController do

  it_should_behave_like "signed in user is required"

  describe "GET 'new'" do
    before { current_user.expenses.should_receive(:new).and_return(new_expense) }

    before do
      get 'new'
    end

    it { should assign_to(:expense).with(new_expense) }
  end

  describe "POST 'create'" do

    let :expense_params do
      { "amount" => 100 }
    end

    before { current_user.expenses.should_receive(:create).with(expense_params).and_return(new_expense) }

    describe "success" do
      before { new_expense.should_receive(:valid?).and_return(true) }

      before do
        post :create, :expense => expense_params
      end

      it { should set_the_flash }
      it { should redirect_to new_expense_path }
    end

    describe "failure" do
      before { new_expense.should_receive(:valid?).and_return(false) }

      before do
        post :create, :expense => expense_params
      end

      it { should render_template :new }
      it { should assign_to :expense }
    end
  end

  describe "GET 'index'" do
    before { current_user.expenses.should_receive(:paginate).and_return(expenses) }

    before do
      get 'index'
    end

    it { should respond_with :success }
    it { should assign_to :expenses }

  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => 1
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    before { current_user.expenses.stub! :find => expense }
    before { expense.should_receive(:destroy) }

    before do
      delete :destroy, :id => expense.id
    end

    it { should redirect_to expenses_path }
    it { should set_the_flash }
  end
end
