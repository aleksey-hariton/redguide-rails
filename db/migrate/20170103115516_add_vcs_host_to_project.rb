class AddVcsHostToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :vcs_server, :string
    add_column :projects, :vcs_server_user, :string
    add_column :projects, :vcs_server_user_password, :string
  end
end
