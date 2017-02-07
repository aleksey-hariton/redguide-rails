class CreateErrorReports < ActiveRecord::Migration[5.0]
  def change
    create_table :error_reports do |t|
      t.text :stacktrace
      t.text :error_msg
      t.text :error_passed
      t.text :changed_resources
      t.references :node, foreign_key: true

      t.timestamps
    end
  end
end
