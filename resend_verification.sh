#!/bin/bash

verify_email=${1:? "Usage: $0 email"}

cfgfile=".config"

if [ ! -e "$cfgfile" ]; then
  echo "No configuration file: $cfgfile"
  exit
fi

source $cfgfile

endpoint=users/resendVerification

curl $options -X POST "$server/api/$endpoint?email=$verify_email" > output/curl.log

echo "Result in output/curl.log (html page)"
head output/curl.log

