#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id"}

source login.sh

endpoint=Stones/$stone_id/energyUsageHistory
date_0=$(date --date='1 week ago' '+%Y-%m-%d')
date_1=$(date '+%Y-%m-%d')
total=14929
limit=1000
skip=0
mkdir -p output

touch output/curl.log
rm output/curl.log

counter=0
let max=$total+$limit
until [ $counter -gt $max ]; do
  echo $skip
  args="from=$date_0&to=$date_1&limit=$limit&skip=$skip&ascending=true"

  curl -s -X GET --header "Accept: application/json" "https://cloud.crownstone.rocks/api/$endpoint?$args&access_token=$access_token" >> output/curl.log
  
  let counter+=$limit
  skip=$counter
done

echo "Result in output/curl.log"
