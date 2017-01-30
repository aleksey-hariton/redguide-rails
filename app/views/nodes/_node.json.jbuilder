json.extract! node, :id, :name, :environment_id, :status, :created_at, :updated_at
json.url node_url(node, format: :json)