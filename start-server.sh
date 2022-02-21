#!/usr/bin/env bash

# Migrate the Database
python3 manage.py migrate
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to migrate Django DB: $status"
  exit $status
fi

# Create Django superuser
if [ -n "$DJANGO_SUPERUSER_EMAIL" ] && [ -n "$DJANGO_SUPERUSER_PASSWORD" ] ; then
    python3 manage.py createsuperuser --no-input
    status=$?
    if [ $status -ne 0 ]; then
      echo "Failed to create superuser: $status"
      exit $status
    fi
fi

# Collect static files
python3 manage.py collectstatic
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to collect Static files: $status"
  exit $status
fi

# Load model fixtures
python manage.py loaddata app/fixtures/*
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to load models fixtures: $status"
  exit $status
fi

# Start Gunicorn and NGINX Servers
(gunicorn webapp.wsgi --bind 0.0.0.0:8010 --workers 3) & nginx -g "daemon off;"


# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

# while sleep 60; do
#   ps aux |grep my_first_process |grep -q -v grep
#   PROCESS_1_STATUS=$?
#   ps aux |grep my_second_process |grep -q -v grep
#   PROCESS_2_STATUS=$?
#   # If the greps above find anything, they exit with 0 status
#   # If they are not both 0, then something is wrong
#   if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
#     echo "One of the processes has already exited."
#     exit 1
#   fi
# done
