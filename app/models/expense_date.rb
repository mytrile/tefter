class ExpenseDate

  attr_reader :date, :amount

  def initialize(date, amount)
    @date, @amount = [date, amount]
  end

end
