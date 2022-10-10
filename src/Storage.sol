// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.10;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {

    uint256 number;

    /**
     * @dev Store value in variable
     * @param num value to store
     * cast send --rpc-url=http://localhost:8545 --private-key=$PRIVATE_KEY $STORAGE_ADDR "store(uint256)" 1000
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     * cast call $STORAGE_ADDR "retrieve()(uint256)" --rpc-url=http://localhost:8545
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}