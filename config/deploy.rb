# config valid for current version and patch releases of Capistrano
lock '3.17.1'

set :application, 'review-for-it-certifications'
set :repo_url, 'https://github.com/kazuyainoue0124/review-for-it-certifications.git'
set :deploy_to, '/review-for-it-certifications'
set :docker_compose_path, 'docker-compose -f docker-compose-prod.yml'
set :RAILS_ENV, 'RAILS_ENV=production'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  application = fetch :application
  docker_compose_path = fetch :docker_compose_path
  rails_env = fetch :RAILS_ENV
  db_drop = "#{docker_compose_path} run rails rails db:drop #{rails_env} DISABLE_DATABASE_ENVIRONMENT_CHECK=1"
  db_create = "#{docker_compose_path} run rails rails db:create #{rails_env}"
  db_migrate = "#{docker_compose_path} run rails rails db:migrate #{rails_env}"
  db_seed = "#{docker_compose_path} run rails rails db:seed #{rails_env}"

  task :application_set_up do
    on roles(:rails) do
      # execute "cd /#{application}/;" 'git pull origin master;' "#{docker_compose_path} down;" 'docker rmi -f `docker images -q`'
      execute "cd /#{application}/;" "#{docker_compose_path} build;" "#{docker_compose_path} up -d"
    end
  end
  task :database_set_up do
    on roles(:rails) do
      execute "cd /#{application}/;" "#{db_create};" "#{db_migrate};" "#{db_seed};"
    end
  end

  task :database_reset do
    on roles(:rails) do
      execute "cd /#{application}/;" "#{db_drop};" "#{db_create};" "#{db_migrate};" "#{db_seed};"
    end
  end

  task :down_containers do
    on roles(:rails) do
      execute "cd /#{application}/;" "#{docker_compose_path} down"
    end
  end

  task :destroy_images do
    on roles(:rails) do
      execute "cd /#{application}/;" 'docker rmi -f `docker images -q`'
    end
  end
end
