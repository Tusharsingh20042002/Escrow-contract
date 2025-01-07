// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public depositor;    
    address public beneficiary;   
    address public arbiter;       
    
    bool public isApproved;   

    
    event Approved(uint256 amount);

    
    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;       
        arbiter = _arbiter;            
        beneficiary = _beneficiary;   
        isApproved = false;            
    }

    
    function approve() external {
        require(msg.sender == arbiter, "Only the arbiter can approve the transfer");  
        require(!isApproved, "Funds have already been approved");

        isApproved = true; 

        // Transfer funds to the beneficiary using .call()
        uint256 amount = address(this).balance;
        (bool sent, ) = beneficiary.call{ value: amount }("");
        require(sent, "Failed to send ether");

       
        emit Approved(amount);
    }
}
