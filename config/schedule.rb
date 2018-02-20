set :output, 'log/crontab.log'

rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env

every 1.month, :at => '5:00 am' do
  rake "mysql:dump"
  command "~/certbot-auto renew && sudo systemctl restart nginx"
end
