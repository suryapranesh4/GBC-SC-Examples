//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract CellSubcription {
    uint monthlyCost;

    constructor(uint cost) {
        monthlyCost = cost;
    }

    function makePayment() public payable {}

    function withdrawBalance() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    function isBalanceCurrent(uint monthsElapsed) public view returns (bool) {
        return monthlyCost * monthsElapsed == address(this).balance;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
