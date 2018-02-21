namespace :sitemap do
  desc 'Sitemap refresh'
  task :refresh do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'sitemap:refresh'
        end
      end
    end
  end
end
