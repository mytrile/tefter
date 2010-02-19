class ExpensesController < ApplicationController

  before_filter :require_user

  def new
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.create(params[:expense])
    if @expense.valid?
      flash[:notice] = t(:flash_expense_added)
      redirect_to new_expense_path
    else
      render :action => :new
    end
  end

  def index
    @expenses = current_user.expenses.paginate(:page => params[:page])
  end

  def edit
  end

  def destroy
    current_user.expenses.find(params[:id]).destroy
    flash[:notice] = t(:flash_expense_deleted)
    redirect_to expenses_path
  end

end
