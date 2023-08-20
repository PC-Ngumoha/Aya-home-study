//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

library WierdMaths {
    int private constant factor = 100;

    function applyFactor(int self) public pure returns(int) {
        return self * factor;
    }

    function add(int self, int num) public pure returns(int) {
        return self + num;
    }
}

contract StrangeMaths {
    // First method for consuming the library we created
    // using the library name and the '.' notation
    function multiplyWithFactor(int num) public pure returns(int) {
        return WierdMaths.applyFactor(num);
    }

    // Second method using the 'using' keyword and the '.' notation
    using WierdMaths for int;
    function addTwoNums(int num1, int num2) public pure returns(int) {
        return num1.add(num2);
    }
}