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

ActiveRecord::Schema.define(version: 20170527095501) do

  create_table "build_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       default: ""
    t.string   "url",        default: ""
    t.integer  "status",     default: 0
    t.integer  "duration",   default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "started_at"
  end

  create_table "changesets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key",                       default: ""
    t.integer  "project_id"
    t.integer  "author_id"
    t.text     "description", limit: 65535,              null: false
    t.string   "slug"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["author_id"], name: "index_changesets_on_author_id", using: :btree
    t.index ["key"], name: "index_changesets_on_key", using: :btree
    t.index ["project_id"], name: "index_changesets_on_project_id", using: :btree
    t.index ["slug"], name: "index_changesets_on_slug", unique: true, using: :btree
  end

  create_table "cookbook_builds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cookbook_id"
    t.integer  "changeset_id"
    t.integer  "build_job_id",      default: 0
    t.integer  "foodcritic_status", default: 0
    t.integer  "cookstyle_status",  default: 0
    t.integer  "rspec_status",      default: 0
    t.integer  "kitchen_status",    default: 0
    t.integer  "approve_status",    default: 0
    t.string   "commit_sha",        default: ""
    t.string   "remote_branch",     default: ""
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "pull_request_id"
    t.index ["build_job_id"], name: "index_cookbook_builds_on_build_job_id", using: :btree
    t.index ["changeset_id"], name: "index_cookbook_builds_on_changeset_id", using: :btree
    t.index ["commit_sha"], name: "index_cookbook_builds_on_commit_sha", using: :btree
    t.index ["cookbook_id"], name: "index_cookbook_builds_on_cookbook_id", using: :btree
  end

  create_table "cookbooks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",           default: ""
    t.string   "vcs_url",        default: ""
    t.integer  "project_id"
    t.integer  "avg_build_time", default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "slug"
    t.index ["name"], name: "index_cookbooks_on_name", using: :btree
    t.index ["project_id"], name: "index_cookbooks_on_project_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "environments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_environments_on_organization_id", using: :btree
  end

  create_table "error_reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "stacktrace",        limit: 65535
    t.text     "error_msg",         limit: 65535
    t.text     "error_passed",      limit: 65535
    t.text     "changed_resources", limit: 65535
    t.integer  "node_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "status"
    t.index ["node_id"], name: "index_error_reports_on_node_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "nodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "environment_id"
    t.integer  "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["environment_id"], name: "index_nodes_on_environment_id", using: :btree
  end

  create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key"
    t.string   "jenkins_host",                           default: ""
    t.string   "cookbook_build_job",                     default: ""
    t.string   "environment_build_job",                  default: ""
    t.text     "foodcritic_config",        limit: 65535,              null: false
    t.text     "cookstyle_config",         limit: 65535,              null: false
    t.text     "kitchen_config",           limit: 65535,              null: false
    t.text     "description",              limit: 65535,              null: false
    t.string   "slug"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "jenkins_user"
    t.string   "jenkins_password"
    t.string   "vcs_server"
    t.string   "vcs_server_user"
    t.string   "vcs_server_user_password"
    t.string   "vcs_server_project"
    t.string   "chef_user"
    t.text     "chef_user_pem",            limit: 65535
    t.string   "supermarket_url"
    t.string   "chef_server_url"
    t.index ["key"], name: "index_projects_on_key", unique: true, using: :btree
    t.index ["slug"], name: "index_projects_on_slug", unique: true, using: :btree
  end

  create_table "pull_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "url"
    t.string   "short"
    t.integer  "status"
    t.text     "message",           limit: 65535
    t.integer  "cookbook_build_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["cookbook_build_id"], name: "index_pull_requests_on_cookbook_build_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                default: "",      null: false
    t.string   "encrypted_password",                   default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text     "tokens",                 limit: 65535
    t.string   "provider",                             default: "email", null: false
    t.string   "uid",                                  default: "",      null: false
    t.integer  "sign_in_count",                        default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "name"
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "environments", "organizations"
  add_foreign_key "error_reports", "nodes"
  add_foreign_key "nodes", "environments"
end
