#!/bin/bash

cfgfile=".config"

if [ ! -e "$cfgfile" ]; then
  echo "No configuration file: $cfgfile"
  exit
fi

source $cfgfile

if [ ! -n "${token}" ]; then

  if [ ! -n "${email}" ]; then
    echo "No email field found in configuration file."
    exit
  fi

  if [ ! -n "${password}" ]; then
    echo "No (hashed) password field found in configuration file."
    exit
  fi
  result=$(curl -X POST --silent --header "Content-Type: application/json" --header "Accept: application/json" -d "{\"email\": \"${email}\", \"password\": \"${password}\"}" "https://cloud.crownstone.rocks/api/users/login")

  access_token=$(echo $result | jq -r '.id')
  user_id=$(echo $result | jq -r '.userId')
  echo "Obtained user id: $user_id"
  echo "Obtained access token: $access_token"
else
  access_token=$token
  echo "Using existing access token: $access_token"

  result=$(curl -X GET --silent --header "Accept: application/json" "https://cloud.crownstone.rocks/api/users/me?access_token=$access_token")
  user_id=$(echo $result | jq -r '.id')
  echo "Obtained user id: $user_id"
fi

