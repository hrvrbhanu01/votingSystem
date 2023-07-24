pragma solidity ^0.8.0;

contract VotingSystem {
    
    // Variables
    uint public totalVotes;
    mapping (address => bool) public hasVoted;
    mapping (bytes32 => uint) public votesReceived;
    bytes32[] public candidateList;

    // Constructor
    constructor(bytes32[] memory candidateNames) {
        candidateList = candidateNames;
    }

    // Vote function
    function vote(bytes32 candidate) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(validCandidate(candidate), "Invalid candidate.");
        
        votesReceived[candidate] += 1;
        hasVoted[msg.sender] = true;
        totalVotes += 1;
    }

    // Check if candidate is valid
    function validCandidate(bytes32 candidate) view public returns (bool) {
        for(uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }

    // Get total votes for a candidate
    function totalVotesFor(bytes32 candidate) view public returns (uint) {
        require(validCandidate(candidate), "Invalid candidate.");
        return votesReceived[candidate];
    }
}
