class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :key
      t.string :jenkins_host, default: ''
      t.string :cookbook_build_job, default: ''
      t.string :environment_build_job, default: ''
      t.text :foodcritic_config, null: false
      t.text :cookstyle_config, null: false
      t.text :kitchen_config, null: false
      t.text :description, null: false
      t.string :slug

      t.timestamps
    end
    add_index :projects, :slug, unique: true
    add_index :projects, :key,  unique: true
  end
end
