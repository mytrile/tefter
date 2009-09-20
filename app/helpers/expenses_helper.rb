module ExpensesHelper
  def to_money(amount)
    "%0.2f"% amount
  end

  def link_to_category(category)
    link_to category.name, category_expenses_path(category)
  end

  def link_to_edit_expense(expense)
    if @category
      link_to expense.title, edit_category_expense_path(@category, expense)
    else
      link_to expense.title, edit_expense_path(expense)
    end
  end
end
