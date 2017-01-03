class AddVcsServerProjectToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :vcs_server_project, :string
  end
end
