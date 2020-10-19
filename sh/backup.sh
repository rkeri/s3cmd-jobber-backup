#!/bin/sh

set -e

echo "Backup started: $(date)"

s3cmd sync $PARAMS "$DATA_PATH" "$S3_PATH"

echo "Backup finished: $(date)"
