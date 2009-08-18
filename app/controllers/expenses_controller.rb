class ExpensesController < ApplicationController
  def index
    @expense = Expense.new
    @expenses = Expense.paginate :page => params[:page], :order => 'created_at desc, id desc'
  end

  def create
    @expense = Expense.create params[:expense]
    if @expense.valid? 
      flash[:notice] = "Expense added."
      redirect_to root_path
    else
      flash[:error] = "What are you, some kinda of retired?"
      render :action => 'index'
    end
  end

end
