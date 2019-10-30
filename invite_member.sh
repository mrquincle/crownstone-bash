#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id invite_email"}
invite_email=${2:? "Usage: $0 sphere_id invite_email"}

source login.sh

endpoint=Spheres/$sphere_id/members

options="-s"

mkdir -p output

curl $options -X PUT "$server/api/$endpoint?access_token=$access_token&email=$invite_email" > output/curl.log

echo "Result in output/curl.log"

< output/curl.log jq '.'
