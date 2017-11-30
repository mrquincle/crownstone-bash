#!/bin/bash

source login.sh

curl -X GET --header "Content-Type: application/json" --header "Accept: application/json" "https://cloud.crownstone.rocks/api/users/$user_id/keys?access_token=$access_token"
