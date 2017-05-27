class AddStageIdToSteps < ActiveRecord::Migration[5.0]
  def change
    add_reference :steps, :stage, foreign_key: true
  end
end
