json.extract! project,
              :id,
              :key,
              :description,
              :slug,
              :supermarket_url,
              :chef_server_url,
              :chef_user,
              :chef_user_pem
json.url project_url(project, format: :json)