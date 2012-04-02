namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{File.join current_path, 'tmp'} && touch restart.txt"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    abort "See instead unicorn related task."
  end

  task :start, :roles => :app, :except => { :no_release => true } do
    abort "See instead unicorn related task."
  end
end
