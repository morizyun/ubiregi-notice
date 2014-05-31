# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140531142554) do

  create_table "messages", :force => true do |t|
    t.integer  "notice_id"
    t.string   "locale",     :null => false
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["notice_id", "locale"], :name => "index_messages_on_notice_id_and_locale", :unique => true

  create_table "notices", :force => true do |t|
    t.datetime "close_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
