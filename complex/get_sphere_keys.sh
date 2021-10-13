#!/bin/bash

sphere_id=${1:? "Usage: $0 sphere_id"}

cd ..

mkdir -p output

keyfile=output/keys.json

# Explanation: 
#   $sphere_id is already supported as argument to get_keys_v2.sh
#   get only the sphereKeys which is an array
#   get the fields .keyType and .key and join them for each key
#   the join operator removes the strings hence add them again
#   add a comma to each line at the end 's|$|,|g'
#   remove the comma in the very last line: '$ s|.$||'
#   add a starting curly bracket { to the first line: '1 i{'
#   add a stopping curly bracket } to the last line: '$a}'
./get_keys_v2.sh $sphere_id | jq '.sphereKeys[] | [.keyType, .key] | join(":")' | sed 's|:|":"|g' | sed 's|$|,|g' | sed '$ s|.$||' | sed '1 i{' | sed '$a}' > $keyfile

# The json structure does use other fields than the fields returned from the REST API call
sed -i 's/ADMIN_KEY/admin/' $keyfile
sed -i 's/MEMBER_KEY/member/' $keyfile
sed -i 's/BASIC_KEY/basic/' $keyfile
sed -i 's/LOCALIZATION_KEY/localizationKey/' $keyfile
sed -i 's/SERVICE_DATA_KEY/serviceDataKey/' $keyfile
sed -i 's/MESH_APPLICATION_KEY/meshApplicationKey/' $keyfile
sed -i 's/MESH_NETWORK_KEY/meshNetworkKey/' $keyfile

cat $keyfile
