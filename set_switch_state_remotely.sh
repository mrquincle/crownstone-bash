#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id state [server]"}
state=${2:? "Usage: $0 stone_id state [server]"}

if [ -n "${3}" ]; then
  server=$3
fi

source login.sh

echo 'Remember to configure your phone as a hub!'

endpoint=Stones/$stone_id

options="-s"

if [ ! -n "${server}" ]; then
  server="https://cloud.crownstone.rocks"
fi

echo "Send command to server $server"
curl $options -X PUT --header "Accept: application/json" "$server/api/$endpoint/setSwitchStateRemotely?switchState=$state&access_token=$access_token" 

