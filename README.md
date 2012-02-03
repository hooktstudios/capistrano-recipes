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