//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract MyStore {
    struct Receipt {
        uint price;
        uint quantity;
        uint paid;
    }

    Receipt public receipt;

    uint[3] public myArray;

    function MakeReceipt(
        uint _price,
        uint _quantity,
        uint _paid
    ) public {
        myArray[0] = _paid;
        myArray[1] = _price;
        myArray[2] = _quantity;

        receipt.paid = myArray[0];
        receipt.quantity = myArray.length;
    }
}
