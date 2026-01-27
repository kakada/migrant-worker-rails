# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2026_01_29_032500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "language_code", default: "en"
    t.integer "gf_user_id"
    t.datetime "deleted_at"
    t.boolean "actived", default: true
    t.boolean "dashboard_accessible", default: false
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "access_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "batches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.integer "total_count", default: 0
    t.integer "valid_count", default: 0
    t.integer "new_count", default: 0
    t.integer "province_count", default: 0
    t.string "reference"
    t.integer "creator_id"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "audio"
    t.text "description"
    t.string "type"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "last", default: false
    t.string "uuid"
    t.boolean "is_video"
    t.string "hint"
    t.string "hint_image"
    t.string "hint_audio"
    t.index ["lft"], name: "index_categories_on_lft"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["rgt"], name: "index_categories_on_rgt"
  end

  create_table "category_images", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "category_uuid"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chat_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "chat_id"
    t.string "chat_type", default: "group"
    t.boolean "active", default: true
    t.text "reason"
    t.string "telegram_bot_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "type", null: false
    t.string "value", default: ""
    t.bigint "institution_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_contacts_on_institution_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name_km"
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "country_institutions", force: :cascade do |t|
    t.string "country_code", default: ""
    t.bigint "institution_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_country_institutions_on_country_id"
    t.index ["institution_id"], name: "index_country_institutions_on_institution_id"
  end

  create_table "criteria", force: :cascade do |t|
    t.integer "question_id"
    t.string "question_code"
    t.string "operator"
    t.string "response_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delete_reasons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name_km"
    t.string "name_en"
    t.integer "display_order"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deleted_at"], name: "index_delete_reasons_on_deleted_at"
    t.index ["display_order"], name: "index_delete_reasons_on_display_order"
  end

  create_table "forms", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "form_type"
    t.integer "version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "audio"
    t.datetime "published_at"
    t.text "description"
  end

  create_table "importing_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "itemable_id"
    t.string "itemable_type"
    t.uuid "batch_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "kind", default: 2, comment: "ex: ngo, gov. agency, other (default)"
    t.text "address", default: ""
    t.string "logo"
    t.string "audio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.string "name_km"
    t.integer "display_order"
    t.index ["name"], name: "index_institutions_on_name"
  end

  create_table "notification_logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "notification_id"
    t.text "failed_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "registered_token_id"
  end

  create_table "notification_occurrences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "notification_id"
    t.datetime "occurrence_date"
    t.integer "token_count", default: 0
    t.integer "success_count", default: 0
    t.integer "failure_count", default: 0
    t.integer "status", default: 1
    t.string "job_id"
    t.datetime "cancelled_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "success_count"
    t.integer "failure_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "released_at"
    t.integer "status", default: 0
    t.integer "form_id"
    t.integer "token_count", default: 0
    t.integer "schedule_mode", default: 0
    t.string "recurrence_rule"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "occurrences_count", default: 0
    t.integer "occurrences_delivered_count", default: 0
    t.integer "releasor_id"
    t.datetime "cancelled_at"
    t.integer "canceller_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "options", force: :cascade do |t|
    t.integer "question_id"
    t.string "name"
    t.string "value"
    t.integer "score"
    t.string "alert_audio"
    t.text "alert_message"
    t.boolean "warning"
    t.boolean "recursive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

  create_table "options_chat_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "option_id"
    t.uuid "chat_group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.string "name_km"
    t.string "name_en"
    t.uuid "parent_id"
    t.integer "visits_count"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lft"], name: "index_pages_on_lft"
    t.index ["rgt"], name: "index_pages_on_rgt"
  end

  create_table "questions", force: :cascade do |t|
    t.string "code"
    t.text "name"
    t.string "type"
    t.string "hint"
    t.integer "display_order"
    t.string "relevant"
    t.boolean "required"
    t.string "audio"
    t.integer "passing_score"
    t.text "passing_message"
    t.string "passing_audio"
    t.text "failing_message"
    t.string "failing_audio"
    t.integer "form_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "section_id"
    t.boolean "tracking", default: false
  end

  create_table "registered_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "device_id"
    t.string "device_type"
    t.string "app_version"
    t.integer "device_os"
  end

  create_table "sections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "form_id"
    t.integer "display_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "survey_answers", force: :cascade do |t|
    t.string "uuid"
    t.integer "question_id"
    t.string "question_code"
    t.string "value"
    t.integer "score"
    t.string "user_uuid"
    t.string "survey_uuid"
    t.string "voice"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string "uuid"
    t.string "user_uuid"
    t.integer "form_id"
    t.datetime "quizzed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "notification_id"
    t.uuid "notification_occurrence_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.uuid "tag_id"
    t.string "taggable_id"
    t.string "taggable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count"
    t.integer "display_order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "telegram_bots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "token"
    t.string "username"
    t.string "telegram_bot_user_id"
    t.boolean "enabled", default: false
    t.boolean "active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_delete_reasons", force: :cascade do |t|
    t.bigint "user_id"
    t.uuid "delete_reason_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["delete_reason_id"], name: "index_user_delete_reasons_on_delete_reason_id"
    t.index ["user_id"], name: "index_user_delete_reasons_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid"
    t.string "full_name"
    t.string "sex"
    t.string "age"
    t.string "audio"
    t.datetime "registered_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
  end

  create_table "video_authors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "videos_count", default: 0
    t.integer "display_order", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "videos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "url"
    t.integer "display_order"
    t.uuid "video_author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "visits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "page_id"
    t.string "pageable_id"
    t.string "pageable_type"
    t.string "device_id"
    t.datetime "visit_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_uuid"
  end

  add_foreign_key "contacts", "institutions"
  add_foreign_key "country_institutions", "countries"
  add_foreign_key "country_institutions", "institutions"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
