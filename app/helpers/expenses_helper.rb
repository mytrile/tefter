module ExpensesHelper
  def total_for_date(date)
    Expense.for_date(date).sum(:amount)
  end
end
