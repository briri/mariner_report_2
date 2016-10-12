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

ActiveRecord::Schema.define(version: 20161011213222) do

  create_table "articles", force: :cascade do |t|
    t.string   "target"
    t.string   "title"
    t.string   "author"
    t.string   "media"
    t.string   "thumbnail"
    t.string   "media_type"
    t.string   "media_host"
    t.datetime "publication_date"
    t.text     "content"
    t.datetime "expiration"
    t.integer  "publisher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["expiration"], name: "index_articles_on_expiration"
    t.index ["publisher_id"], name: "index_articles_on_publisher_id"
    t.index ["target"], name: "index_articles_on_target"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "tier"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "category_type_id"
    t.string   "slug"
    t.index ["category_type_id"], name: "index_categories_on_category_type_id"
    t.index ["name", "tier", "active"], name: "index_categories_on_name_and_tier_and_active"
  end

  create_table "categories_articles", id: false, force: :cascade do |t|
    t.integer "article_id",  null: false
    t.integer "category_id", null: false
    t.index ["article_id", "category_id"], name: "index_categories_articles_on_article_id_and_category_id"
    t.index ["category_id", "article_id"], name: "index_categories_articles_on_category_id_and_article_id"
  end

  create_table "categories_feeds", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "feed_id",     null: false
    t.index ["category_id", "feed_id"], name: "index_categories_feeds_on_category_id_and_feed_id"
    t.index ["feed_id", "category_id"], name: "index_categories_feeds_on_feed_id_and_category_id"
  end

  create_table "categories_tags", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "tag_id",      null: false
    t.index ["category_id", "tag_id"], name: "index_categories_tags_on_category_id_and_tag_id"
    t.index ["tag_id", "category_id"], name: "index_categories_tags_on_tag_id_and_category_id"
  end

  create_table "category_types", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_category_types_on_name"
  end

  create_table "censures", force: :cascade do |t|
    t.string   "value"
    t.boolean  "in_title"
    t.boolean  "in_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "feed_id"
    t.index ["feed_id"], name: "index_censures_on_feed_id"
    t.index ["value", "in_content"], name: "index_censures_on_value_and_in_content"
    t.index ["value", "in_title"], name: "index_censures_on_value_and_in_title"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.boolean  "moderated"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "post_id"
    t.index ["moderated", "active"], name: "index_comments_on_moderated_and_active"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "feed_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_feed_types_on_name"
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "source"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "feed_type_id"
    t.integer  "publisher_id"
    t.string   "article_css_selector"
    t.datetime "last_scan_on"
    t.datetime "next_scan_on"
    t.datetime "last_article_from"
    t.integer  "max_article_age_in_days"
    t.integer  "scan_frequency_in_hours"
    t.integer  "category_id"
    t.boolean  "active"
    t.index ["category_id"], name: "index_feeds_on_category_id"
    t.index ["feed_type_id"], name: "index_feeds_on_feed_type_id"
    t.index ["publisher_id"], name: "index_feeds_on_publisher_id"
    t.index ["source"], name: "index_feeds_on_source"
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["abbreviation"], name: "index_languages_on_abbreviation"
  end

  create_table "policies", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_policies_on_name", unique: true
  end

  create_table "policies_users", id: false, force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "policy_id", null: false
    t.index ["policy_id", "user_id"], name: "index_policies_users_on_policy_id_and_user_id"
    t.index ["user_id", "policy_id"], name: "index_policies_users_on_user_id_and_policy_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "slug"
    t.string   "name"
    t.text     "content"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["slug", "name", "active"], name: "index_posts_on_slug_and_name_and_active"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "tag_id",  null: false
    t.index ["post_id", "tag_id"], name: "index_posts_tags_on_post_id_and_tag_id"
    t.index ["tag_id", "post_id"], name: "index_posts_tags_on_tag_id_and_post_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "slug"
    t.string   "name"
    t.string   "description"
    t.string   "homepage"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "logo"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "language_id"
    t.index ["language_id"], name: "index_publishers_on_language_id"
    t.index ["slug", "active"], name: "index_publishers_on_slug_and_active"
    t.index ["slug", "active"], name: "index_publishers_on_slug_and_active_and_last_article_from"
    t.index ["slug"], name: "index_publishers_on_slug_and_max_article_age"
    t.index ["slug"], name: "index_publishers_on_slug_and_next_scan_on"
  end

  create_table "redactions", force: :cascade do |t|
    t.string   "value"
    t.boolean  "in_title"
    t.boolean  "in_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "feed_id"
    t.index ["feed_id"], name: "index_redactions_on_feed_id"
    t.index ["value", "in_content"], name: "index_redactions_on_value_and_in_content"
    t.index ["value", "in_title"], name: "index_redactions_on_value_and_in_title"
  end

  create_table "referrals", force: :cascade do |t|
    t.string   "origin"
    t.string   "target"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "reported"
    t.integer  "publisher_id"
    t.index ["publisher_id"], name: "index_referrals_on_publisher_id"
    t.index ["target"], name: "index_referrals_on_where_and_when_and_target"
  end

  create_table "scans", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at"
    t.index ["url"], name: "index_scans_on_url"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["name"], name: "index_tags_on_name"
  end

  create_table "unknown_tags", force: :cascade do |t|
    t.string   "value"
    t.integer  "article_id"
    t.datetime "created_at"
    t.index ["article_id"], name: "index_unknown_tags_on_article_id"
    t.index ["value"], name: "index_unknown_tags_on_value"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "language_id"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email"
    t.index ["language_id"], name: "index_users_on_language_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
