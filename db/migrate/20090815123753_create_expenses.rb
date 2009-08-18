class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.string :title, :null => false
      t.decimal :amount, :null => false
      t.belongs_to :category, :null => false
      t.date :created_at
    end
  end

  def self.down
    drop_table :expenses
  end
end
