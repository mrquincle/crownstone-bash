#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id"}

source login.sh

endpoint=Spheres/$sphere_id/pendingInvites

curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq '.'
