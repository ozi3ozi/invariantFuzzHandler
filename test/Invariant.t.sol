// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {Handler} from "test/Handler.t.sol";
import {MockContract} from "src/MockContract.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";


contract InvariantTest is Test {
    Handler handler;
    MockContract mockContract;

    function setUp() public {
        mockContract = new MockContract();
        handler = new Handler(mockContract);
        targetContract(address(handler));
    }

    /// forge-config: default.invariant.runs = 100
    /// forge-config: default.invariant.depth = 52
    /// forge-config: default.invariant.fail-on-revert = true
    function invariant_bugTest() public view {
        assertEq(
            ERC20Mock(mockContract.currTkn()).balanceOf(address(mockContract)),
            mockContract.sumDeposited(mockContract.currTkn())
        );

        // assertEq(
        //     handler.sumDepositedGhost(),
        //     mockContract.sumDeposited(mockContract.currTkn())
        // );
    }
}