#!/bin/sh

# give crontab context access to env:
env >> /etc/environment

# start cron in the foreground (replacing the current process).
# user crond for alpine.
crond -f -l 8