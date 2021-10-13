#!/bin/bash

sphereId=$1

source login.sh

tmpfile0=$(mktemp /tmp/crownstone-get-keys-v2.XXXXXX)
tmpfile1=$(mktemp /tmp/crownstone-get-keys-v2-sphere.XXXXXX)

endpoint=users/$user_id/keysV2

curl $options "$server/api/$endpoint" -H "$auth_header" > $tmpfile0

if [ ! -n "${sphereId}" ]; then
	< $tmpfile0 jq '.'
else
	< $tmpfile0 jq ".[] | select(.sphereId == \"$sphereId\")" > $tmpfile1
	< $tmpfile1 jq '.'
fi
