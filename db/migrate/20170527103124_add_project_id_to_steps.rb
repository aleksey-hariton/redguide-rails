class AddProjectIdToSteps < ActiveRecord::Migration[5.0]
  def change
    add_reference :steps, :project, foreign_key: true
  end
end
