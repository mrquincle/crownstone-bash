#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id"}

source login.sh

endpoint=Spheres/$sphere_id/ownedLocations

echo "First get all rooms in this sphere"
curl $options "$server/api/$endpoint" -H "$auth_header" > output/curl.log

< output/curl.log jq -r '.[].id' > output/room_ids

echo "Write results to output/fingerprints"
mkdir -p output/fingerprints

while read room_id; do
	echo "Get fingerprints from room $room_id"
	endpoint=Locations/$room_id/fingerprints
	ofile=output/fingerprints/$room_id.fingerprints.txt
	curl $options "$server/api/$endpoint" -H "$auth_header" > $ofile
done < output/room_ids
