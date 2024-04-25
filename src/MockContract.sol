// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract MockContract {
    mapping (address token => uint256 sumDeposited) public sumDeposited; 
    address public currTkn;

    function increaseBalance(uint96 _value, address _token) public {
        sumDeposited[_token] += _value;
        currTkn = _token;

        ERC20Mock(_token).transferFrom(msg.sender, address(this), _value);
    }
}