#!/bin/sh

if  [[ "$SLACK_ENABLE" = yes && -n "$WEBHOOK_URL" ]]; then
  curl -X POST -H --silent --data-urlencode "payload={\"text\": \"$(cat /home/jobberuser/s3sync.log | sed "s/\"/'/g")\"}" $WEBHOOK_URL
  echo "S3 Bucket is up to date!" > /home/jobberuser/s3sync.log
  echo "Backup finished"
else
  echo "Backup finished"
fi
