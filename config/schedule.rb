set :output, 'log/crontab.log'

rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env

every 1.day, :at => '4:00 am' do
  runner "Tasks::DailyCrawl.execute", output: { error: 'log/cron_error.log' }
end

every 1.day, :at => '5:00 am' do
  runner "Tasks::PickupBookCategories.execute", output: { error: 'log/cron_error.log' }
end

every 1.day, :at => '6:00 am' do
  rake "sitemap:refresh"
end

every 1.month, :at => '5:00 am' do
  rake "mysql:dump"
  command "~/certbot-auto renew && sudo systemctl restart nginx"
end
