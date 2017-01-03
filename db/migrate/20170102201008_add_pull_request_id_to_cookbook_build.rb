class AddPullRequestIdToCookbookBuild < ActiveRecord::Migration[5.0]
  def change
    add_column :cookbook_builds, :pull_request_id, :integer
  end
end
