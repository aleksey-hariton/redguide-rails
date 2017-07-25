class AddUrlsToSteps < ActiveRecord::Migration[5.0]
  def change
    add_column :steps, :urls, :text
  end
end
