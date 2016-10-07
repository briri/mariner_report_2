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

ActiveRecord::Schema.define(version: 20161007202636) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "tier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "tier", "active"], name: "index_categories_on_name_and_tier_and_active", using: :btree
  end

  create_table "categories_tags", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "category_id", null: false
    t.integer "tag_id",      null: false
    t.index ["category_id", "tag_id"], name: "index_categories_tags_on_category_id_and_tag_id", using: :btree
    t.index ["tag_id", "category_id"], name: "index_categories_tags_on_tag_id_and_category_id", using: :btree
  end

  create_table "censures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "value"
    t.boolean  "in_title"
    t.boolean  "in_content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "publisher_id"
    t.index ["publisher_id"], name: "index_censures_on_publisher_id", using: :btree
    t.index ["value", "in_content"], name: "index_censures_on_value_and_in_content", using: :btree
    t.index ["value", "in_title"], name: "index_censures_on_value_and_in_title", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535
    t.boolean  "moderated"
    t.boolean  "active"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.integer  "post_id"
    t.index ["moderated", "active"], name: "index_comments_on_moderated_and_active", using: :btree
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "feed_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_feed_types_on_name", using: :btree
  end

  create_table "feeds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "source"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "feed_type_id"
    t.integer  "publisher_id"
    t.index ["feed_type_id"], name: "index_feeds_on_feed_type_id", using: :btree
    t.index ["publisher_id"], name: "index_feeds_on_publisher_id", using: :btree
    t.index ["source"], name: "index_feeds_on_source", using: :btree
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["abbreviation"], name: "index_languages_on_abbreviation", using: :btree
  end

  create_table "policies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.index ["name"], name: "index_policies_on_name", unique: true, using: :btree
  end

  create_table "policies_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id",   null: false
    t.integer "policy_id", null: false
    t.index ["policy_id", "user_id"], name: "index_policies_users_on_policy_id_and_user_id", using: :btree
    t.index ["user_id", "policy_id"], name: "index_policies_users_on_user_id_and_policy_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "content",    limit: 65535
    t.boolean  "active"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.index ["slug", "title", "active"], name: "index_posts_on_slug_and_title_and_active", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "posts_tags", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "post_id", null: false
    t.integer "tag_id",  null: false
    t.index ["post_id", "tag_id"], name: "index_posts_tags_on_post_id_and_tag_id", using: :btree
    t.index ["tag_id", "post_id"], name: "index_posts_tags_on_tag_id_and_post_id", using: :btree
  end

  create_table "publishers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug"
    t.string   "name"
    t.string   "description"
    t.string   "homepage"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "logo"
    t.boolean  "active"
    t.string   "article_css_selector"
    t.date     "last_scan_on"
    t.date     "next_scan_on"
    t.date     "last_article_from"
    t.integer  "max_article_age"
    t.integer  "scan_frequency_in_hours"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "language_id"
    t.index ["language_id"], name: "index_publishers_on_language_id", using: :btree
    t.index ["slug", "active", "last_article_from"], name: "index_publishers_on_slug_and_active_and_last_article_from", using: :btree
    t.index ["slug", "active"], name: "index_publishers_on_slug_and_active", using: :btree
    t.index ["slug", "max_article_age"], name: "index_publishers_on_slug_and_max_article_age", using: :btree
    t.index ["slug", "next_scan_on"], name: "index_publishers_on_slug_and_next_scan_on", using: :btree
  end

  create_table "redactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "value"
    t.boolean  "in_title"
    t.boolean  "in_content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "publisher_id"
    t.index ["publisher_id"], name: "index_redactions_on_publisher_id", using: :btree
    t.index ["value", "in_content"], name: "index_redactions_on_value_and_in_content", using: :btree
    t.index ["value", "in_title"], name: "index_redactions_on_value_and_in_title", using: :btree
  end

  create_table "referrals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "origin"
    t.string   "target"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "reported"
    t.integer  "publisher_id"
    t.index ["publisher_id"], name: "index_referrals_on_publisher_id", using: :btree
    t.index ["target"], name: "index_referrals_on_where_and_when_and_target", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["language_id"], name: "index_users_on_language_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "censures", "publishers"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "feeds", "feed_types"
  add_foreign_key "feeds", "publishers"
  add_foreign_key "posts", "users"
  add_foreign_key "publishers", "languages"
  add_foreign_key "redactions", "publishers"
  add_foreign_key "referrals", "publishers"
  add_foreign_key "users", "languages"
end
