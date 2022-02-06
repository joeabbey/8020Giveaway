#!/bin/bash

# Compile the mapping of validators and delegators
for i in $(chihuahuad query staking validators --limit 1000 -o json | jq -r '.validators[] | select(.status=="BOND_STATUS_BONDED") | .operator_address'); do
    OFFSET=0
    AMOUNT=200
    NEXT_KEY="TBD"
    while [[ "${NEXT_KEY}" != "null" ]]; do
        echo ${i} ${NEXT_KEY}
        DOC=$(chihuahuad query staking delegations-to $i --limit $AMOUNT --offset $OFFSET -o json);
        echo "$DOC" | jq -r '.delegation_responses[].delegation | [ ( .delegator_address, .validator_addrss, .shares | tonumber / pow(10;6) ) ] | @csv' >> delegations.csv;
        NEXT_KEY="$(echo "$DOC" | jq -r '.pagination.next_key' )";
        OFFSET=$(( OFFSET + AMOUNT ));
        sleep 1
    done;
done

# Compile the list of active set validators
for i in $(chihuahuad q staking validators -o json --limit 300 | jq -r '.validators[] | select( .status == "BOND_STATUS_BONDED") | .operator_address'); do 
	chihuahuad q staking validator ${i} -o json | jq -r '[.description.moniker, .operator_address, .consensus_pubkey.key, .tokens, .status] | @csv' >> validators.csv ; 
done
