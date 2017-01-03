class CreateChangesets < ActiveRecord::Migration[5.0]
  def change
    create_table :changesets do |t|
      t.string :key, default: ''
      t.integer :project_id
      t.integer :author_id
      t.text :description, null: false
      t.string :slug

      t.timestamps
    end
    add_index :changesets, :key
    add_index :changesets, :project_id
    add_index :changesets, :author_id
    add_index :changesets, :slug, unique: true
  end
end
