require 'active_record'

namespace :mysql do
  desc 'Dumps the database'
  task :dump do
    return unless Rails.env.production?

    configuration = { database: ENV['PRODUCTION_DB_NAME'],
                      username: ENV['PRODUCTION_DB_USER'],
                      password: ENV['PRODUCTION_DB_PASSWORD'] }

    db_esc_path = '/var/log/mysqldump'
    timestamp = Time.now.strftime("%Y_%m_%d_%H_%M_%S")
    backup_file = "#{db_esc_path}/#{timestamp}.sql"

    cmd = "MYSQL_PWD=#{configuration[:password]} mysqldump -h localhost -u #{configuration[:username]} #{configuration[:database]} > #{backup_file}"

    puts cmd
    exec cmd
  end
end
