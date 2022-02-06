# 8020Giveaway
A collection of scripts

Once a day I run `./scripts/getData.sh` to collect the mapping of delegations to active set validators, and the overall active set of validators.

Additionally, I run `./scripts/validator_self_stake.sh` to convert the validators address to a self-staking address.

I take the CSV files and input them into the Google Sheet,

I then find new addresses, and run them in teh `./scripts/first_tx.sh` to check when the address was first funded.
