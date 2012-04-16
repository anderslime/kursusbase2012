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

ActiveRecord::Schema.define(:version => 20120415194641) do

  create_table "course_relations", :force => true do |t|
    t.integer  "course_id"
    t.integer  "related_course_id"
    t.string   "related_course_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "group_no"
  end

  add_index "course_relations", ["course_id"], :name => "index_course_prerequisites_on_course_id"
  add_index "course_relations", ["related_course_id"], :name => "index_course_prerequisites_on_req_course_id"

  create_table "course_student_data", :force => true do |t|
    t.integer  "course_id"
    t.integer  "student_data_id"
    t.string   "semester"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "course_student_data", ["course_id"], :name => "index_course_student_data_on_course_id"
  add_index "course_student_data", ["student_data_id"], :name => "index_course_student_data_on_student_data_id"

  create_table "course_translations", :force => true do |t|
    t.integer  "course_id"
    t.string   "locale"
    t.string   "title"
    t.text     "teaching_form"
    t.string   "duration"
    t.string   "participant_limit"
    t.string   "registration"
    t.text     "course_objectives"
    t.text     "learn_objectives"
    t.text     "content"
    t.text     "litteratur"
    t.text     "remarks"
    t.text     "top_comment"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "former_course"
    t.text     "exam_form"
    t.string   "exam_aid"
    t.string   "evaluation_form"
  end

  add_index "course_translations", ["course_id"], :name => "index_course_translations_on_course_id"
  add_index "course_translations", ["locale"], :name => "index_course_translations_on_locale"

  create_table "course_type_translations", :force => true do |t|
    t.integer  "course_type_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "course_type_translations", ["course_type_id"], :name => "index_course_type_translations_on_course_type_id"
  add_index "course_type_translations", ["locale"], :name => "index_course_type_translations_on_locale"

  create_table "course_types", :force => true do |t|
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "course_type_type"
  end

  create_table "course_types_courses", :force => true do |t|
    t.integer "course_id"
    t.integer "course_type_id"
  end

  create_table "course_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "semester"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.integer  "course_number"
    t.string   "language"
    t.float    "ects_points"
    t.boolean  "open_education"
    t.string   "schedule"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "institute_id"
    t.string   "former_course"
    t.string   "exam_schedule"
    t.text     "exam_form"
    t.string   "exam_duration"
    t.string   "exam_aid"
    t.string   "evaluation_form"
    t.string   "homepage"
    t.string   "point_block"
    t.string   "qualified_prereq"
    t.string   "optional_prereq"
    t.string   "mandatory_prereq"
    t.boolean  "active"
  end

  create_table "courses_Schedules", :force => true do |t|
    t.integer "schedule_id"
    t.integer "course_id"
  end

  create_table "courses_keywords", :force => true do |t|
    t.integer "keyword_id"
    t.integer "course_id"
  end

  create_table "courses_student_datas", :force => true do |t|
    t.integer "course_id"
    t.integer "student_data_id"
  end

  create_table "courses_teachers", :force => true do |t|
    t.integer "teacher_id"
    t.integer "course_id"
  end

  create_table "field_of_studies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "institute_translations", :force => true do |t|
    t.integer  "institute_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "institute_translations", ["institute_id"], :name => "index_institute_translations_on_institute_id"
  add_index "institute_translations", ["locale"], :name => "index_institute_translations_on_locale"

  create_table "institutes", :force => true do |t|
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "dtu_institute_id"
  end

  create_table "keyword_translations", :force => true do |t|
    t.integer  "keyword_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "keyword_translations", ["keyword_id"], :name => "index_keyword_translations_on_keyword_id"
  add_index "keyword_translations", ["locale"], :name => "index_keyword_translations_on_locale"

  create_table "keywords", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedules", :force => true do |t|
    t.string   "block"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "student_data", :force => true do |t|
    t.string   "student_id"
    t.integer  "field_of_study_id"
    t.date     "start_date"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "student_data", ["field_of_study_id"], :name => "index_student_data_on_field_of_study_id"

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "dtu_teacher_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "direction_id"
    t.integer  "start_year"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "api_key"
    t.string   "username"
  end

  add_index "users", ["direction_id"], :name => "index_users_on_direction_id"

end
