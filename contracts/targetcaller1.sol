//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Target {
    int256 public count;

    function decrement() public {
        count--;
    }
}

interface ITarget{
    function decrement() external;
}

contract TargetCaller {
    function callDecrementInterface(address _target) public{
        ITarget target = ITarget(_target);
        target.decrement();
    }

    // This is only possible when you have the other contract in scope
    function callDecrementDirect(Target _target) public {
        _target.decrement();
    }
}