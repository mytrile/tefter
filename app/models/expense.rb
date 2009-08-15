class Expense < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :amount
  validates_presence_of :category

  belongs_to :category
end
