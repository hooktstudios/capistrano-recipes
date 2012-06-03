#
# From Webistrano template (removed webistrano specifics)
#
# Copyright (c) 2007-2008 Jonathan Weiss <jw@innerewut.de>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# @see https://github.com/peritor/webistrano/blob/master/lib/webistrano/template/mod_rails.rb
#

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    mod_rails.restart
  end

  task :start, :roles => :app, :except => { :no_release => true } do
    mod_rails.start
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    mod_rails.stop
  end
end

namespace :mod_rails do
  desc "start mod_rails & Apache"
  task :start, :roles => :app, :except => { :no_release => true } do
    as = fetch(:runner, "app")
    invoke_command "#{apache_init_script} start", :via => run_method, :as => as
  end

  desc "stop mod_rails & Apache"
  task :stop, :roles => :app, :except => { :no_release => true } do
    as = fetch(:runner, "app")
    invoke_command "#{apache_init_script} stop", :via => run_method, :as => as
  end

  desc "restart mod_rails"
  task :restart, :roles => :app, :except => { :no_release => true } do
    as = fetch(:runner, "app")
    restart_file = fetch(:mod_rails_restart_file, "#{deploy_to}/current/tmp/restart.txt")
    invoke_command "touch #{restart_file}", :via => run_method, :as => as
  end
end