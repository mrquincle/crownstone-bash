#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id"}

source login.sh

endpoint=Stones/$stone_id/powerUsageHistory/count

date_0=$(date --date='1 week ago' '+%Y-%m-%d')
date_1=$(date '+%Y-%m-%d')
args="from=$date_0&to=$date_1"

curl $options "$server/api/$endpoint?$args" -H "$auth_header" > output/curl.log

cat output/curl.log
