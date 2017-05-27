class AddStagesToBuildJob < ActiveRecord::Migration[5.0]
  def change
    add_column :build_jobs, :stages, :text
  end
end
