# s3cmd-jobber-backup
Version 0.2

Docker hub link: https://hub.docker.com/r/rkeri/s3cmd-jobber-backup

## What's this?

This image serves as an automated S3 backup solution, which can be implemented
as a sidecar to your pod. It's based off the official jobber docker image with
an installment of s3cmd tool.

Current features:
- Configurable backup time
- Should be compatible with all major cloud providers

## How to use?
The following variables are can be configured (~ is optional, * is the explanation):
- ACCESS_KEY - your s3 access key
- SECRET_KEY - your s3 secret key
- HOST_BUCKET - your s3 bucket location (e.g. %(bucket)s.ams3.digitaloceanspaces.com)
- HOST_BASE - your s3 host base (e.g. ams3.digitaloceanspaces.com)
- S3_PATH - your s3 path (e.g. s3://your-bucket/)
- DATA_PATH - your local backup data path
- ~PARAMS - extra s3cmd params (more info here: https://s3tools.org/usage)
- ~JOBBER_TIME* - backup time string (https://dshearer.github.io/jobber/doc/v1.4/#time-strings)
- ~SLACK_ENABLE** - enable slack integration
- ~WEBHOOK_URL*** - your slack webhook url (https://api.slack.com/messaging/webhooks)

:* Default time is daily at 13:00

:** Possible options: yes/no (default is yes). If yes is provided, WEBHOOK_URL
should be filled too

:*** Only required if SLACK_ENABLE=yes

Add the image (rkeri/s3cmd-jobber-backup) to your main image as a sidecar,
and mount the backup data volume to it as readOnly (DATA_PATH).
Run it, and the contents of your backup should be synced with your s3 storage.

TODO:
- sidecar injection solution
