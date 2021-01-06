#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id state [server]"}
state=${2:? "Usage: $0 stone_id state [server]"}

source login.sh

endpoint=Stones/$stone_id/setSwitchStateRemotely

args="switchState=$state"

curl $options $headers -X PUT "$server/api/$endpoint?$args" -H "$auth_header" > output/curl.log

< output/curl.log jq '.'
