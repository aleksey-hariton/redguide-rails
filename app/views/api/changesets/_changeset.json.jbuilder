json.extract! changeset, :key, :description, :slug, :created_at, :updated_at
json.project_slug changeset.project.slug
json.url project_changeset_url(changeset.project, changeset)
json.set! 'cookbooks' do
  changeset.cookbook_builds.each do |cookbook|
    json.set! cookbook.cookbook.name do
      json.status cookbook.status
      json.foodcritic_status cookbook.foodcritic_status
      json.cookstyle_status cookbook.cookstyle_status
      json.rspec_status cookbook.rspec_status
      json.kitchen_status cookbook.kitchen_status
      json.vcs_url cookbook.cookbook.vcs_url
      json.commit_sha cookbook.commit_sha
      json.remote_branch cookbook.remote_branch
    end
  end
end