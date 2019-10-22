# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_18_031345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "presentations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "viewing_id", null: false
    t.uuid "slideshow_id", null: false
    t.uuid "slide_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slide_id"], name: "index_presentations_on_slide_id"
    t.index ["slideshow_id"], name: "index_presentations_on_slideshow_id"
    t.index ["viewing_id"], name: "index_presentations_on_viewing_id"
  end

  create_table "presented_quiz_options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "presented_quiz_id", null: false
    t.string "text"
    t.index ["presented_quiz_id"], name: "index_presented_quiz_options_on_presented_quiz_id"
  end

  create_table "presented_quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_id", null: false
    t.string "quizzable_type"
    t.uuid "quizzable_id"
    t.index ["quiz_id"], name: "index_presented_quizzes_on_quiz_id"
    t.index ["quizzable_type", "quizzable_id"], name: "index_presented_quizzes_on_quizzable_type_and_quizzable_id"
  end

  create_table "presented_slides", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "presentation_id", null: false
    t.uuid "slide_id", null: false
    t.integer "state", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["presentation_id"], name: "index_presented_slides_on_presentation_id"
    t.index ["slide_id"], name: "index_presented_slides_on_slide_id"
  end

  create_table "quiz_options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_id", null: false
    t.string "text"
    t.index ["quiz_id"], name: "index_quiz_options_on_quiz_id"
  end

  create_table "quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "quizzable_type"
    t.uuid "quizzable_id"
    t.string "title"
    t.integer "quiz_type", default: 0, null: false
    t.index ["quizzable_type", "quizzable_id"], name: "index_quizzes_on_quizzable_type_and_quizzable_id"
  end

  create_table "slides", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.uuid "slideshow_id"
    t.integer "ordinal", null: false
    t.index ["ordinal", "slideshow_id"], name: "index_slides_on_ordinal_and_slideshow_id"
    t.index ["slideshow_id"], name: "index_slides_on_slideshow_id"
  end

  create_table "slideshows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_slideshows_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "viewers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "viewing_id", null: false
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "index_viewers_on_user_id"
    t.index ["viewing_id"], name: "index_viewers_on_viewing_id"
  end

  create_table "viewings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "presentation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["presentation_id"], name: "index_viewings_on_presentation_id"
    t.index ["user_id"], name: "index_viewings_on_user_id"
  end

  create_table "votes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "viewer_id", null: false
    t.uuid "presented_quiz_id", null: false
    t.uuid "presented_quiz_option_id", null: false
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["presented_quiz_id"], name: "index_votes_on_presented_quiz_id"
    t.index ["presented_quiz_option_id"], name: "index_votes_on_presented_quiz_option_id"
    t.index ["viewer_id"], name: "index_votes_on_viewer_id"
  end

end
