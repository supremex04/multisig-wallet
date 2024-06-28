// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract MultiSig {
    address[] public owners;
    uint256 public confirmationRequired;

    struct Transaction {
        address to;
        uint256 value;
        bool executed;
    }
    //  mapping to track which owners have confirmed which transactions.
    mapping(uint256 => mapping(address => bool)) public isConfirmed;

    Transaction[] public transactions;
    event transactionSubmitted(uint256 txID, address sender, address receiver, uint256 value);

    constructor(address[] memory _owners, uint256 _confirmationRequired){
        require( _owners.length >1, "Number of owners must be greater than 1.");
        require(_confirmationRequired>0 && _confirmationRequired<=_owners.length, "Number of confirmation parameter error!");

        for (uint256 i = 0; i < _owners.length; i++){
            require(_owners[i] != address(0), "Invalid owner");
            owners.push(_owners[i]);
        }
        confirmationRequired = _confirmationRequired;
    }

    function submitTransaction(address _receiver) public payable{
        require( _receiver != address(0), "Invalid receiver");
        require(msg.value > 0, "Tx amount cannot be 0");
        uint256 txID = transactions.length;
        transactions.push(Transaction({to: _receiver, value: msg.value, executed: false}));
        emit transactionSubmitted(txID, msg.sender, _receiver, msg.value);
        

    }
}