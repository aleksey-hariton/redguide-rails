json.extract! cookbook_build, :id, :cookbook_id, :foodcritic_status, :cookstyle_status, :rspec_status, :kitchen_status, :approve_status, :commit_sha, :remote_branch, :build_job_id, :created_at, :updated_at
json.url cookbook_build_url(cookbook_build, format: :json)