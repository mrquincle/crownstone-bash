#!/bin/bash

source login.sh

endpoint=sse

echo "Install moreutils to get timestamp (ts) command"

curl --silent --no-buffer --http2 -H 'Accept:text/event-stream' -H "$auth_header" "$event_server/$endpoint" | ts '[%Y-%m-%d %H:%M:%.S]'
