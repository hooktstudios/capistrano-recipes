# HS standard Capistrano recipes

What's in this? You'll find tasks and informations to manage various stuff with capistrano like :

* Ruby apps
    * RVM (ruby version manager : run proper ruby version for your deployment)
    * Bundler (app packages management)
    * Unicorn (fast & zero-downtime deployments)
    * ModRails (quick & easy)
* PHP apps
    * Twig
    * PHP-FPM
    * CakePHP
* Assets management
    * LESS precompile
    * SASS precompile
* Other nice stuff
    * Multistages
    * SSH forwarding

## Unicorn Zero-Downtime deployments

Check the provided sample configuration (config-samples/unicorn.rb)

## CakePHP recipe

To set database configuration and other environment configurations, we use a symlinked shared config file named bootstrap.local.php.

You may add this to the default CakePHP bootstrap file to include the deployment configs :

    if(file_exists(APP . DS . 'config' . DS . 'bootstrap.local.php')) 
    {
    	include(APP . DS . 'config' . DS . 'bootstrap.local.php');
    }