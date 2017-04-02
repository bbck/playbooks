#!/bin/bash

source /root/.duplicity

export PASSPHRASE
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

GPG_KEY="8B8E5ECC"

duplicity \
  --s3-use-ia \
  --asynchronous-upload \
  --encrypt-key="$GPG_KEY" \
  /var/lib/plexmediaserver \
  "s3+http://bbck-plex/"

unset PASSPHRASE
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
