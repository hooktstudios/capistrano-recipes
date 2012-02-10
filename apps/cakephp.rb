# CakePHP variables
set :cakephp_app_path, "app"
set :cakephp_core_path, "cakephp/cake"
# Symlinked folders on each deployment
set :app_shared_folders, [
  'data', 
  'tmp',
  ]
# Shared subfolders that are created on initial setup
set :app_shared_create, app_shared_folders + [
  'config',
  'tmp/cache/models', 
  'tmp/cache/persistent',
  'tmp/cache/views',
  'tmp/cache/logs',
  'tmp/sessions'
  ]
# Custom events configuration
after "deploy:update_code", "cakephp:update_code"
after "deploy:setup", "cakephp:setup"

namespace :deploy do
  desc "This is here to overide the original task"
  task :restart, :roles => :app, :except => { :no_release => true } do
    # do nothing
  end

  desc "This is here to overide the original task"
  task :start, :roles => :app, :except => { :no_release => true } do
    # do nothing
  end

  desc "This is here to overide the original task"
  task :stop, :roles => :app, :except => { :no_release => true } do
    # do nothing
  end

  desc "This is here to overide the original task"
  task :finalize_update, :roles => :app, :except => { :no_release => true } do
    # do nothing
  end
end

namespace :cakephp do 
  desc "Link CakePHP shared directories & clear persistent cache"
  task :update_code, :roles => :app do
    # Link the local environment boostrap file
    run "ln -s -f #{deploy_to}/#{shared_dir}/app/config/bootstrap.local.php #{release_path}/#{cakephp_app_path}/config/bootstrap.local.php"

    # Link shared data directories
    app_shared_folders.each do |folder|
      # remove fresh deploy folder    
      run "rm -rf #{release_path}/#{cakephp_app_path}/#{folder}"
      # create symlink to shared folder
      run "ln -s #{deploy_to}/#{shared_dir}/app/#{folder} #{release_path}/#{cakephp_app_path}/#{folder}"
    end
    
    # Clear persistent cache
    run "rm -f #{deploy_to}/#{shared_dir}/app/tmp/cache/persistent/*"
  end

  desc "Create shared directories after initial setup"
  task :setup, :roles => :app do
    # Create shared data directories
    app_shared_create.each do |folder|
      run "mkdir -p #{deploy_to}/#{shared_dir}/app/#{folder}"
    end
  end

  desc "Verify CakePHP TestSuite pass" 
  task :testsuite, :roles => :app do 
    run "#{release_path}/#{cakephp_cake_path}/console/cake testsuite app all -app #{release_path}/#{cakephp_app_path}", :env => { :TERM => "linux" } do |channel, stream, data|
      if stream == :err then
        error = CommandError.new("CakePHP TestSuite failed")
        raise error
      else
        puts data
      end
    end
  end
end