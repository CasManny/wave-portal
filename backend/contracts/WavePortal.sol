// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract WavePortal {
    // To keep the number of total number of people that wavess
    uint256 waveCount;

    // a way to generate a random number
    uint256 private seed;
    

    // An event to show to the frontend app who called the transaction

    event NewWave(address indexed from, string message, uint256 timestamp);

    // create the waver object: information from the waver
    struct Waves {
        address waver;
        string message;
        uint256 timestamp;
    }

    // store the time each address called this function
    mapping(address => uint256) public lastWaveAt;

    // instantiate the Waves struct to an array
    Waves[] public wavers;

    constructor() payable {
        console.log("This is a smart contract");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    // create a transaction 

    function wave(string memory _message) public {
        // this functio should be called only after 15 seconds
        require(lastWaveAt[msg.sender] + 15 seconds < block.timestamp, "Wait for 15 seconds");

        // set the time for last wave
        lastWaveAt[msg.sender] = block.timestamp;

        // increase waveCount by 1
        waveCount++;
        // add sender into the wavers array
        wavers.push(Waves(msg.sender, _message, block.timestamp));

        // creating a reward system whereby anyone whose seed <= 50 will recieve an ether

        uint256 priceAmount = 0.0001 ether;
        if(seed <= 50) {
            // check if fund remaining in the wallet is not less than 0.0001 ether
            require(priceAmount <= address(this).balance, "No much fund in contract to withdraw");

            (bool success, ) = (msg.sender).call{value: priceAmount}("");
            require(success, "Contract needs to be funded");
        }

        // setting another random number for the next person calling the function 
        seed = (block.timestamp + block.difficulty + seed) % 100;
        

        // call the event function 

        emit NewWave(msg.sender, _message, block.timestamp);


    }

    // Get all waves in an array
    function getAllWavers() public view returns(Waves[] memory) {
        return wavers;
    }
}
