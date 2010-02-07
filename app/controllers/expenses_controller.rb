class ExpensesController < ApplicationController

  before_filter :require_user

  def new
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.create(params[:expense])
    if @expense.valid?
      flash[:notice] = "Expense added."
      redirect_to new_expense_path
    else
      render :action => :new
    end
  end

  def index
  end

  def edit
  end

end
