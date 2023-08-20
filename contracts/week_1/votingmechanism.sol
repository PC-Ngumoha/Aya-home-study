// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
A voting system should have the following features:

- Can be created by a single user who will create a list of options to pick from
- each option will have the following fields:
    + ID - Identify the option
    + title - What this option is called
    + votes - Number of votes recorded
- The poll should have a open time and a closing time
- Users should be able to cast votes for a particular option using it's ID
- Users should also be able to see the results
- No user should be able to vote more than once
*/

contract Poll {
    string public topic;
    address immutable creator;
    uint immutable created;
    uint duration;

    // stores voters that have voted
    mapping (address => bool) voted;

    // Gives the ability to specify duration
    enum Duration { HOUR, DAY, WEEK }

    struct Option {
        uint id;
        string title;
        uint votes;
    }

    // Array of options a user can cast votes for
    Option[] options; 

    // Ensures that user has not voted before
    modifier hasNotYetVoted() {
        require(voted[msg.sender] != true, "User cannot vote twice");
        _;
    }

    // Ensures that poll is still valid
    modifier pollStillValid() {
        require(block.timestamp < (created + duration), 
        "Time for poll has elapsed");
        _;
    }


    constructor(
        string memory _topic, 
        string[] memory _titles, 
        uint _duration, 
        Duration _choice
    ) 
    {
        // Setup the poll topic
        topic = _topic;

        // Setup the creator and the time created
        creator = msg.sender;
        created = block.timestamp;

        // Setup the duration of the poll
        if ( _choice == Duration.HOUR ) {
            duration = _duration * 1 hours;
        } else if ( _choice == Duration.DAY ) {
            duration = _duration * 1 days;
        } else if ( _choice == Duration.WEEK ) {
            duration = _duration * 1 weeks;
        } else {
            // Throws an error
            revert("Unsupported time duration selected");
        }
        
        // Setup the options for the poll
        for (uint i = 0; i < _titles.length; i++) {
            options.push(Option((i+1), _titles[i], 0));
        }
    }

    // Allows the users to cast their votes
    // for a specific option using its ID
    function castVote(uint _id) public pollStillValid hasNotYetVoted {
        bool voteCast = false;
        // Searches through the array of options
        for (uint i = 0; i < options.length; i++) {
            // Finds option with the specified ID
            if (options[i].id == _id) {
                // Increments number of votes cast for that option
                options[i].votes += 1;
                // Records the current user address to prevent double-voting
                voted[msg.sender] = true;
                voteCast = true;
                break;
            }
        }

        // Ensure that vote count was counted successfully, if not
        // reverts all changes to state
        require(voteCast, "Option with selected ID was not found");
    } 

    function seeResults() 
        public 
        view 
        returns(uint[] memory, string[] memory, uint[] memory) 
        {
        uint[] memory ids = new uint[](options.length);
        string[] memory titles = new string[](options.length);
        uint[] memory voteCounts = new uint[](options.length);

        for (uint i = 0; i < options.length; i++) {
            ids[i] = options[i].id;
            titles[i] = options[i].title;
            voteCounts[i] = options[i].votes;
        }

        return (ids, titles, voteCounts);
    }
}