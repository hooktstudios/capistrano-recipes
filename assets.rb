set :lessc_path, "~/node_modules/less/bin/lessc"
set :sass_path, "sass"

namespace :assets do
  desc "Compile LESS files"
  task :less_compile, :roles => :app do
    run "find #{release_path} -name \"*.less\" | xargs -I {} #{lessc_path} -x {} {}.css"
  end

  desc "Compile SASS files"
  task :sass_compile, :roles => :app do
    run "find #{release_path} -name \"*.scss\" -o -name \"*.sass\" | xargs -I {} #{sass_path} {}:{}.css"
  end
end