#!/usr/bin/env bash

set -e -o pipefail

arch -arch x86_64 \
  bundle exec \
  jekyll build --config _config.yml,_config_dev.yml --incremental --watch &
j_pid=$!

npm run dev &
n_pid=$!

echo "caught PIDs: $j_pid, $n_pid"

trap "{ kill $j_pid; kill $n_pid; exit 0;}" SIGINT
wait
