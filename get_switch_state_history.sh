#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id"}

source login.sh

endpoint=Stones/$stone_id/switchStateHistoryV2

args='ascending=true'

mkdir -p output

curl $options "$server/api/$endpoint?$args" -H "$auth_header" > output/curl.log

< output/curl.log jq
