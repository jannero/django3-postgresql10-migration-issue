#! /usr/bin/env bash

set -euo pipefail

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

chmod go= ${THIS_DIR}/pgpass
export PGPASSFILE=${THIS_DIR}/pgpass


port=$1
db_name=$2

psql -U postgres -h 127.0.0.1 -p ${port} <<EOF
  DROP DATABASE IF EXISTS ${db_name};
  CREATE DATABASE ${db_name} WITH OWNER postgres;
EOF
