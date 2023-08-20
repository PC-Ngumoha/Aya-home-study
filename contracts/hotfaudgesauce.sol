//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
Interfaces: Can only contain the declarations of functions
to be implemented by contracts using said interface. Cannot
contain any implementation logic/code
*/
interface IHotFaudgeSauce {
    function get() external view returns(uint);
    function increment() external;
    function decrement() external;
}

/*
Abstract Contract: must contain at least one function which is
declared but not implemented. Used to impose defined design structure
in child-contracts that inherit from them.
*/
abstract contract Feline {
    int public age;

    // not implemented
    function utterance() public virtual returns(bytes32);

    // implemented
    function setAge(int _age) public {
        age = _age;
    }
}

contract HotFaudgeSauce {
    // state variables
    uint public qtyCups;
    address private me = 0x9425DB8c621934DcB3f1C652Eda0428ECc3789Cf;

    function get() public view returns(uint) {
        return qtyCups;
    }

    function increment() public {
        qtyCups += 1;
    }

    function decrement() public {
        qtyCups -= 1;
    }

    // Handles the dispensing of hotfaudgesauce cups
    function dispense(uint numCups) public returns(uint) {
        uint dispensed = 0; // local variable

        if (msg.sender == me) {
            return dispensed;
        }

        if (numCups <= qtyCups) {
            qtyCups -= numCups;
            dispensed = numCups;
        }
        return dispensed;
    }
}