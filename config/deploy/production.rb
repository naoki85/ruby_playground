set :rails_env, 'production'
set :unicorn_rack_env, 'deployment'

set :branch, ENV['BRANCH_NAME'] || 'master'

# role :app, %w{user@example.com}
# role :web, %w{user@example.com}
# role :db,  %w{user@example.com}
server '13.231.79.158', user: 'naoki_yoneyama', roles: %w{web app db}

# For Ridgepole
set :ridgepole_env, fetch(:rails_env)
set :ridgepole_roles, :db
set :ridgepole_schema_file, File.join(current_path, 'db/schemas', 'Schemafile')
set :ridgepole_config_file, File.join(current_path, 'config', 'database.yml')

after 'webpacker:compile', 'assets:sync'
