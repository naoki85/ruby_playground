set :output, 'log/crontab.log'

rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env

every 1.day, :at => '8:00 am' do
  runner "Tasks::PostPublishedTweet.execute", output: { error: 'log/cron_error.log' }
end

every 1.month, :at => '5:00 am' do
  rake "mysql:dump"
  command "sudo /home/naoki_yoneyama/certbot-auto renew && sudo systemctl restart nginx"
end

