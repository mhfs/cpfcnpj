# Unicorn says to use at least one worker process per core (particularly on dedicated servers)
worker_processes 1

APP_ROOT = "/home/cpfcnpj.mhfs.com.br/current"

# The root directory of you app
working_directory APP_ROOT

# The user which the workers will run under
user 'cpfcnpj', 'cpfcnpj'

# Load rails+github.git into the master before forking workers
# for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 30 seconds
timeout 10

# Listen on a Unix data socket
listen "#{APP_ROOT}/tmp/sockets/unicorn.sock", :backlog => 2048

# Location of master process PID file
pid "#{APP_ROOT}/tmp/pids/unicorn-master.pid"

# Location of stderr/stdout logs
stderr_path "#{APP_ROOT}/log/unicorn.stderr.log"
stdout_path "#{APP_ROOT}/log/unicorn.stdout.log"

# http://www.rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end

