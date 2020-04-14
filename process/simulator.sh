#!/bin/bash

usage="$0 <number of trials> <simulator: knn|naivebayes>"

trials=${1:? "Usage: $usage"}

simulator=${2:? "Usage: $usage"}

ofile=trials.txt

mkdir -p tmp

rm -f $ofile
	
echo "We will run the following $trials times"
echo ~/workspace/nearest-neighbour/${simulator} training.txt testing.txt sim_out_labels.txt 

for i in $(seq 1 $trials); do

	cat result.txt | sed 's|,| |g' | shuf > tmp/shuffle.txt

	length=$(cat tmp/shuffle.txt | wc -l)

	test=$(( length/10 ))
#	test=10

	cat tmp/shuffle.txt | head -n $test > testing.txt
	cat tmp/shuffle.txt | tac | head -n -$test | tac > training.txt

	~/workspace/nearest-neighbour/${simulator} training.txt testing.txt sim_out_labels.txt > tmp/last_run
	cat tmp/last_run | tail -n1 | cut -f2 -d':' >>  $ofile

done

total=$(cat trials.txt | sed 's|^ ||g' | cut -f1 -d' ' | paste -s -d+ - | bc)

average=$(( total * 100 / (trials * test)  ))

echo "On average $average%"
