# votingSystem

This contract allows voters to cast a vote for a candidate by calling the vote function and passing in the candidate's name as a bytes32 parameter. The contract keeps track of the total number of votes cast and whether a voter has already voted. It also maintains a list of valid candidates and keeps track of the number of votes each candidate receives.

To use this contract, you would need to deploy it to a blockchain network that supports Solidity smart contracts, such as Ethereum. Once deployed, voters can interact with the contract through a user interface, such as a web application or a mobile app, to cast their votes.

pragma solidity ^0.8.0;

This line specifies the version of Solidity that the contract is written in. In this case, the contract is written in Solidity version 0.8.0.

contract VotingSystem {

This line begins the definition of the VotingSystem contract. A contract is similar to a class in other programming languages.

// Variables

    uint public totalVotes;
    mapping (address => bool) public hasVoted;
    mapping (bytes32 => uint) public votesReceived;
    bytes32[] public candidateList;
    
These lines declare the variables used in the contract. totalVotes is a uint variable that keeps track of the total number of votes cast. hasVoted is a mapping that associates each address with a boolean value indicating whether that address has already voted. votesReceived is a mapping that associates each candidate's name with the number of votes they have received. candidateList is an array of bytes32 values that contains the names of the valid candidates.

// Constructor

    constructor(bytes32[] memory candidateNames) {
        candidateList = candidateNames;
    }
    
This is the constructor function, which is called when the contract is deployed to the blockchain. The constructor takes an array of bytes32 values as a parameter, which represents the list of valid candidates. The constructor assigns the input array to the candidateList variable.

// Vote function

    function vote(bytes32 candidate) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(validCandidate(candidate), "Invalid candidate.");
        
        votesReceived[candidate] += 1;
        hasVoted[msg.sender] = true;
        totalVotes += 1;
    }
    
This is the vote function, which allows a voter to cast a vote for a candidate. The function takes a bytes32 parameter representing the candidate's name. The function first checks whether the voter has already voted by looking up the hasVoted mapping for the voter's address. If the voter has not already voted, the function checks whether the candidate is a valid candidate by calling the validCandidate function. If the candidate is valid, the function increments the candidate's vote count in the votesReceived mapping, sets the voter's hasVoted value to true, and increments the totalVotes variable.

// Check if candidate is valid

    function validCandidate(bytes32 candidate) view public returns (bool) {
        for(uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }
    
This is the validCandidate function, which checks whether a candidate is a valid candidate by comparing the candidate's name to the names in the candidateList array. The function takes a bytes32 parameter representing the candidate's name and returns a boolean value indicating whether the candidate is valid.

// Get total votes for a candidate

    function totalVotesFor(bytes32 candidate) view public returns (uint) {
        require(validCandidate(candidate), "Invalid candidate.");
        return votesReceived[candidate];
    }
    
This is the totalVotesFor function, which returns the total number of votes that a candidate has received. The function takes a bytes32 parameter representing the candidate's name and first checks whether the candidate is a valid candidate by calling the validCandidate
