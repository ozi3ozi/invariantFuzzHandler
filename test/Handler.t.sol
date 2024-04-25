// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {MockContract} from "src/MockContract.sol";
import {Handler} from "test/Handler.t.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract Handler is Test {
    MockContract public mockContract;

    uint256 public constant STARTING_BALANCE = 2500000000000 ether;
    address public USER = makeAddr("user");

    ERC20Mock public weth;
    uint256 public sumDepositedGhost;

    constructor(MockContract _mockContract) {
        mockContract = _mockContract;
        weth = new ERC20Mock();
    }

    function deposit(uint96 _value) public {
        vm.startPrank(USER);
        ERC20Mock(weth).mint(USER, STARTING_BALANCE);
        ERC20Mock(weth).approve(address(mockContract), STARTING_BALANCE);

        _value = uint24(bound(_value, 0, 20 ether));
        mockContract.increaseBalance(_value, address(weth));
        sumDepositedGhost += _value;
        
        vm.stopPrank();

        assertEq(
            ERC20Mock(mockContract.currTkn()).balanceOf(address(mockContract)),
            mockContract.sumDeposited(mockContract.currTkn())
        );

        console.log(string(bytes(
            abi.encodePacked("sumDepositedGhost: ", sumDepositedGhost))));
    }
}