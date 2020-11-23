#!/bin/bash

usage="$0 name ai_name ai_sex latitude longitude"

sphere_name=${1:? "$usage"}
sphere_ai_name=${2:? "$usage"}
sphere_ai_sex=${3:? "$usage"}
sphere_latitude=$4
sphere_longitude=$5

sphere_latitude=${sphere_latitude:-"51.924120"}
sphere_longitude=${sphere_longitude:-"4.470040"}

source login.sh

endpoint=Spheres

sphere_data="{
  \"name\": \"$sphere_name\",
  \"aiName\": \"$sphere_ai_name\",
  \"aiSex\": \"$sphere_ai_sex\",
  \"gpsLocation\": {
    \"lat\": $sphere_latitude,
    \"lng\": $sphere_longitude
  }
}"

sphere_data=$(echo $sphere_data | tr -d '\n')

# maybe -H "Content-Type: application/json" 

curl $options -X POST "$server/api/$endpoint" --data "$sphere_data" -H "$auth_header" > output/curl.log

< output/curl.log jq
