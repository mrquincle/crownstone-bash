#!/bin/bash

user_id=${1:? "Usage: $0 user_id"}

source login.sh

endpoint=users/$user_id/currentLocation

curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

echo "Result in output/curl.log"

< output/curl.log jq '.'
