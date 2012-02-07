# From Webistrano template
# @see https://github.com/peritor/webistrano/blob/master/lib/webistrano/template/mod_rails.rb

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    mod_rails.restart
  end

  task :start, :roles => :app, :except => { :no_release => true } do
    mod_rails.start
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    mod_rails.stop
  end
end

namespace :mod_rails do
  desc "start mod_rails & Apache"
  task :start, :roles => :app, :except => { :no_release => true } do
    as = fetch(:runner, "app")
    invoke_command "#{apache_init_script} start", :via => run_method, :as => as
  end

  desc "stop mod_rails & Apache"
  task :stop, :roles => :app, :except => { :no_release => true } do
    as = fetch(:runner, "app")
    invoke_command "#{apache_init_script} stop", :via => run_method, :as => as
  end

  desc "restart mod_rails"
  task :restart, :roles => :app, :except => { :no_release => true } do
    as = fetch(:runner, "app")
    restart_file = fetch(:mod_rails_restart_file, "#{deploy_to}/current/tmp/restart.txt")
    invoke_command "touch #{restart_file}", :via => run_method, :as => as
  end
end