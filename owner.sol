//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract OwnerExample {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function FuncOnlybyOwner(uint a) public view onlyOwner returns (uint) {
        return a;
    }
}
