class RemoveProjectTypeIdFromProject < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :project_type_id, :string
  end
end
