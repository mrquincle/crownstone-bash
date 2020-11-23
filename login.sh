#!/bin/bash

cfgfile=".config"

if [ ! -e "$cfgfile" ]; then
	echo "No configuration file: $cfgfile"
	exit
fi

source $cfgfile

accept_header="Accept: application/json"
content_type_header="Content-Type: application/json"

# Is used by all scripts anyway, just do it here
options="-s"
mkdir -p output
rm -f output/curl.log

function updateAccessToken() {
	#echo "Update access token: $access_token"
	sed -i -E "s/^(token[[:blank:]]*=[[:blank:]]*).*/\1$access_token/" $cfgfile
}

function writeAccessToken() {
	#echo "Write access token: $access_token"
	echo "token=$access_token" >> $cfgfile
}

function getAccessToken() {
	local _result=$1
	if [ ! -n "${email}" ]; then
		echo "No email field found in configuration file."
		ret_code=1
		eval $_result="'$ret_code'"
		exit
	fi

	if [ ! -n "${password}" ]; then
		echo "No (hashed) password field found in configuration file."
		ret_code=2
		eval $_result="'$ret_code'"
		exit
	fi
	response=$(curl -X POST $options -H "$content_type_header" -H "$accept_header" -d "{\"email\": \"${email}\", \"password\": \"${password}\"}" "$server/api/users/login")

	access_token=$(echo $response | jq -r '.id')
	auth_header="Authorization: $access_token"
	user_id=$(echo $response | jq -r '.userId')

	#echo "Obtained user id: $user_id"
	#echo "Obtained access token: $access_token"
	ret_code=0
	eval $_result="'$ret_code'"
}

function accessTokenCheck() {
	local _result=$1
	response=$(curl -X GET $options -H "$accept_header" -H "$auth_header" "$server/api/users/me")
	refresh=$(echo $response | grep -i '\<authorization required\>')
	if [ -n "${refresh}" ]; then
		ret_code=1
	else
		user_id=$(echo $response | jq -r '.id')
		ret_code=0
	fi
	eval $_result="'$ret_code'"
}

if [ ! -n "${token}" ]; then
	getAccessToken result
	if [[ $result == 0 ]]; then
		writeAccessToken
	fi
else
	access_token=$token
	auth_header="Authorization: $access_token"
	#echo "Using existing access token: $access_token"

	accessTokenCheck result
	if [[ $result == 0 ]]; then
		true
	else
		#echo "Unauthorized. Refresh access token (write to file)."
		getAccessToken result
		if [[ $result == 0 ]]; then
			updateAccessToken
	
			accessTokenCheck result
			if [[ $result != 0 ]]; then
				echo "Could not access again with updated token"
			else
				getAccessToken result
			fi
		fi
	fi
fi

