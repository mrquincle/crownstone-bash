#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id email"}
invite_email=${2:? "Usage: $0 sphere_id email"}

source login.sh

endpoint=Spheres/$sphere_id/resendInvite

curl $options "$server/api/$endpoint?email=$invite_email" -H "$auth_header" > output/curl.log

< output/curl.log jq '.'
