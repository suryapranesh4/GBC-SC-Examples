//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract FundMe {
    address public owner;
    address payable public fundRecipient;
    uint public totalAmounttoRaise;
    uint public daysToGo;

    //Struct Enums

    struct Contributors {
        uint amount;
        address payable contributorAddr;
    }

    enum State {
        Fundraising,
        Expired,
        Succesfull
    }

    State public state = State.Fundraising;

    uint public totalRaised;
    uint public raiseBy;
    uint public completeAt;

    //Contributor Object

    Contributors[] contributors;

    //Events

    event LogFundingReceived(address addr, uint amount, uint currentTotal);
    event LogRecipeintPaid(address recipientAddr);

    //Modifiers

    modifier isState(State _state) {
        require(state == _state);
        _;
    }

    modifier isOwner() {
        require(owner == msg.sender);
        _;
    }

    modifier atEndofCycle() {
        require(
            (state == State.Expired || state == State.Succesfull) &&
                4 < block.timestamp
        );
        _;
    }

    constructor(
        uint _amount,
        uint _days,
        address payable _recipient
    ) {
        owner = msg.sender;
        fundRecipient = _recipient;
        totalAmounttoRaise = _amount;
        daysToGo = _days + 1 days;
    }

    function donate(uint _amount)
        public
        payable
        isState(State.Fundraising)
        returns (uint id)
    {
        contributors.push(Contributors(_amount, payable(msg.sender)));
        totalRaised += _amount;
        emit LogFundingReceived(msg.sender, _amount, totalRaised);
        checkIfCompleteOrExpired();
        return contributors.length - 1;
    }

    function checkIfCompleteOrExpired() public {
        if (totalRaised >= totalAmounttoRaise) {
            state = State.Succesfull;
            SuccessPayout();
        } else if (block.timestamp > daysToGo) {
            state = State.Expired;
        }
    }

    function SuccessPayout() public isState(State.Succesfull) {
        fundRecipient.transfer(address(this).balance);
        emit LogRecipeintPaid(fundRecipient);
    }

    function GetRefund(uint _id) public isState(State.Expired) returns (bool) {
        require(contributors[_id].amount != 0);
        uint amountTorefund = contributors[_id].amount;
        contributors[_id].amount = 0;
        contributors[_id].contributorAddr.transfer(amountTorefund);
        return true;
    }

    function removeContract() public isOwner atEndofCycle {
        selfdestruct(payable(msg.sender));
    }
}
