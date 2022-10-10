// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Widget.sol";

// local deployment
// forge script script/Widget.s.sol:MyScript --fork-url http://localhost:8545 --broadcast
contract MyScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Widget widget = new Widget();

        vm.stopBroadcast();
    }
}
