#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
#require "rvm/capistrano"
#set :rvm_ruby_string, 'ree-1.8.7-2010.02'

require 'bundler/capistrano'

load 'deploy' if respond_to?(:namespace)

default_run_options[:pty] = true

set :user, 'cpfcnpj_mhfs_com_br'
set :application, 'cpfcnpj'
set :domain, "#{application}.mhfs.com.br"

set :repository,  "git://github.com/mhfs/#{application}.git"
set :deploy_to, "/home/#{domain}"
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web

namespace :deploy do
  task :start do
    run "/etc/init.d/#{domain} start"
  end
  task :stop do
    run "/etc/init.d/#{domain} stop"
  end
  task :restart do
    run "/etc/init.d/#{domain} upgrade"
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
