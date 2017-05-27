class RemovePredefinedConfigFromProject < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :foodcritic_config, :string
    remove_column :projects, :cookstyle_config, :string
    remove_column :projects, :kitchen_config, :string
  end
end
