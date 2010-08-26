$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ree-1.8.7-2010.02'        # Or whatever env you want it to run in.

require 'bundler/capistrano'

load 'deploy' if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true

# be sure to change these
set :user, 'mhfs'
set :domain, 'server.mhfs.com.br' # TODO update
set :application, 'cpfcnpj'

# the rest should be good
set :repository,  "git://github.com/mhfs/cpfcnpj.git"
set :deploy_to, "/home/www/cpfcnpj.mhfs.com.br" # TODO use #{domain}
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web

namespace :deploy do
  task :start do
    sudo "/etc/init.d/unicorn start"
  end
  task :stop do
    sudo "/etc/init.d/unicorn stop"
  end
  task :restart do
    sudo "/etc/init.d/cpfcnpj upgrade"
  end
  task :symlink_tmp do
    run "rm -rf #{release_path}/tmp"
    run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
  end
  task :setup_tmp do
    run "mkdir -p #{shared_path}/tmp/sockets"
    run "mkdir -p #{shared_path}/tmp/pids"
  end
end

after 'deploy:update_code', 'deploy:symlink_tmp'
after 'deploy:setup', 'deploy:setup_tmp'
