#!/bin/bash

source /root/.duplicity

export PASSPHRASE
export AWS_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY

duplicity --s3-use-ia --encrypt-key 8B8E5ECC incr /var/lib/plexmediaserver "s3+http://bbck-plex/"
