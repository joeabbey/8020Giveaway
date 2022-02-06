#!/bin/bash

for i in $(cat addresses.txt); do
	echo "$i, $(chihuahuad q txs --events coin_received.receiver=$i -o json | jq -r ".txs[0].height")"
done
