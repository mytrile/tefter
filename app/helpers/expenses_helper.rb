module ExpensesHelper

  def group_by_day(expenses)
    returning ActiveSupport::OrderedHash.new do |collection|
      expenses.group_by(&:created_on).each do |day, entries|
        collection[ExpenseDate.new(day, entries.sum(&:amount))] = entries
      end
    end
  end
end
