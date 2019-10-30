#!/bin/sh

cd ..

rm -f output/curl.log

./login.sh

read -p "Did you update your key? " dummy

echo "Get current location"

./get_current_location.sh > /dev/null

read -p "What is the name of your phone [Lenovo P2]? " phone
phone=${phone:-Lenovo P2}

sphereId=$(< output/curl.log jq -r ".[] | select(.deviceName == \"$phone\").inSpheres[].sphereId")

echo "Sphere id is $sphereId"

./get_owned_stones.sh $sphereId > /dev/null

read -p "What is the name of the Crownstone you like to query [Lamp]? " name
name=${name:-Lamp}

stoneId=$(< output/curl.log jq -r ".[] | select(.name == \"$name\").id")

echo "Crownstone $name has id $stoneId"

echo "Get power history"

./get_power_usage_history.sh $stoneId > /dev/null

rm -f output/power.log
rm -f output/time.log
rm -f output/timeseries.log

< output/curl.log jq -r '.[].power' > output/power.log
< output/curl.log jq -r '.[].timestamp' > output/time.log 

paste output/power.log output/time.log > output/timeseries.log 

nofValues=$(wc -l output/timeseries.log)

echo "Obtained $nofValues values"

echo "Show plot"

cd complex

rm -f Rplots1.pdf
Rscript timeseries.R 
xdg-open "Rplots1.pdf"

