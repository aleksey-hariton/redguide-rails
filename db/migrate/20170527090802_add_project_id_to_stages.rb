class AddProjectIdToStages < ActiveRecord::Migration[5.0]
  def change
    add_reference :stages, :project, foreign_key: true
  end
end
