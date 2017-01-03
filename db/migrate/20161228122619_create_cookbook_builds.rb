class CreateCookbookBuilds < ActiveRecord::Migration[5.0]
  def change
    create_table :cookbook_builds do |t|
      t.integer :cookbook_id
      t.integer :changeset_id
      t.integer :build_job_id, default: 0
      t.integer :foodcritic_status, default: 0
      t.integer :cookstyle_status, default: 0
      t.integer :rspec_status, default: 0
      t.integer :kitchen_status, default: 0
      t.integer :approve_status, default: 0
      t.string :commit_sha, default: ''
      t.string :remote_branch, default: ''

      t.timestamps
    end

    add_index :cookbook_builds, :cookbook_id
    add_index :cookbook_builds, :changeset_id
    add_index :cookbook_builds, :build_job_id
    add_index :cookbook_builds, :commit_sha
  end
end
