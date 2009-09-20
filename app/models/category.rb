class Category < ActiveRecord::Base
  has_many :expenses

  def self.cleanup!
    delete_all "(select count(*) from expenses where category_id = categories.id) = 0"
  end

end
