class UpdateProjectConfig < ActiveRecord::Migration[5.0]
  def change
    drop_table :prconfigs

    create_table :project_configs do |t|
      t.string :name, default: ''
      t.text :content
      t.integer :project_id

      t.timestamps
    end
    add_index :project_configs, :project_id
    add_index :project_configs, :name
  end
end
