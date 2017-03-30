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

ActiveRecord::Schema.define(version: 20170330203832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_follows", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "artist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["artist_id"], name: "index_artist_follows_on_artist_id", using: :btree
    t.index ["follower_id", "artist_id"], name: "index_artist_follows_on_follower_id_and_artist_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_artist_follows_on_follower_id", using: :btree
  end

  create_table "artwork_likes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "artwork_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artwork_id"], name: "index_artwork_likes_on_artwork_id", using: :btree
    t.index ["user_id"], name: "index_artwork_likes_on_user_id", using: :btree
  end

  create_table "artworks", force: :cascade do |t|
    t.string  "name",        null: false
    t.integer "artist_id"
    t.text    "description"
    t.string  "image"
    t.string  "image_uuid"
    t.string  "slug"
    t.index ["artist_id"], name: "index_artworks_on_artist_id", using: :btree
  end

  create_table "chatroom_users", force: :cascade do |t|
    t.integer  "chatroom_id"
    t.integer  "user_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.datetime "last_read_at", default: '2017-03-22 21:57:37'
    t.index ["chatroom_id"], name: "index_chatroom_users_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_chatroom_users_on_user_id", using: :btree
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
    t.index ["sender_id"], name: "index_conversations_on_sender_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "fan_id",     null: false
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fan_id"], name: "index_likes_on_fan_id", using: :btree
    t.index ["post_id"], name: "index_likes_on_post_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "post_tags", force: :cascade do |t|
    t.integer  "post_id",    null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_tags_on_post_id", using: :btree
    t.index ["tag_id"], name: "index_post_tags_on_tag_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "slug"
    t.integer  "author_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "published_at"
    t.boolean  "featured",            default: false
    t.string   "featured_image"
    t.string   "featured_image_uuid"
    t.text     "introduction"
    t.index ["author_id"], name: "index_posts_on_author_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.integer  "creator_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.index ["creator_id"], name: "index_tags_on_creator_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                       default: ""
    t.string   "encrypted_password",          default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "provider"
    t.string   "uid"
    t.text     "bio",                         default: ""
    t.string   "auth_provider_profile_image", default: ""
    t.string   "full_name",                   default: "", null: false
    t.string   "username",                    default: "", null: false
    t.string   "instagram_username",          default: ""
    t.string   "slug"
    t.string   "hero_image"
    t.string   "hero_image_uuid"
    t.string   "profile_image"
    t.string   "profile_image_uuid"
    t.string   "facebook_username",           default: ""
    t.string   "twitter_username",            default: ""
    t.string   "website",                     default: ""
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "chatroom_users", "chatrooms"
  add_foreign_key "chatroom_users", "users"
  add_foreign_key "messages", "users"
end
