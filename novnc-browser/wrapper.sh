#!/usr/bin/env bash

set -e

export HOME=/
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=high
export DISPLAY_NUM=1
export HEIGHT=768
export WIDTH=1024

# Start dependencies
./start_all.sh

# Start noVNC with explicit websocket settings
/opt/noVNC/utils/novnc_proxy \
    --vnc 0.0.0.0:5900 \
    --listen 6080 \
    --web /opt/noVNC
