class CreateStageBuilds < ActiveRecord::Migration[5.0]
  def change
    create_table :stage_builds do |t|
      t.integer :stage_id
      t.integer :changeset_id
      t.integer :build_job_id
      t.integer :status

      t.timestamps
    end
  end
end
