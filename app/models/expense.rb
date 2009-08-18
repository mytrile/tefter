class Expense < ActiveRecord::Base
  attr_accessor :category_name

  validates_presence_of :title
  validates_presence_of :amount

  belongs_to :category

  validate :check_category_name
  before_create :bind_category, :set_created_at

  named_scope :for_date, lambda { |date| { :conditions => { :created_at => date } } }
  protected

  def set_created_at
    self.created_at = Date.today
  end

  def bind_category
    self.category = Category.find_or_create_by_name(category_name)
  end

  def check_category_name
    errors.add_on_blank :category_name
  end
end
