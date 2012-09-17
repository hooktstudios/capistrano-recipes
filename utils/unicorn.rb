set :unicorn_cmd, "unicorn"
# For rails application, use :
# set :unicorn_cmd, "unicorn_rails"

namespace :unicorn do
  desc "Restart the server (unicorn)"
  task :restart do
    run "if [ `cat #{shared_path}/pids/unicorn.pid` ]; then kill -s USR2 $(cat #{shared_path}/pids/unicorn.pid); fi"
  end

  desc "Start the server (unicorn)"
  task :start do
    run "cd #{current_path} && bundle exec #{unicorn_cmd} -D -E #{rails_env} -c config/unicorn.rb"
  end

  desc "Stop the server (unicorn)"
  task :stop do
    run "if [ `cat #{shared_path}/pids/unicorn.pid` ]; then kill $(cat #{shared_path}/pids/unicorn.pid); fi"
  end
end