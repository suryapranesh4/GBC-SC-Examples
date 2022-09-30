//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract MyInvoice {
    struct Invoice {
        uint customerID;
        uint invoiceNum;
        uint total;
        bool status;
        LineItem[5] lineItem;
    }

    struct LineItem {
        uint price;
        uint quantity;
        string description;
    }

    mapping(address => Invoice) myInvoice;

    Invoice public invoice;

    function newInvoice(
        uint _customerId,
        uint _invoiceNum,
        uint _total
    ) public {
        invoice.customerID = _customerId;
        invoice.invoiceNum = _invoiceNum;
        invoice.total = _total;

        myInvoice[msg.sender] = invoice;
    }

    function viewPayment() public view returns (uint) {
        return myInvoice[msg.sender].total;
    }

    function acceptPayment() public payable {
        require(
            myInvoice[msg.sender].status == false,
            "You already paid and your balances are clear"
        );
        require(
            msg.value == myInvoice[msg.sender].total,
            "Your payment should be exactly as your balance"
        );

        myInvoice[msg.sender].status = true;
    }
}
