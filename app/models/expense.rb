class Expense < ActiveRecord::Base
  attr_accessor :category_name

  validates_presence_of :title
  validates_presence_of :amount

  belongs_to :category

  validate :check_category_name
  before_create :set_created_at
  before_save :bind_category
   

  def self.in_pages_with_totals(options)
    expenses = paginate options.merge(:order => 'created_at desc, id desc')
    return [ expenses, {}] if expenses.empty?
    range = (expenses.last.created_at .. expenses.first.created_at)
    totals = sum(:amount, :conditions => { :created_at => range }, :group => :created_at)
    [expenses, totals]
  end

  def self.stats
    return {} if count.zero?
    start_date = maximum(:created_at).end_of_month
    end_date = minimum(:created_at).end_of_month
    
    stats = ActiveSupport::OrderedHash.new

    while start_date >= end_date
      interval = (start_date.beginning_of_month..start_date)
      ex_for_month = Expense.sum(:amount, :order => 'sum_amount desc', :group => :category, :include => :category, :conditions => { :created_at => interval })
      stats[start_date.strftime('%B')] = ex_for_month
      start_date = (start_date - 1.month).end_of_month
    end

    stats
  end

  def category_name
    @category_name || category.try(:name)
  end

  protected

  def set_created_at
    self.created_at ||= Date.today
  end

  def bind_category
    self.category = Category.first(:conditions => [ 'upper(name) = ?', category_name.upcase ]) || Category.create(:name => category_name)
  end

  def check_category_name
    errors.add_on_blank :category_name
  end
end
