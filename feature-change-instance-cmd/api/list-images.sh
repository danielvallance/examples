#!/bin/sh

. ./ukc.config

curl \
    --silent \
    -X GET \
    -H "Authorization: Bearer ${UKC_TOKEN}" \
    -H 'Content-Type: application/json' \
    "${UKC_METRO}/images/list" > out 2> err

if test $? -ne 0; then
    cat err 1>&2
else
    cat out | jq
fi

rm -f out err
