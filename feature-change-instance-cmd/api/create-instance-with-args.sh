#!/bin/sh

. ./ukc.config
. ./app.config

curl \
    --silent \
    -X POST \
    -H "Authorization: Bearer ${UKC_TOKEN}" \
    -H "Content-Type: application/json" \
    "${UKC_METRO}/instances" \
    -d "{
        'name': '${INSTANCE_NAME}',
        'image': '${UKC_USER}/${IMAGE_NAME}:latest',
        'args': [\"/http_server_args\", \"'Bye, World!'\"],
        'service_group': {
            'services': [
              {
                'port': 443,
                'destination_port': 8080,
                'handlers': [
                  'tls',
                  'http'
                ]
              }
            ],
            'domains': [
              {
                'name': '${INSTANCE_NAME}'
              }
            ]
        },
        'memory_mb': 256,
      }" > out 2> err

if test $? -ne 0; then
    cat err 1>&2
else
    cat out | jq
fi

rm -f out err
