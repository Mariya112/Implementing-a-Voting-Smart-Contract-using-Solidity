// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Voting
 * @dev Implements voting process with candidate management
 */
contract Voting {

    // Struct to store information about each voter
    struct Voter {
        bool voted;  // if true, that person already voted
        uint vote;   // index of the voted candidate
    }

    // Struct to store information about each candidate
    struct Candidate {
        uint id;       // candidate id
        string name;   // candidate name
        uint voteCount; // number of accumulated votes
    }

    // Address of the contract owner (the one who deployed the contract)
    address public owner;
    // Counter for the number of candidates
    uint public candidatesCount;

    // Mapping to store voter information by address
    mapping(address => Voter) public voters;
    // Mapping to store candidate information by candidate ID
    mapping(uint => Candidate) public candidates;

    // Event emitted when a new candidate is added
    event CandidateAdded(uint id, string name);
    // Event emitted when a vote is cast
    event Voted(address indexed voter, uint candidateId);

    // Modifier to restrict access to owner-only functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Constructor to initialize the contract owner
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Add a new candidate to the election. Only callable by owner.
     * @param _name name of the candidate
     */
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    /**
     * @dev Vote for a candidate. Each voter can only vote once.
     * @param _candidateId id of the candidate to vote for
     */
    function vote(uint _candidateId) public {
        Voter storage sender = voters[msg.sender];
        // Ensure the voter hasn't voted before
        require(!sender.voted, "You have already voted");
        // Ensure the candidate ID is valid
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        // Record that the voter has voted
        sender.voted = true;
        sender.vote = _candidateId;
        // Increment the vote count of the chosen candidate
        candidates[_candidateId].voteCount++;

        emit Voted(msg.sender, _candidateId);
    }

    /**
     * @dev Get the details of a candidate.
     * @param _candidateId id of the candidate
     * @return id, name, and vote count of the candidate
     */
    function getCandidate(uint _candidateId) public view returns (uint, string memory, uint) {
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.id, candidate.name, candidate.voteCount);
    }

    /**
     * @dev Get the details of all candidates.
     * @return array of all candidates
     */
    function getAllCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory allCandidates = new Candidate[](candidatesCount);
        // Iterate over all candidates and store them in an array
        for (uint i = 1; i <= candidatesCount; i++) {
            allCandidates[i - 1] = candidates[i];
        }
        return allCandidates;
    }

    /**
     * @dev Computes the candidate with the most votes.
     * @return id of the winning candidate
     */
    function winningCandidate() public view returns (uint) {
        uint winningVoteCount = 0;
        uint winningCandidateId = 0;
        // Iterate over all candidates to find the one with the most votes
        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateId = i;
            }
        }
        return winningCandidateId;
    }

    /**
     * @dev Returns the name of the winning candidate.
     * @return name of the winning candidate
     */
    function winnerName() public view returns (string memory) {
        // Get the name of the candidate with the most votes
        return candidates[winningCandidate()].name;
    }
}
