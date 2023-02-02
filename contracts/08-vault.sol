// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// password = await web3.eth.getStorageAt(contract.address, 1)
interface IVault {
    function locked() external view returns (bool);

    function unlock(bytes32 password) external;
}

contract Vault {
    bool public locked;
    bytes32 private password;

    constructor(bytes32 _password) {
        locked = true;
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
            locked = false;
        }
    }
}
