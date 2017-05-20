#!/bin/bash

source /root/.duplicity

export PASSPHRASE
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

GPG_KEY="8B8E5ECC"

duplicity -v8 \
  --s3-use-ia \
  --s3-use-new-style \
  --asynchronous-upload \
  --encrypt-key="$GPG_KEY" \
  --exclude /var/lib/plexmediaserver/Sync \
  /var/lib/plexmediaserver \
  "s3://s3.amazonaws.com/bbck-plex"

unset PASSPHRASE
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
