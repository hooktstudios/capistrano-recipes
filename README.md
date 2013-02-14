# HS Standard Capistrano Recipes

Mostly intented for internal use at HS, but we publish it as some parts might be usefull to the community and we use stuff from the community.

## Typical Usage

1 - Add this repository as as submodule

    git submodule add git://github.com/hooktstudios/capistrano-recipes.git config/capistrano-recipes

2 - Add the desired recipes in your deploy.rb (remember cap relative path is the project root), ie:

    load 'config/capistrano-recipes/apps/wordpress'
    load 'config/capistrano-recipes/utils/assets'
    after "deploy:update_code", "assets:sass_compile"

## Important Notes

### Apps Recipes

Theses recipes configure and/or overwrite Capistrano default behaviour events as required by those kind of apps or deployments.

### Utils Recipes

Theses recipes do not configure any event, you must specify it in your deploy.rb.

Ex. `after "deploy:update_code", "assets:sass_compile"`.

Plug them in your recipe as needed.

### Tips for Easy Deployments

* Deploy via remote-cache, much faster/better `set :deploy_via, :remote_cache`.
* Use SSH forwarding instead of custom deployments keys with `ssh_options[:forward_agent] = true`. It will uses your local SSH key to access the repository from the remote server.
* Multistage is much easier with `require 'capistrano/ext/multistage'` and `set :capistrano_extensions, [:multistage]`. 
see https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension.
* Use bundler extension for rails app, with  `require "bundler/capistrano"` and `after 'deploy', 'bundle:install'`.

## What's in this? 

You'll find tasks and informations to manage various tasks with capistrano such as :

* Ruby apps
    * RVM (ruby version manager : run proper ruby version for your deployment)
    * Bundler (app packages management)
    * Unicorn (fast & zero-downtime deployments)
    * ModRails (quick & easy)
* PHP apps
    * CakePHP
    * Lithium
    * PHP-FPM
* Assets management
    * LESS precompile
    * SASS precompile
* Other
    * Crontab reload

More details on some of the recipes below.

## Ruby Recipes

### Unicorn Zero-Downtime Deployments

Check the provided sample configuration (config-samples/unicorn.rb)

## PHP Recipes

### PHP-fpm Reload

You may need to reload php-fpm if you are using APC or other accelerators because of symlinks caching issues.

Your deployment user will need permission to reload php-fpm. You may edit your /etc/sudoers like so for userx:

    userx ALL=(root) NOPASSWD: /usr/sbin/service php5-fpm reload

### CakePHP

To set environment specific configurations, we use a symlinked shared config file : `shared/app/config/bootstrap.local.php`.  
You may add this to the default CakePHP bootstrap file to load environement specific configurations :

    if(file_exists(APP . DS . 'config' . DS . 'bootstrap.local.php')) {
    	include(APP . DS . 'config' . DS . 'bootstrap.local.php');
    }

## Contributing

See [CONTRIBUTING.md](https://github.com/hooktstudios/capistrano-recipes/blob/master/CONTRIBUTING.md) for more details on contributing and running test.

## Credits

![hooktstudios](http://hooktstudios.com/logo.png)

[capistrano-recipes](https://rubygems.org/gems/capistrano-recipes) is maintained and funded by [hooktstudios](https://github.com/hooktstudios)