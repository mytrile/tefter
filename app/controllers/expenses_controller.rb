class ExpensesController < ApplicationController
  def index
    @expense = Expense.new
    @expenses, @totals = Expense.paginate_with_totals :page => params[:page]
    @stats = {}
  end

  def create
    @expense = Expense.create params[:expense]
    if @expense.valid? 
      flash[:notice] = "Expense added."
      redirect_to root_path
    else
      flash[:error] = "Expense not added."
      render :action => 'index'
    end
  end

end
