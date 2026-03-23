#!/bin/sh

. ./ukc.config
. ./app.config

kraft pkg ls --all -o json > out 2> err

if test $? -ne 0; then
    cat err 1>&2
else
    cat out | jq -r ".[] | select(.name==\"index.unikraft.io/${UKC_USER}/${IMAGE_NAME}\") | .index"
fi

rm -f out err
