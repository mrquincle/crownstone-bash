#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id invite_email"}
invite_email=${2:? "Usage: $0 sphere_id invite_email"}

source login.sh

endpoint=Spheres/$sphere_id/members

curl $options -X PUT "$server/api/$endpoint?email=$invite_email" -H "$auth_header" > output/curl.log

< output/curl.log jq '.'
