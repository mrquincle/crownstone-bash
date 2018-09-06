#!/bin/bash

source login.sh

endpoint=users/$user_id/currentLocation

options="-s"

mkdir -p output

curl $options -X GET --header "Accept: application/json" "https://cloud.crownstone.rocks/api/$endpoint?access_token=$access_token$arguments" > output/curl.log

echo "Result in output/curl.log"

< output/curl.log jq '.'
