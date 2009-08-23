module ExpensesHelper
  def total_for_date(date)
    Expense.for_date(date).sum(:amount)
  end

  def to_money(amount)
    "%0.2f"% amount
  end
end
