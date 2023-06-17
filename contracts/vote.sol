// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
contract vote {
    struct Candidate {
        string name;
        string seatType;
        string electionType;
        string halka;
        string party;
        uint256 voteCount;
    }
    mapping(uint256 => Candidate) candidates;
    uint256 public candidateCount;
    mapping(string => uint256) public voteCount;

    event VoteCast(
        address indexed voter,
        uint256 indexed candidateId
    );

    function registerCandidate( Candidate[] memory _candidates) public {
        for (uint256 i = 0; i < _candidates.length; i++) {
        Candidate memory candidate = _candidates[i];
        candidates[candidateCount] = Candidate(candidate.name, candidate.seatType, candidate.electionType, candidate.halka, candidate.party, candidate.voteCount);
        candidateCount++;
        }
    }

    function castVote(uint256 candidateId) public {
        voteCount[ candidates[candidateId].name ] += 1;
        candidates[candidateId].voteCount += 1;
        emit VoteCast(msg.sender, candidateId);
    }

    function eachCandidateVote() public view returns (Candidate[] memory) {
             Candidate[] memory votes = new Candidate[](candidateCount);
            for (uint256 i = 0; i < candidateCount; i++) {
                votes[i] = candidates[i];
            }
            return votes;
        }

    function getTotalVotes() public view returns (uint256) {
        uint256 totalVotes = 0;
        for (uint256 i = 0; i < candidateCount; i++) {
            totalVotes += candidates[i].voteCount;
        }
        return totalVotes;
    }
}