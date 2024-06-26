 Implemention a Voting Smart Contract using Solidity

 Overview
A basic voting application implemented using Solidity. This smart contract allows users to vote for candidates in an election, with functionalities for adding candidates, casting votes, and viewing election results.

 Prerequisites
- Node.js
- Truffle
- Ganache
- Metamask

Setup Instructions

1. Install Node.js
   - Download and install from [nodejs.org](https://nodejs.org).

2. Install Truffle
 
       npm install -g truffle

3. Initialize a Truffle Project
  
       mkdir VotingApp
       cd VotingApp
       truffle init

4. Install Ganache
   - Download and install Ganache from [ganache](trufflesuite.com/ganache)

5. Start Ganache
   - Open Ganache and create a new workspace.
   
6. Create the Smart Contract
   - Create a Voting.sol file in the contracts directory with the provided Solidity code.
  
7. Compile the Contracts
   
       truffle compile
  
8. Migrate the Contracts
   
       truffle migrate

9. Open Truffle Console
    
       truffle development
   
10. Inside the Truffle console:
    - Initalize Instance

          const voting = await Voting.deployed();
  
    - Add Candidates
      
          await voting.addCandidate("Mary", { from: YOUR_ACCOUNT_ADDRESS });
          await voting.addCandidate("John", { from: YOUR_ACCOUNT_ADDRESS });
     
    - Vote for Candidates
   
          await voting.vote(1, { from: YOUR_ACCOUNT_ADDRESS });
          await voting.vote(2, { from: ANOTHER_ACCOUNT_ADDRESS });
     
      View Results
     
          let candidate1 = await voting.getCandidate(1);
          console.log(candidate1);
      
          let candidate2 = await voting.getCandidate(2);
          console.log(candidate2);
      
          let allCandidates = await voting.getAllCandidates();
          console.log(allCandidates);

    - Check the Owner
    
          const owner = await voting.owner();
          console.log("Owner address:", owner);
  
