#!/bin/bash

source login.sh

endpoint=users/$user_id/devices

mkdir -p output

curl -s "$server/api/$endpoint" -H "$auth_header" > output/curl.log

#echo "Result in output/curl.log"

< output/curl.log jq
