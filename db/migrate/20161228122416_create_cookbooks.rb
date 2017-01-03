class CreateCookbooks < ActiveRecord::Migration[5.0]
  def change
    create_table :cookbooks do |t|
      t.string :name, default: ''
      t.string :vcs_url, default: ''
      t.integer :project_id
      t.integer :avg_build_time, default: 0

      t.timestamps
    end
    add_index :cookbooks, :project_id
    add_index :cookbooks, :name
  end
end
