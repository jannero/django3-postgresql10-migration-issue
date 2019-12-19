#! /usr/bin/env bash

set -euo pipefail

function test_migrations {
  django_version=$1
  postgresql_version=$2

  venv="./venv-django${django_version}"
  db_name="django${django_version}"
  db_port=$(printf "7%03d" ${postgresql_version//./})

  settings_module=settings_django${django_version}_psql${postgresql_version//./}

  echo ""
  echo ""
  echo "Testing migrations with Django ${django_version}, PostgreSQL ${postgresql_version}"

  echo "-- Virtual env: ${venv}"
  python3 -m venv ${venv} > /dev/null 2>/dev/null
  ${venv}/bin/pip install -r requirements-django${django_version}.txt > /dev/null

  echo "-- Settings module: ${settings_module}"
  cat > ${settings_module}.py <<EOF
from settings_common import *

DATABASES['default']['NAME'] = '${db_name}'
DATABASES['default']['PORT'] = '${db_port}'
EOF

  ./init_database.sh ${db_port} ${db_name} > /dev/null

  DJANGO_SETTINGS_MODULE=${settings_module} ${venv}/bin/python manage.py migrate || true
}


test_migrations 2 10
test_migrations 2 11.5
test_migrations 3 9.6
test_migrations 3 10
test_migrations 3 11.5
