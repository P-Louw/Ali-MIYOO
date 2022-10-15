#!/bin/sh

# give crontab context access to env:
env >> /etc/environment

#Run initial test mail:
result=$(dotnet fsi /scripts/alistockcheck.fsx testmail)
echo $result
case ${result} in
    1) {
            echo Validate smtp mail failed 💥
            exit 1
    } ;;
    *) {
            echo Sent validate smtp mail 📨
    };;
esac
# start cron in the foreground (replacing the current process).
# user crond for alpine.
crond -f -l 8