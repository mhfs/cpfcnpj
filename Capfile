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
  task :restart do
    # run "touch #{current_path}/tmp/restart.txt"
  end
end
