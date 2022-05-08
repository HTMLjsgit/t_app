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

ActiveRecord::Schema.define(version: 2022_05_07_050317) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "chat_posts", force: :cascade do |t|
    t.string "message"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id"
    t.integer "see", default: 0
    t.integer "chat_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "image_posts", force: :cascade do |t|
    t.string "number"
    t.string "picture"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_image_posts_on_post_id"
  end

  create_table "image_reals", force: :cascade do |t|
    t.string "number"
    t.string "picture"
    t.integer "real_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["real_id"], name: "index_image_reals_on_real_id"
    t.index ["user_id"], name: "index_image_reals_on_user_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "payment_settings", force: :cascade do |t|
    t.float "seller_post_commision"
    t.float "buyer_post_commision"
    t.float "stripe_commission"
    t.float "consumption_tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.text "description"
    t.string "currency", default: "jpy"
    t.string "customer_id"
    t.time "payment_data"
    t.string "uuid"
    t.string "charge_id"
    t.bigint "stripe_commission"
    t.bigint "stripe_amount_after_subtract_commision"
    t.string "receipt_url"
    t.string "receive_id"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "amount"
    t.time "payment_date"
    t.float "commision_result"
    t.float "receipt_commision"
    t.integer "sale_id"
    t.index ["post_id"], name: "index_payments_on_post_id"
    t.index ["sale_id"], name: "index_payments_on_sale_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "post_likes", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_likes_on_post_id"
    t.index ["user_id"], name: "index_post_likes_on_user_id"
  end

  create_table "post_thumbnails", force: :cascade do |t|
    t.integer "post_id"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_thumbnails_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.bigint "amount"
    t.string "title"
    t.text "description"
    t.string "poster"
  end

  create_table "real_comments", force: :cascade do |t|
    t.string "comment"
    t.integer "user_id"
    t.integer "real_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["real_id"], name: "index_real_comments_on_real_id"
    t.index ["user_id"], name: "index_real_comments_on_user_id"
  end

  create_table "real_likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "real_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reals", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "receipt_totals", force: :cascade do |t|
    t.bigint "total", default: 0, null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_receipt_totals_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer "payment_id"
    t.boolean "transfer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "post_id"
    t.bigint "result_amount", default: 0, null: false
    t.index ["payment_id"], name: "index_sales_on_payment_id"
    t.index ["post_id"], name: "index_sales_on_post_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "transfer_completions", force: :cascade do |t|
    t.boolean "already_transfer", default: false, null: false
    t.integer "user_id"
    t.integer "transfer_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transfer_request_id"], name: "index_transfer_completions_on_transfer_request_id"
    t.index ["user_id"], name: "index_transfer_completions_on_user_id"
  end

  create_table "transfer_requests", force: :cascade do |t|
    t.boolean "already_request"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "amount", default: 0, null: false
    t.index ["user_id"], name: "index_transfer_requests_on_user_id"
  end

  create_table "transfer_totals", force: :cascade do |t|
    t.bigint "total", default: 0, null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transfer_totals_on_user_id"
  end

  create_table "user_rooms", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "icon"
    t.string "access_token"
    t.string "bank_name"
    t.string "bank_branch_name"
    t.string "bank_account_type"
    t.string "bank_account_number"
    t.string "bank_account_horseman_name_kana"
    t.string "background_image"
    t.boolean "admin", default: false, null: false
    t.string "avater"
    t.boolean "ban", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
