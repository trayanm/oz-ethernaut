pragma solidity ^0.8;

// old type of constructors in solidity 0.6
// the name of contract is Fallout but the method Fal1out is not constructor (not symbol 1) - it is just a function
interface IFallout {
    function owner() external view returns (address);
    // call this function
    function Fal1out() external payable;
}
