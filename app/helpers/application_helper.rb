# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def to_money(amount)
    number_to_currency(amount)
  end

  def friendly_date(date)
    case date
    when Date.today
      "today"
    when Date.yesterday
      "yesterday"
    else
      date.to_s(:short)
    end
  end
end
