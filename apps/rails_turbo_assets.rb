#
# There are a few requirement for theses tasks to work as intentended :
#
# - You must set :deploy_via, :remote_cache
# - The cached copy was synced previously during deployment 
#   (otherwise real_revision might not be yet fetch on the cached copy)

set(:skip_assets_precompile) do
  cached_copy = File.join(shared_path, fetch(:repository_cache, "cached-copy"))
  run("cd #{cached_copy} && #{source.log(current_revision, real_revision)} --oneline vendor/assets/ app/assets/ | wc -l").to_i == 0
end

namespace :deploy do
  namespace :assets do
    task :clean, :roles => assets_role, :except => { :no_release => true } do
      if skip_assets_precompile then
        logger.info "Skipping asset cleaning because there were no asset changes"
      else
        run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:clean"
      end
    end

    desc "Precompile assets only if required"
    task :precompile, :roles => :app do
      if skip_assets_precompile then
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      else
        run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile"
      end
    end
  end
end