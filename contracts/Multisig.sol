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

    constructor(address[] memory _owners, uint256 _confirmationRequired){
        require( _owners.length >1, "Number of owners must be greater than 1.");
        require(_confirmationRequired>0 && _confirmationRequired<=_owners.length, "Number of confirmation parameter error!");
    }
}