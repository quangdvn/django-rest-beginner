#!/usr/bin/env bash

set -e

PROJECT_BASE_PATH='/usr/local/apps/django_rest_beginner'

git pull
$PROJECT_BASE_PATH/.venv/bin/python3 manage.py migrate
$PROJECT_BASE_PATH/.venv/bin/python3 manage.py collectstatic --noinput
supervisorctl restart profiles_api

echo "DONE! :)"
