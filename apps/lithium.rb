# Lithium variables
set :lithium_app_path, "app"
# Shared folders
set :app_shared_folders, [
  'app/resources',
   ]
set :app_shared_create, app_shared_folders + [
  'app/config/bootstrap',
  'app/resources/tmp/cache/templates', 
  'app/resources/tmp/logs',
  'app/resources/tmp/tests'
  ]

# Custom events configuration
after "deploy:update_code", "lithium:update_code"
after "deploy:setup", "lithium:setup"

# Custom deployment tasks
namespace :deploy do
  desc "This is here to overide the original :restart"
  task :restart, :roles => :app do
    # do nothing but overide the default
  end
end

namespace :lithium do
  task :update_code, :roles => :app do
    # link the db config file
    run "ln -s -f #{deploy_to}/#{shared_dir}/app/config/bootstrap/connections.php #{release_path}/#{lithium_app_path}/config/bootstrap/connections.php"

    # Link shared data directories
    app_shared_folders.each do |folder|
      # remove fresh deploy folder    
      run "rm -rf #{release_path}/#{folder}"
      # create symlink to shared folder
      run "ln -s #{deploy_to}/#{shared_dir}/#{folder} #{release_path}/#{folder}"
    end
  end
  
  desc "Create directories and set permissions after initial setup"
  task :setup, :roles => :app do
    # create shared data directories
    app_shared_create.each do |folder|
      run "mkdir -p #{deploy_to}/#{shared_dir}/#{folder}"
    end
  end
end