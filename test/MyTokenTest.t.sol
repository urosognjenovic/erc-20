// SDPX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {DeployMyToken} from "../script/DeployMyToken.s.sol";

contract MyTokenTest is Test {
    DeployMyToken private s_deployer;
    MyToken private s_myToken;

    address bob = makeAddr("Bob");
    address alice = makeAddr("Alice");

    uint256 private constant STARTING_BALANCE = 100e18;
    uint256 private constant INITIAL_ALLOWANCE = 10e18;

    function setUp() external {
        s_deployer = new DeployMyToken();
        s_myToken = s_deployer.run();

        vm.startPrank(msg.sender);
        s_myToken.transfer(bob, STARTING_BALANCE);
        s_myToken.transfer(alice, STARTING_BALANCE);
        vm.stopPrank();
    }

    function testBobBalance() external view {
        assertEq(s_myToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowancesAndTransfer() external {
        vm.prank(alice);
        s_myToken.approve(bob, INITIAL_ALLOWANCE);
        assertEq(INITIAL_ALLOWANCE, s_myToken.allowance(alice, bob));
        vm.prank(bob);
        s_myToken.transferFrom(alice, bob, INITIAL_ALLOWANCE);
        assertEq(
            s_myToken.balanceOf(alice),
            STARTING_BALANCE - INITIAL_ALLOWANCE
        );
        assertEq(
            s_myToken.balanceOf(bob),
            STARTING_BALANCE + INITIAL_ALLOWANCE
        );
    }
}
