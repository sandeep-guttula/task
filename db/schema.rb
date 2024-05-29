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

ActiveRecord::Schema[7.1].define(version: 2024_05_29_165505) do
  create_table "student_teacher_subjects", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "student_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_teacher_subjects_on_student_id"
    t.index ["subject_id"], name: "index_student_teacher_subjects_on_subject_id"
    t.index ["teacher_id", "student_id", "subject_id"], name: "index_student_teacher_subjects_on_teacher_student_subject", unique: true
    t.index ["teacher_id"], name: "index_student_teacher_subjects_on_teacher_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_subjects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_teacher_subjects_on_subject_id"
    t.index ["user_id"], name: "index_teacher_subjects_on_user_id"
  end

  create_table "user_active_sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.integer "user_id", null: false
    t.boolean "status", null: false
    t.datetime "session_expiry", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_active_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "role", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "student_teacher_subjects", "subjects"
  add_foreign_key "student_teacher_subjects", "users", column: "student_id"
  add_foreign_key "student_teacher_subjects", "users", column: "teacher_id"
  add_foreign_key "teacher_subjects", "subjects"
  add_foreign_key "teacher_subjects", "users"
  add_foreign_key "user_active_sessions", "users"
end
