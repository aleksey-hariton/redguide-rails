class AddStageIdToCookbookBuild < ActiveRecord::Migration[5.0]
  def change
    add_reference :cookbook_builds, :stage, foreign_key: true
  end
end
