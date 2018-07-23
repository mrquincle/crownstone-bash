#!/bin/bash

source login.sh

endpoint=users/$user_id/spheres

mkdir -p output

curl -s -X GET --header "Accept: application/json" "https://cloud.crownstone.rocks/api/$endpoint?access_token=$access_token" > output/curl.log

echo "Result in output/curl.log"
