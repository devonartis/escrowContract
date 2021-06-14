// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Escrow {
    
    address public buyer;
    address public seller;
    uint public deposit;
    uint public timetToExpiry;
    uint public startTime;
    bool public paused;
    
    constructor(address _seller, uint _timeToExpiry) payable {
        buyer = msg.sender;
        seller = _seller;
        deposit = msg.value;
        timetToExpiry = _timeToExpiry;
        startTime = block.timestamp;
    }
    
    // Buyer withdraw funds if timetToExpiry 
    function buyerWithdrawFunds() public payable {
        //Base code without _timeToExpiry
        require(msg.sender == buyer, "You are not the buyer/owner of contract");
        payable(buyer).transfer(address(this).balance);
        
        
    }
    
    // Buyer releases deposit to seller 
    function releaseFundsToSeller() public payable {
        require(msg.sender == buyer, "You are not the buyer/owner of contract");
        payable(seller).transfer(address(this).balance);
    }
    
    function pauseContract(bool _paused) public {
        require(msg.sender == buyer, "Please have the owner pause the contract");
        paused = _paused;
        
    }
    function sellerCancel() public payable {
        require(msg.sender == seller, "You are not the seller party so you can not cancel contract");
        //selfdestruct(payable(buyer));
        payable(buyer).transfer(address(this).balance);
    }
       
    
}