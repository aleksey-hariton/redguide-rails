class AddChefUserToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :chef_user, :string
    add_column :projects, :chef_user_pem, :text
    add_column :projects, :supermarket_url, :string
    add_column :projects, :chef_server_url, :string
  end
end
