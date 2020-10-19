#!/bin/sh

set -e
# : ${S3_PATH:?"S3_PATH env variable is required"}
# export DATA_PATH=${DATA_PATH:-/data/}
sed -i -e "s/JOBBER_TIME_ENV/$JOBBER_TIME/g" /home/jobberuser/.jobber

if [[ -n "$ACCESS_KEY"  &&  -n "$SECRET_KEY" ]]; then
    echo "access_key=$ACCESS_KEY" >> /home/jobberuser/.s3cfg
    echo "secret_key=$SECRET_KEY" >> /home/jobberuser/.s3cfg
    echo "host_base=$HOST_BASE" >> /home/jobberuser/.s3cfg
    echo "host_bucket=$HOST_BUCKET" >> /home/jobberuser/.s3cfg
else
    echo "No ACCESS_KEY and SECRET_KEY env variable found, assume use of IAM"
fi

/usr/libexec/jobberrunner -u /var/jobber/1000/cmd.sock /home/jobberuser/.jobber
