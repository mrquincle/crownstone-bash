#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id foreign_user_id"}
foreign_user_id=${2:? "Usage: $0 sphere_id foreign_user_id"}

source login.sh

endpoint=Spheres/$sphere_id/users/rel/$foreign_user_id

curl $options -X DELETE "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq
