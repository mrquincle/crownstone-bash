#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id"}

source login.sh

endpoint=Stones/$stone_id/currentPowerUsage

curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq '.'
