# Unicorn says to use at least one worker process per core (particularly on dedicated servers)
worker_processes 1

APP_ROOT = "/home/www/cpfcnpj.mhfs.com.br/current"

# The root directory of you app
working_directory APP_ROOT

# Port that worker processes listen on
# This can also be a unix socket
listen 15010, :tcp_nopush => true

# Location of master process PID file
pid "#{APP_ROOT}/tmp/pids/unicorn-master.pid"

# Location of stderr/stdout logs
stderr_path "#{APP_ROOT}/log/unicorn.stderr.log"
stdout_path "#{APP_ROOT}/log/unicorn.stdout.log"

# combine REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
GC.copy_on_write_friendly = true