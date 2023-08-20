//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Second Approach: Should be used when we want to transfer some ETH to a 
// target contract.
contract Target {
    int256 public count;

    function decrement(int num) public payable {
        count = count - num;
    }
}

interface ITarget {
    function decrement(int num) external payable;
}

contract TargetCaller {
    function callDecrementLowLevel(address _target) public {
        ITarget target = ITarget(_target);
        target.decrement{value:0}(5); 
    }
}