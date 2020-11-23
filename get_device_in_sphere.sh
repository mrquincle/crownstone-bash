#!/bin/bash

source login.sh

endpoint=Devices/$device_id/inSphere

curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq
