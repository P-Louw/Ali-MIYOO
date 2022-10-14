#!/usr/bin/env bash

crontab -l > cron_bkp
echo "*/30 * * * * /scripts/alistockcheck.fsx > /dev/null 2>&1" >> cron_bkp
crontab cron_bkp
rm cron_bkp