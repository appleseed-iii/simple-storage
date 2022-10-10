// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Storage.sol";

/// local deployment
/// forge script script/Storage.s.sol:MyScript --fork-url http://localhost:8545 --broadcast
/// goerli deployment
/// forge script script/Storage.s.sol:MyScript --rpc-url $GOERLI_RPC_URL --broadcast --verify -vvvv
contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Storage storageContract = new Storage();

        vm.stopBroadcast();
    }
}
