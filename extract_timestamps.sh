#!/bin/bash

cat output/curl.log| tr -s ',' '\n' | tr -s ']' '\n' | tr -s '[' '\n' | grep timestamp | sed 's/{"timestamp"://g' | grep '"' | tr -d '"' | tr -d ' '| tr -d ',' | tr -d 'Z' | sed 's/T/ /g' > output/timestamps.log

touch output/unixtimestamps.log
rm output/unixtimestamps.log

while read line; do
  date -d "$line" '+%s' >> output/unixtimestamps.log
done < output/timestamps.log
