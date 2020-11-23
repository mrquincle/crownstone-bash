#!/bin/bash

source login.sh

endpoint=Locations

curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq '.'

