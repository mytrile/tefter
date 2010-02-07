class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.string :title
      t.decimal :amount
      t.belongs_to :user
      t.belongs_to :category
      t.date :created_on
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :expenses, [ :user_id, :category_id ]
    add_index :expenses, [ :user_id, :created_on ]
  end

  def self.down
    drop_table :expenses
  end
end
