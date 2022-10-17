#!/usr/bin/env bash

# Create image:
docker build \
    -t miyooali \
    # Address of smtp sender
    --build-arg mail="smtpsender@mail.com" \
    # Smtp host
    --build-arg server="smtphost.mail.com" \
    # Smtp port 587 or 25 most of the time
    --build-arg port=587 \
    # Password of the smtp sender i.e. 'mail' arg
    --build-arg password="smtpmailpassword" \
    # Person that has to be notified
    --build-arg recipient="myemail@mail.com" \
    --no-cache .

# Create container with env
docker container create \
    --name miyoopol \
    miyooali

# Create cron job:
crontab -l > cron_bkp
echo "*/15 * * * * $(whoami) docker run -d --name miyoopoll miyooali > /dev/null 2>&1" >> cron_bkp
crontab cron_bkp
rm cron_bkp

# Do a initial run, just for fun.
docker start miyoopol