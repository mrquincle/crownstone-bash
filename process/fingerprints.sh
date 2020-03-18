#!/bin/bash

# Input
files=../output/fingerprints/*

# Select on this particular phone model/type
device=msm8954

# Set up temporary directories
mkdir -p tmp
rm -rf tmp/fingerprints
rm -f tmp/stones
mkdir -p tmp/fingerprints
mkdir -p tmp/fingerprints_phone

# Limit fingerprints to a particular phone
for f in $files; do
	cat $f | jq '.[] | select(.phoneType=="msm8953")' > "tmp/fingerprints_phone/${f##*/}"
done

# Adjust files blob to new set of files
files=tmp/fingerprints_phone/*

# Have all unique stone id's in one file
cat $files | jq -r '.data[].devices | to_entries[].key' | sort | uniq >> tmp/stones

# Replace long stone id's with an index
stone_nr=0
while read stone_id; do
	for f in $files; do
		sed -i "s|$stone_id|$stone_nr|g" $f
	done
	stone_nr=$(( stone_nr + 1 ))
done < tmp/stones

# One stone too many, just decrement once
stone_nr=$(( stone_nr - 1 ))

# Create a struct that can be used to do filtering by jq later
sequence="{ \"0\""
for i in $(seq 1 $stone_nr); do
	sequence="$sequence, \"$i\""
done
sequence="$sequence }"

# Create file with output
ofile=result.txt

rm -f $ofile

room_id=1
for f in $files; do
	echo "Number of timestamps in $f is $(cat $f | grep timestamp | wc -l)"
	cat $f | jq -r ".data[].devices | $sequence | flatten | @csv" | sed 's|^,|-Inf,|' | sed 's|,,|,-Inf,|g' | sed 's|,,|,-Inf,|g' | sed 's|,$|,-Inf|g' | sed 's|99999999999||g' | sed 's|00000000000||g' | sed "s|^|$room_id,|g" >> $ofile
	room_id=$((room_id + 1))
done

cat $ofile | sed 's|,| |g' | shuf > tmp/shuffle.txt

length=$(cat tmp/shuffle.txt | wc -l)

test=$(( length/10 ))

cat tmp/shuffle.txt | head -n $test > testing.txt
cat tmp/shuffle.txt | tac | head -n -$test | tac > training.txt


