#!/usr/bin/env bash

for contract in "TokenineERC20"
do
  npx truffle-flattener contracts/token/ERC20/$contract.sol > dist/$contract.dist.sol
done

npx truffle-flattener contracts/service/ServiceReceiver.sol > dist/ServiceReceiver.dist.sol
