//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Escrow {
    enum TransactionState {
        AWAITING_PAYMENT,
        AWAITING_DELIVERY,
        COMPLETE
    }

    TransactionState public currentState;

    address payable public seller;
    address public buyer;

    modifier onlyBuyer() {
        require(msg.sender == buyer, "You are not authorized Buyer");
        _;
    }

    constructor(address _buyer, address payable _seller) {
        seller = _seller;
        buyer = _buyer;
    }

    function deposit() external payable onlyBuyer {
        require(
            currentState == TransactionState.AWAITING_PAYMENT,
            "Payment has alreay been deposited"
        );
        currentState = TransactionState.AWAITING_DELIVERY;
    }

    function confirmDelivery() external onlyBuyer {
        require(
            currentState == TransactionState.AWAITING_DELIVERY,
            "As a buyer You have to pay first to Confirm the Delivery"
        );
        transferFunds();
        currentState = TransactionState.COMPLETE;
    }

    function transferFunds() private {
        seller.transfer(address(this).balance);
    }
}
