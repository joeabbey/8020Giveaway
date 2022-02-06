#!/bin/bash

for i in $(chihuahuad q staking validators -o json --limit 300 | jq -r '.validators[] | select( .status == "BOND_STATUS_BONDED") | .operator_address'); do
	chihuahuad keys parse "$(chihuahuad keys parse $i --output json | jq -r .bytes)" --output json | jq -r '.formats[0]'
done
