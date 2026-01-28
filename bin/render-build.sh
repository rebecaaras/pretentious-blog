set -o errexit

bundle exec rake db:migrate
bundle exec puma -p $PORT -e production