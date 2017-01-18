json.extract! project,
              :id,
              :key,
              :description,
              :slug,
              :foodcritic_config,
              :cookstyle_config,
              :kitchen_config,
              :supermarket_url,
              :chef_server_url,
              :chef_user,
              :chef_user_pem
json.url project_url(project, format: :json)