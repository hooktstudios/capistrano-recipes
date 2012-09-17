# Credits to Ariejan de Vroom (ariejan@ariejan.net)
#
# @see http://ariejan.net/2011/09/14/lighting-fast-zero-downtime-deployments-with-git-capistrano-nginx-and-unicorn

rails_env = 'production'

app_base_path = File.join('/home/user/website')
shared_path = File.join(app_base_path, 'shared')
app_path = File.join(app_base_path, 'current')
pid_path = File.join(shared_path, 'pids', 'unicorn.pid')

worker_processes 2

# This loads the application in the master process before forking worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html
preload_app true

timeout 30

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen File.join(shared_path, 'tmp', 'sockets', 'unicorn.sock'), :backlog => 64

pid pid_path

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory app_path

# Set the path of the log files inside the log folder of the testapp
stderr_path File.join(shared_path, 'log', 'unicorn.stderr.log')
stdout_path File.join(shared_path, 'log', 'unicorn.stdout.log')

before_fork do |server, worker|
  # This option works in together with preload_app true setting
  # What is does is prevent the master process from holding
  # the database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = pid_path+".oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

end

after_fork do |server, worker|
  # Here we are establishing the connection after forking worker
  # processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
