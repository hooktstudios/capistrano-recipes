namespace :php_fpm do
	desc "Reload PHP5-FPM (requires sudo access to /usr/sbin/service php5-fpm reload)"
	task :reload, :roles => :app do
		run "sudo /usr/sbin/service php5-fpm reload"
	end
end