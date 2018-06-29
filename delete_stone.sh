#!/bin/bash

source login.sh

endpoint=Stones

stone_id=${1:? "Usage: $0 stone_id" }

curl -s -X DELETE --header "Accept: application/json" "https://cloud.crownstone.rocks/api/$endpoint/$stone_id?access_token=$access_token" 

