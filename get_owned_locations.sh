#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id"}

source login.sh

endpoint=Spheres/$sphere_id/ownedLocations

options="-s"

mkdir -p output

curl $options -X GET "https://cloud.crownstone.rocks/api/$endpoint?access_token=$access_token" > output/curl.log

#echo "Result in output/curl.log"

< output/curl.log jq '.'
