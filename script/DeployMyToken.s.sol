// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract DeployMyToken is Script {
    MyToken private s_myToken;
    uint256 private constant INITIAL_SUPPLY = 1e24;

    function run() external returns (MyToken) {
        vm.startBroadcast();
        s_myToken = new MyToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return s_myToken;
    }
}
