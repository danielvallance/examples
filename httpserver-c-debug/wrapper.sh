#!/bin/sh

set -ex

# Start SSH server.
export HOME=/root

if test ! -z "$PUBKEY"; then
    echo "$PUBKEY" >> /root/.ssh/authorized_keys
fi

/usr/sbin/sshd -h /etc/ssh/ssh_host_ecdsa_key -p 2222

# Start C HTTP server (actual application).
if test ! -z "$USE_STRACE"; then
    if test "$USE_STRACE" = "on" -o "$USE_STRACE" = "1" -o "$USE_STRACE" = "true"; then
        /usr/bin/strace -f /usr/bin/http_server
    else
        /usr/bin/http_server
    fi
else
    /usr/bin/http_server
fi
