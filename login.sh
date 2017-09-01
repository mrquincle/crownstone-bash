#!/bin/bash

cfgfile=".config"

if [ ! -e "$cfgfile" ]; then
  echo "No configuration file: $cfgfile"
  exit
fi

source $cfgfile

if [ ! -n "${email}" ]; then
  echo "No email field found in configuration file."
  exit
fi

if [ ! -n "${password}" ]; then
  echo "No (hashed) password field found in configuration file."
  exit
fi

result=$(curl -X POST --silent --header "Content-Type: application/json" --header "Accept: application/json" -d "{\"email\": \"${email}\", \"password\": \"${password}\"}" "https://cloud.crownstone.rocks/api/users/login")

access_token=$(echo $result | cut -f4 -d '"')
user_id=$(echo $result | cut -f14 -d '"')
echo "Obtained user id: $user_id"
