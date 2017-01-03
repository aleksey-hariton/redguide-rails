json.extract! build_job, :id, :name, :url, :console_out, :status, :created_at, :updated_at
json.url build_job_url(build_job, format: :json)