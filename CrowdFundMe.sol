// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

// Get funds from users
// Withdraw funds
// Set a minimum funding value in usd

contract CrowdFundMe {

    function fund() public payable {

        // allow users to send funds
        // set a minimum funding value

        // Sending ETH to the contract
        require(msg.value > 1e18, "Not enough amount");

        //revert - undo any actions that have been done and send the remaining gas back


    }

    function withdraw() public {}

}