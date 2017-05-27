class AddProjectTypeIdProjectTypeNameToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :project_type_id, :integer
    add_column :projects, :project_type_name, :string
  end
end
