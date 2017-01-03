class AddJenkinsUserToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :jenkins_user, :string
    add_column :projects, :jenkins_password, :string
  end
end
