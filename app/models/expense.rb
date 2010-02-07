class Expense < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  before_save :bind_category

  validates_presence_of :title
  validates_presence_of :amount
  validate :require_category

  attr_writer :category_name

  def category_name
    @category_name || category.try(:name)
  end

  protected

  def require_category
    errors.add_on_blank :category_name
  end

  def bind_category
    self.category = user.categories.first(:conditions => [ "upper(name) = ?", category_name.upcase ]) || user.categories.create(:name => category_name)
  end

end
