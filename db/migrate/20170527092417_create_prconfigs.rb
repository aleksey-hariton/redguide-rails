class CreatePrconfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :prconfigs do |t|
      t.string :name, default: ''
      t.text :content
      t.integer :project_id

      t.timestamps
    end
    add_index :prconfigs, :project_id
    add_index :prconfigs, :name
  end
end
