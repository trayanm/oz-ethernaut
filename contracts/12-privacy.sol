// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 0xE3F00E773ad823a2B2B0e2f8AE2c637BAc0ceC31

contract Privacy {
    // slot 0
    bool public locked = true;
    // slot 1
    uint256 public ID = block.timestamp;
    // slot 2
    uint8 private flattening = 10;
    // slot 2
    uint8 private denomination = 255;
    // slot 2
    uint16 private awkwardness = uint16(block.timestamp);
    // slot 3, slot 4, slot 5
    bytes32[3] private data;

    // await web3.eth.getStorageAt(contract.address, 5)
    // slot 5 = 0xa2ef3a22b0e98c7a3bac1137e5fe5ef4846e3123956356947d36ae26cae8f682
    // "0xa2ef3a22b0e98c7a3bac1137e5fe5ef4846e3123956356947d36ae26cae8f682".slice(0, 2 + 16 * 2)
    // 0xa2ef3a22b0e98c7a3bac1137e5fe5ef4

    constructor(bytes32[3] memory _data) {
        data = _data;
    }

    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[2]));
        locked = false;
    }

    /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}
