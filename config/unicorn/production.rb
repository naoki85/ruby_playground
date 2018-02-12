app_path = '/home/naoki_yoneyama/book_recorder'

# チューニングが必要（CPUコア数 + 1が無難）
worker_processes 2
working_directory "#{app_path}/current"

# This loads the application in the master process before forking
# worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html
preload_app true

timeout 30

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen "#{app_path}/shared/tmp/sockets/unicorn.sock", :backlog => 64
# listen '/tmp/unicorn.sock', :backlog => 64

pid "#{app_path}/shared/tmp/pids/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "#{app_path}/current/log/unicorn.stderr.log"
stdout_path "#{app_path}/current/log/unicorn.stdout.log"

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  # if @shards.present?
  #   defined?(ActiveRecord::Base) and
  #       ActiveRecord::Base.connection_proxy.instance_variable_get(:@shards).each {|k,v| v.disconnect! }
  # else
  #   defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  # end

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  sleep 1
end

after_fork do |server, worker|
  # https://github.com/thiagopradi/octopus/issues/59（octopus + unicorn）
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
  # if @shards.present?
  #   defined?(ActiveRecord::Base) and
  #       ActiveRecord::Base.connection_proxy.instance_variable_get(:@shards).each {|k,v| v.clear_reloadable_connections! }
  # else
  #   defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
  # end
end