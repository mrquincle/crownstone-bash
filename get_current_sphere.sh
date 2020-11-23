#!/bin/bash

echo "Do not use this for getting the sphere (it's only there for legacy reasons)"

user_id=${1:? "Usage: $0 user_id"}

source login.sh

endpoint=users/$user_id/devices

curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq '.[0] | {currentSphereId}'
