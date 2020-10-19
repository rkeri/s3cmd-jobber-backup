# s3cmd-jobber-backup
Version 0.1 (aka "Barely working")

Docker hub link: https://hub.docker.com/r/rkeri/s3cmd-jobber-backup

## What's this?

This image serves as an automated S3 backup solution, which can be implemented
as a sidecar to your pod. It's based off the official jobber docker image with
an installment of s3cmd tool.

Current features:
- Configurable backup time (currently only sync is working)
- Should be compatible with all major cloud providers (only tried digitalocean)
- Safely pass your private keys with ENV (secret inject in progress)

## How to use?
The following variables are required:
- ACCESS_KEY
- SECRET_KEY
- HOST_BUCKET
- HOST_BASE
- S3_PATH
- DATA_PATH
- JOBBER_TIME

Add the image (rkeri/s3cmd-jobber-backup) to your main image as a sidecar,
and mount the backup data volume to it as readonly (DATA_PATH).
Run it, and the contents of your backup should be synced with your s3 storage.

TODO:
- ~~working cron env~~
- slack integration for backup information
- delete / sync / put options
- option to delete files older than n days
- a lot of refactoring
- use lighter alpine image for a more optimized experience
- prometheus sidecar
- sidecar injection support
