class AddStatusToErrorReports < ActiveRecord::Migration[5.0]
  def change
    add_column :error_reports, :status, :integer
  end
end
