//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Parent contract
contract A {
    string public constant A_NAME = "A";

    function getName() public pure virtual returns(string memory) {
        return A_NAME;
    }
}

// Child contract
contract B is A {
    string public constant B_NAME = "B";

    function getName() public pure override returns(string memory) {
        return B_NAME;
    }
}