#!/bin/bash

source login.sh

endpoint=Stones

mkdir -p output

curl -s -X GET "https://cloud.crownstone.rocks/api/$endpoint/all?access_token=$access_token" > output/curl.log

echo "Result in output/curl.log"

< output/curl.log jq
