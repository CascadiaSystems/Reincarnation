#!/bin/sh

# create users
rm -rf $HOME/.starsd
starsd config chain-id localnet-1
starsd config keyring-backend test
starsd config output json
# setup chain
starsd init stargaze --chain-id localnet-1
# modify config for development
config="$HOME/.starsd/config/config.toml"
if [ "$(uname)" = "Linux" ]; then
  sed -i "s/cors_allowed_origins = \[\]/cors_allowed_origins = [\"*\"]/g" $config
else
  sed -i '' "s/cors_allowed_origins = \[\]/cors_allowed_origins = [\"*\"]/g" $config
fi


starsd add-genesis-account $VALIDATOR 10000000000000000stake
starsd add-genesis-account $CREATOR 10000000000000000stake
starsd add-genesis-account $INVESTOR 10000000000000000stake
starsd add-genesis-account $FUNDER 10000000000000000stake
starsd gentx validator 10000000000stake --chain-id localnet-1 --keyring-backend test
starsd collect-gentxs
starsd validate-genesis
starsd start
