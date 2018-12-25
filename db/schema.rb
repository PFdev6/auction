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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_25_224302) do

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "data_fingerprint"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "comments", force: :cascade do |t|
    t.text "msg"
    t.integer "user_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_comments_on_ancestry"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "current_bargains", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "current_price"
    t.integer "id_user_winner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lot_id"
    t.integer "comment_id"
    t.boolean "played_out", default: false
    t.integer "delayed_job_id"
    t.index ["comment_id"], name: "index_current_bargains_on_comment_id"
    t.index ["delayed_job_id"], name: "index_current_bargains_on_delayed_job_id"
    t.index ["lot_id"], name: "index_current_bargains_on_lot_id"
    t.index ["user_id"], name: "index_current_bargains_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "filter_lots", force: :cascade do |t|
    t.string "user_name"
    t.decimal "autopurchase_price"
    t.decimal "start_price"
    t.boolean "played_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lots", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "start_price"
    t.string "main_image_file_name"
    t.string "main_image_content_type"
    t.integer "main_image_file_size"
    t.datetime "main_image_updated_at"
    t.datetime "lot_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "first_additional_image_file_name"
    t.string "first_additional_image_content_type"
    t.integer "first_additional_image_file_size"
    t.datetime "first_additional_image_updated_at"
    t.string "second_additional_image_file_name"
    t.string "second_additional_image_content_type"
    t.integer "second_additional_image_file_size"
    t.datetime "second_additional_image_updated_at"
    t.integer "current_bargain_id"
    t.decimal "autopurchase_price"
    t.boolean "inprocess", default: true
    t.index ["current_bargain_id"], name: "index_lots_on_current_bargain_id"
  end

  create_table "main_news", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_main_news_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "msg"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_bargain_id"
    t.index ["current_bargain_id"], name: "index_messages_on_current_bargain_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "lot_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_taggings_on_lot_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isadmin"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "likes", default: 0
    t.string "first_name"
    t.string "second_name"
    t.text "about_users"
    t.string "nickname"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "local", default: "en"
    t.integer "current_bargain_id"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["current_bargain_id"], name: "index_users_on_current_bargain_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
