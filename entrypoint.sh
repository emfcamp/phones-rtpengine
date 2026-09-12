#!/bin/sh
set -e

# For backwards compatibility, if any arguments are given (e.g A `command:` list in
# docker-compose.yml) we run rtpengine as before and append the arguments
if [ "$#" -gt 0 ]; then
    exec /usr/local/bin/rtpengine "$@"
fi

# Otherwise we build it from env vars and sane defaults
exec /usr/local/bin/rtpengine \
    --interface="${RTPENGINE_INTERFACE:-127.0.0.1}" \
    --listen-ng="${RTPENGINE_LISTEN_NG:-0.0.0.0:2223}" \
    --listen-cli="${RTPENGINE_LISTEN_CLI:-0.0.0.0:6000}" \
    --listen-http="${RTPENGINE_LISTEN_HTTP:-0.0.0.0:7000}" \
    --table="${RTPENGINE_TABLE:--1}" \
    --port-min="${RTPENGINE_PORT_MIN:-10000}" \
    --port-max="${RTPENGINE_PORT_MAX:-29999}" \
    --log-level="${RTPENGINE_LOG_LEVEL:-6}" \
    --foreground \
    --log-stderr
