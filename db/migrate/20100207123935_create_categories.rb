class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.belongs_to :user
      t.string :name
      t.timestamps
    end

    add_index :categories, :user_id
  end

  def self.down
    drop_table :categories
  end
end
