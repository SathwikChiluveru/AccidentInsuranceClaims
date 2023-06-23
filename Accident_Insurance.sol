// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccidentInsuranceClaim {
    address public insurer;
    address public policyholder;
    uint public claimAmount;
    bool public isFiled;
    
    event ClaimFiled(address indexed _policyholder, uint _claimAmount);

    
    constructor(address _insurer, address _policyholder, uint _claimAmount) {
        insurer = _insurer;
        policyholder = _policyholder;
        claimAmount = _claimAmount;
        isFiled = false;
    }


    function fileClaim() public {
        require(msg.sender == policyholder, "Only policyholder can file a claim.");
        require(!isFiled, "Claim has already been filed.");
        
        isFiled = true;
        
        emit ClaimFiled(msg.sender, claimAmount);
    }

    
}


contract AccidentInsuranceClaimHandler{

    address public insurer;
    address public policyholder;
    uint public claimAmount;
    bool public isClaimed;
    
    event ClaimFiled(address indexed _policyholder, uint _claimAmount);
    event ClaimApproved(address indexed _insurer, uint _claimAmount);
    event ClaimRejected(address indexed _insurer, string _reason);
    
    constructor(address _insurer, address _policyholder, uint _claimAmount) {
        insurer = _insurer;
        policyholder = _policyholder;
        claimAmount = _claimAmount;
        isClaimed = false;
    }

    function approveClaim(string memory reason) public {
        isClaimed = true;
        require(msg.sender == insurer, "Only insurer can approve the claim.");
        require(isClaimed, "No claim has been filed.");
        

        
        emit ClaimRejected(msg.sender, reason);
    }
    
    function rejectClaim(string memory reason) public {
        require(msg.sender == insurer, "Only insurer can reject the claim.");
        require(isClaimed, "No claim has been filed.");
        
        isClaimed = false;
        
        emit ClaimRejected(msg.sender, reason);
    }
}


