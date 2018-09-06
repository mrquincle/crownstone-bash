#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id"}

source login.sh

endpoint=Stones/$stone_id/currentPowerUsage

options="-s"

mkdir -p output

curl $options -X GET --header "Accept: application/json" "https://cloud.crownstone.rocks/api/$endpoint?access_token=$access_token" > output/curl.log
  
echo "Result in output/curl.log"

< output/curl.log jq '.'
