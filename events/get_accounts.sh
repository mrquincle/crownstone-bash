#!/bin/bash

source login.sh

endpoint=accounts

curl $options $server/$endpoint -H "$auth_header" > output/curl.log

< output/curl.log jq
