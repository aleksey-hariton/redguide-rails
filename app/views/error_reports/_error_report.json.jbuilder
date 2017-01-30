json.extract! error_report, :id, :stacktrace, :error_msg, :error_passed, :changed_resources, :node_id, :created_at, :updated_at
json.url error_report_url(error_report, format: :json)