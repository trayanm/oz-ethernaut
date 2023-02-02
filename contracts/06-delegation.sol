// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// with provided address 0x123, connect to contract Delegation and call pwn()
// you may have to increase the gas

interface IDelegate {
    // send extra gas
    function pwn() external;
    function owner() external view returns (address);
} 

contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}