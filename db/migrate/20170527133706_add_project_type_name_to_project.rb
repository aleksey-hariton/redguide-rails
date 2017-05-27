class AddProjectTypeNameToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :project_type_name, :string
  end
end
