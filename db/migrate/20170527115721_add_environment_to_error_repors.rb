class AddEnvironmentToErrorRepors < ActiveRecord::Migration[5.0]
  def change
    add_column :error_reports, :environment_id, :integer
    add_index :error_reports, :environment_id
  end
end
