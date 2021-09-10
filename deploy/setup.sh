#!/usr/bin/env bash

set -e

# TODO: Set to URL of git repo.
PROJECT_GIT_URL='https://github.com/quangdvn/django-rest-beginner.git'

PROJECT_BASE_PATH='/usr/local/apps/django_rest_beginner'

echo "Installing dependencies..."
apt-get update
apt-get install -y python3-pip python3-dev python3-venv sqlite python-pip supervisor nginx git

echo "Python3"
echo python3 --version

echo "pip3"
echo pip3 --version

pip3 install pipenv
echo "pipenv"
echo pipenv --version

# Create project directory
echo "Clone project"
mkdir -p $PROJECT_BASE_PATH
git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH

# Create virtual environment
# mkdir -p $PROJECT_BASE_PATH/env
# python3 -m venv $PROJECT_BASE_PATH/env

cd $PROJECT_BASE_PATH

export PIPENV_VENV_IN_PROJECT=1

pipenv shell

# Install python packages
cd $PROJECT_BASE_PATH
# $PROJECT_BASE_PATH/env/bin/pip install -r $PROJECT_BASE_PATH/requirements.txt
# $PROJECT_BASE_PATH/env/bin/pip install uwsgi==2.0.18
pipenv install
pipenv install uwsgi==2.0.18

# Run migrations and collectstatic
cd $PROJECT_BASE_PATH
$PROJECT_BASE_PATH/.venv/bin/python3 manage.py migrate
$PROJECT_BASE_PATH/.venv/bin/python3 manage.py collectstatic --noinput

# Configure supervisor
cp $PROJECT_BASE_PATH/deploy/supervisor_profiles_api.conf /etc/supervisor/conf.d/profiles_api.conf
supervisorctl reread
supervisorctl update
supervisorctl restart profiles_api

# Configure nginx
cp $PROJECT_BASE_PATH/deploy/nginx_profiles_api.conf /etc/nginx/sites-available/profiles_api.conf
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/profiles_api.conf /etc/nginx/sites-enabled/profiles_api.conf
systemctl restart nginx.service

echo "DONE! :)"
