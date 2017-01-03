class AddStartedAtToBuildJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :build_jobs, :started_at, :datetime
  end
end
