//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract EncodeDecode {
    function encode(
        uint x, 
        address addr, 
        uint[] calldata arr
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr);
    }

    function decode (bytes calldata bytesData)
        external
        pure
        returns (
            uint x,
            address addr,
            uint[] memory arr
        ) {
            (x, addr, arr) = abi.decode(bytesData, (uint, address, uint[]));
        }
}