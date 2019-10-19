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

ActiveRecord::Schema.define(version: 2019_10_18_153837) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "appointments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "patient_id"
    t.datetime "appointment_date"
    t.string "appointment_kind"
    t.string "status"
    t.text "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "consultations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "patient_id"
    t.text "main_complain"
    t.date "date_done"
    t.text "biometric_exam"
    t.text "thoracil_exam"
    t.text "abdominal_exam"
    t.text "members"
    t.text "diagnostic_hypothesis"
    t.text "conduct_adopt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
  end

  create_table "diseases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "description"
    t.string "icd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diseases_patients", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "disease_id", null: false
    t.bigint "patient_id", null: false
    t.index ["disease_id"], name: "index_diseases_patients_on_disease_id"
    t.index ["patient_id"], name: "index_diseases_patients_on_patient_id"
  end

  create_table "exams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "patient_id"
    t.string "title"
    t.text "conclusion"
    t.text "exam_table"
    t.datetime "date_done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_exams_on_patient_id"
  end

  create_table "patients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "protocol_number"
    t.date "patient_since"
    t.string "name"
    t.date "birth"
    t.integer "age"
    t.string "cpf"
    t.string "gender"
    t.string "etnia"
    t.string "civil_status"
    t.string "occupation"
    t.string "scholarity"
    t.string "zip"
    t.string "district"
    t.string "address"
    t.string "city"
    t.string "uf"
    t.string "telephone"
    t.string "mobile"
    t.string "email"
    t.text "indication_by"
    t.string "health_plan"
    t.date "plan_validation"
    t.string "plan_number"
    t.text "history_current_disease"
    t.text "previous_pathological_history"
    t.text "mother_history"
    t.text "father_history"
    t.text "social_history"
    t.text "physiological_history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "health_insurance"
    t.string "national_identification"
    t.text "description"
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "parent"
    t.string "name"
    t.integer "role"
    t.string "mobile"
    t.string "cpf"
    t.string "crm"
    t.string "speciality"
    t.string "plan"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "patients"
  add_foreign_key "appointments", "users"
  add_foreign_key "consultations", "patients"
  add_foreign_key "exams", "patients"
  add_foreign_key "patients", "users"
end
