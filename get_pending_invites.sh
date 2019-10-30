#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id"}

source login.sh

endpoint=Spheres/$sphere_id/pendingInvites

options="-s"

mkdir -p output

echo curl $options -X GET "$server/api/$endpoint?access_token=$access_token" 
curl $options -X GET "$server/api/$endpoint?access_token=$access_token" > output/curl.log

echo "Result in output/curl.log"

< output/curl.log jq '.'
