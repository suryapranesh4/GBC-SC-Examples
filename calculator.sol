//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Calculator {
    function AddNums(uint a, uint b) public pure returns (uint) {
        uint c = a + b;
        require(c >= a, "ADD-Variable Overflow Detected");
        return c;
    }

    function SubsNums(uint a, uint b) public pure returns (uint) {
        uint c = a - b;
        require(b <= a, "SUBS-Variable Overflow Detected");
        return c;
    }

    function DivideNums(uint a, uint b) public pure returns (uint) {
        require(b > 0, "Divide-Invalid by Zero");
        uint c = a / b;
        return c;
    }
}
