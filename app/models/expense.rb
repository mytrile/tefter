class Expense < ActiveRecord::Base
  attr_accessor :category_name

  validates_presence_of :title
  validates_presence_of :amount

  belongs_to :category

  validate :check_category_name
  before_create :bind_category, :set_created_at

  def self.paginate_with_totals(options)
    expenses = paginate options.merge(:order => 'created_at desc, id desc')
    return [ [], {}] if expenses.empty?
    range = (expenses.last.created_at .. expenses.first.created_at)
    totals = sum(:amount, :conditions => { :created_at => range }, :group => :created_at)
    [expenses, totals]
  end

  protected

  def set_created_at
    self.created_at ||= Date.today
  end

  def bind_category
    self.category = Category.find_or_create_by_name(category_name)
  end

  def check_category_name
    errors.add_on_blank :category_name
  end
end
