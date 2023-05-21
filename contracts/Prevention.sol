// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract PreventDOS {
    address public currentWinner;
    uint public currentAuctionPrice;
    mapping(address => uint) public balances;

    constructor() {
        currentWinner = msg.sender;
    }

    function setCurrentAuctionPrice() public payable {
        require(
            msg.value > currentAuctionPrice,
            "Need to pay more than the currentAuctionPrice"
        );
        balances[currentWinner] += currentAuctionPrice; // Prevention
        currentAuctionPrice = msg.value;
        currentWinner = msg.sender;
    }

    function withdraw() public {
        require(msg.sender != currentWinner, "Current Winner cannot withdraw");
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
