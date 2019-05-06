# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "book_recorder"
set :repo_url, "git@bitbucket.org:naoki_yoneyama_85/book_recorder.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/naoki_yoneyama/book_recorder'
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto
set :format, :pretty
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"
set :linked_files, %w{ .env config/database.yml config/secrets.yml config/storage.yml }

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, %w{ log tmp/pids tmp/cache tmp/sockets vendor/bundle public/sitemaps }
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

# rbenvをシステムにインストールしたか? or ユーザーローカルにインストールしたか?
set :rbenv_type, :user # :system or :user
# rubyのversion
set :rbenv_ruby, '2.6.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# bundle installの並列実行数
set :bundle_jobs, 4

# whenever
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
