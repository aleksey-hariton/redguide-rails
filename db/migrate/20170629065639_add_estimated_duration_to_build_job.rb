class AddEstimatedDurationToBuildJob < ActiveRecord::Migration[5.0]
  def change
    add_column :build_jobs, :estimated_duration, :integer, default: 0
  end
end
