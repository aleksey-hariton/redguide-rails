class CreateBuildJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :build_jobs do |t|
      t.string :name, default: ''
      t.string :url, default: ''
      t.integer :status, default: 0
      t.integer :duration, default: 0

      t.timestamps
    end
  end
end
