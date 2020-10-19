#!/bin/sh

set -e

echo "Backup started: $(date)"

s3cmd sync $PARAMS "$DATA_PATH" "$S3_PATH" > /home/jobberuser/s3sync.log

echo "Backup finished: $(date)"
