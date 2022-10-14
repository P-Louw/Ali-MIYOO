#!/usr/bin/env bash

sudo crontab -l > cron_bkp
sudo echo "*/30 * * * * /src/alistockcheck.fsx > /dev/null 2>&1" >> cron_bkp
sudo crontab cron_bkp
sudo rm cron_bkp