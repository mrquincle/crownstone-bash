#!/bin/bash

sphereId=$1

source login.sh

endpoint=users/$user_id/keysV2

curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

#echo "Result in output/curl.log"
if [ ! -n "${sphereId}" ]; then
	< output/curl.log jq '.'
else
	< output/curl.log jq ".[] | select(.sphereId == \"$sphereId\")"
fi
