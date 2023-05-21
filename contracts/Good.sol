// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Good {
    address public currentWinner;
    uint public currentAuctionPrice;
    // Prevention
    mapping (address => uint) public balances;

    constructor() {
        currentWinner = msg.sender;        
    }

    function setCurrentAuctionPrice() public payable {
        require(msg.value > currentAuctionPrice, "Need to pay more than the currentAuctionPrice");
        balances[currentWinner] += currentAuctionPrice; // Prevention 
        (bool sent, ) = currentWinner.call{value: currentAuctionPrice}("");
        if (sent) {
            currentAuctionPrice = msg.value;
            currentWinner = msg.sender;
        }
        currentAuctionPrice = msg.value;
        currentWinner = msg.sender;
    }

    // Add Withdraw function to prevent
}