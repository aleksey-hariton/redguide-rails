class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.string :name
      t.references :environment, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
