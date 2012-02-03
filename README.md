# HS standard Capistrano recipes

What's in this? You'll find tasks and informations to manage various stuff with capistrano like :

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
    * Multistages
    * SSH forwarding
    * Crontab reload

## Typical usage

How to use theses recipes in your recipe?

1 - Add this repository as as submodule

    git submodule add git://github.com/hooktstudios/capistrano-recipes.git config/capistrano-recipes

2 - Add the desired recipes in your deploy.rb (remember cap relative path is the project root), ex:

    load 'config/capistrano-recipes/apps/wordpress'
    load 'config/capistrano-recipes/utils/assets'
    after "deploy:update_code", "assets:sass_compile"

Important Notes :

- Apps recipes configures/overwrites the default behaviour events
- Utils recipes do not configure any event, you must specify them, ex. after "deploy:update_code", "assets:sass_compile"

## Ruby

### Unicorn Zero-Downtime deployments

Check the provided sample configuration (config-samples/unicorn.rb)

@see http://ariejan.net/2011/09/14/lighting-fast-zero-downtime-deployments-with-git-capistrano-nginx-and-unicorn

## PHP

### PHP-fpm reload

You may need to reload php-fpm if you are using APC or other accelerators because of symlinks caching issues.

Your deployment user will need permission to reload php-fpm. You may edit your /etc/sudoers like so for userx:

    userx ALL=(root) NOPASSWD: /usr/sbin/service php5-fpm reload

### CakePHP recipe

To set database configuration and other environment configurations, we use a symlinked shared config file named bootstrap.local.php.

You may add this to the default CakePHP bootstrap file to include the deployment configs :

    if(file_exists(APP . DS . 'config' . DS . 'bootstrap.local.php')) 
    {
    	include(APP . DS . 'config' . DS . 'bootstrap.local.php');
    }