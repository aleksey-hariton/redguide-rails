class AddJenkinsJobToStages < ActiveRecord::Migration[5.0]
  def change
    add_column :stages, :jenkins_job, :string
  end
end
