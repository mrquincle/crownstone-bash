#!/bin/bash

reset_email=${1:? "Usage: $0 email"}

cfgfile=".config"

if [ ! -e "$cfgfile" ]; then
  echo "No configuration file: $cfgfile"
  exit
fi

source $cfgfile

curl $options -d "email=$reset_email" -X POST "$server/request-password-reset" > output/curl.log

echo "Result in output/curl.log (html page)"
