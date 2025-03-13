namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      branch = fetch(:branch)
      unless `git rev-parse HEAD` == `git rev-parse #{branch}`
        puts "WARNING: HEAD is not the same as origin/#{branch}"
        puts "Run `git push` to sync changes."
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'unicorn:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  task :upload_env do
    on roles(:app) do
      if File.exist?(".env")
        upload! ".env", "#{shared_path}/.env"
      else
        p "file does not exist: .test"
      end
    end
  end

  before :starting,     :check_revision
  after  :started,      :upload_env
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

after 'deploy:published', 'ridgepole:apply'
