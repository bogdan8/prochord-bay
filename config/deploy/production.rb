set :stage, :production
set :branch, :feature
set :user, :prochordbay

role :app, %w{prochordbay@192.168.0.101}
role :web, %w{prochordbay@192.168.0.101}
role :db, %w{prochordbay@192.168.0.101}

server '192.168.0.101', user: fetch(:user), roles: %w{app, web}, primary: true

set :deploy_to, "/home/#{fetch(:user)}"

set :rails_env, :production

set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

set :puma_init_active_record, true

set :enable_ssl, false

set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/prochord-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/prochord-puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/prochord-puma.pid"
set :puma_access_log, "#{release_path}/log/prochord-puma.error.log"
set :puma_error_log,  "#{release_path}/log/prochord-puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil