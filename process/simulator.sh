#!/bin/bash

trials=1000

ofile=trials.txt

rm -f $ofile

for i in $(seq 1 $trials); do

	cat result.txt | sed 's|,| |g' | shuf > tmp/shuffle.txt

	length=$(cat tmp/shuffle.txt | wc -l)

	test=$(( length/10 ))
#	test=10

	cat tmp/shuffle.txt | head -n $test > testing.txt
	cat tmp/shuffle.txt | tac | head -n -$test | tac > training.txt

	#~/workspace/nearest-neighbour/nn training.txt testing.txt sim_out_labels.txt | tail -n1 | cut -f2 -d':' | tee -a $ofile
	~/workspace/nearest-neighbour/nn training.txt testing.txt sim_out_labels.txt | tail -n1 | cut -f2 -d':' >>  $ofile

done

total=$(cat trials.txt | sed 's|^ ||g' | cut -f1 -d' ' | paste -s -d+ - | bc)

average=$(( total * 100 / (trials * test)  ))

echo "On average $average%"
