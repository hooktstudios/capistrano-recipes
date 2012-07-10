set(:skip_assets_precompile) do
  run_locally("#{source.local.log(current_revision, revision)} --oneline vendor/assets/ app/assets/ | wc -l").to_i == 0
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