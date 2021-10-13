#!/bin/bash

source login.sh

user_id=${1:? "Usage: $0 user_id"}

tmpfile0=$(mktemp /tmp/crownstone-get-current-location.XXXXXX)

endpoint=users/$user_id/currentLocation

curl $options "$server/api/$endpoint" -H "$auth_header" > $tmpfile0

echo "Result in $tmpfile0"

< $tmpfile0 jq '.'

