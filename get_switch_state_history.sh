#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id"}

source login.sh

endpoint=Stones/$stone_id

options="-s"

arguments='&ascending=true'

mkdir -p output

curl $options -X GET --header "Accept: application/json" "https://cloud.crownstone.rocks/api/$endpoint/switchStateHistory?access_token=$access_token$arguments" > output/curl.log

echo "Result in output/curl.log"

< output/curl.log jq
