#!/bin/bash

stone_id=${1:? "Usage: $0 stone_id"}

source login.sh

endpoint=Stones/$stone_id

options="-s"

echo curl $options -X PUT --header "Accept: application/json" "https://cloud.crownstone.rocks/api/$endpoint/setSwitchStateRemotely?switchState=1&access_token=$access_token" 
curl $options -X PUT --header "Accept: application/json" "https://cloud.crownstone.rocks/api/$endpoint/setSwitchStateRemotely?switchState=1&access_token=$access_token" 

