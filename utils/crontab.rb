namespace :crontab do
  desc "Reload crontab"
  task :reload, :roles => :app do
    run "crontab #{release_path}/config/crontab"
  end
end