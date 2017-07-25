class AddStageTypeToStages < ActiveRecord::Migration[5.0]
  def change
    add_column :stages, :stage_type, :text
  end
end
