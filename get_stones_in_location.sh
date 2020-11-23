#!/bin/bash

room_id=${1:? "Usage $0 room_id"}

source login.sh

endpoint=locations/$room_id/stones

curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq
