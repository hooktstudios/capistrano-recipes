set :shared_children, %w{ wp-content/uploads }

# Custom events configuration
after "deploy:update_code", "wordpress:update_code"

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

namespace :wordpress do
  desc "Link all the config files to the shared directory"
  task :update_code do
    run "ln -s #{File.join(shared_path, 'wp-config.php')} #{release_path}"

    shared_children.each do |shared_child|
      run "if [ ! -h #{File.join(release_path, shared_child)} ]; then rm -rf #{File.join(release_path, shared_child)} && ln -s #{File.join(shared_path, shared_child)} #{File.join(release_path, shared_child)}; fi"
    end
  end
end