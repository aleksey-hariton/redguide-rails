class CreatePullRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :pull_requests do |t|
      t.string :url
      t.string :short
      t.integer :status
      t.text :message
      t.integer :cookbook_build_id

      t.timestamps
    end
    add_index :pull_requests, :cookbook_build_id
  end
end
