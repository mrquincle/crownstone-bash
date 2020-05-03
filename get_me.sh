#!/bin/bash

source login.sh

endpoint=users/me

mkdir -p output

curl -s "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq

