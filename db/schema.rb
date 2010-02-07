# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100207123935) do

  create_table "categories", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "expenses", :force => true do |t|
    t.string   "title"
    t.integer  "amount",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "user_id"
    t.integer  "category_id"
    t.date     "created_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expenses", ["user_id", "category_id"], :name => "index_expenses_on_user_id_and_category_id"
  add_index "expenses", ["user_id", "created_on"], :name => "index_expenses_on_user_id_and_created_on"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
