class ExpensesController < ApplicationController

  before_filter :check_for_category

  def index
    @expense = context.new
    @expenses, @totals = context.in_pages_with_totals :page => params[:page]
    @stats = Expense.stats
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

  private

  def check_for_category
    @category = Category.find(params[:category_id]) if params[:category_id]
  end

  def context
    @category.try(:expenses) || Expense
  end

end
