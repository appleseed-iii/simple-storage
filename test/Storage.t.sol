// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Storage.sol";

contract StorageTest is Test {
    Storage public storageContract;

    function setUp() public {
        storageContract = new Storage();
    }

    function testStore() public {
        storageContract.store(1);
        assertEq(storageContract.retrieve(), 1);
    }
}
