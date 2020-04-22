#!/bin/bash

source login.sh

endpoint=accounts

mkdir -p output

curl -s $server/$endpoint -H "$auth_header" > output/curl.log

< output/curl.log jq
