// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract CrowdFundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping (address funder => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

     constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough amount");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
    
    // function fund(uint256 value) public payable {}

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call Failed");
    }

    modifier onlyOwner(){
        if(msg.sender != i_owner) {revert NotOwner(); }
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable {
        fund();
     }

}