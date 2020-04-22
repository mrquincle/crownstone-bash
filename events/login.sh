#!/bin/bash

cfgfile=".config"

if [ ! -e "$cfgfile" ]; then
	echo "No configuration file: $cfgfile"
	exit
fi

source $cfgfile

function getAccessToken() {
	if [ ! -n "${email}" ]; then
		echo "No email field found in configuration file."
		exit
	fi

	if [ ! -n "${password}" ]; then
		echo "No (hashed) password field found in configuration file."
		exit
	fi
	content_header="Content-Type: application/json"
	accept_header="Accept: application/json"

	result=$(curl -X POST --silent ${server}/users/login -H "$content_header" -H "$accept_header" -d "{\"email\": \"${email}\", \"password\": \"${password}\"}")
	access_token=$(echo $result | jq -r '.token')
	echo "Obtained access token: $access_token"
}

if [ ! -n "${token}" ]; then
	getAccessToken
else
	access_token="$token"
	auth_header="Authorization: Bearer $access_token"
	accept_header="Accept: application/json"

	result=$(curl -X GET ${server}/users/me --silent -H "$auth_header" -H "$accept_header")
	refresh=$(echo $result | grep -i 'unauthorizederror')
	if [ -n "${refresh}" ]; then
		echo "Unauthorized. Refresh access token (write to file)."
		getAccessToken
		echo "Write this access token to file and try again!"
		exit
	else
		user_id=$(echo "$result" | jq -r '.id')
	fi
fi

