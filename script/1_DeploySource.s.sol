// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";

import {SourceMinter} from "../src/SourceMinter.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {console} from "forge-std/console.sol";

contract DeploySource is Script {
    address user = makeAddr("user");

    SourceMinter source;

    function run() public {
        HelperConfig helperConfig = new HelperConfig();

        (uint256 deployerKey, address linkTokenAddress, address routerAddress,) = helperConfig.activeNetworkConfig();
        vm.startBroadcast(deployerKey);
        source = new SourceMinter(routerAddress, linkTokenAddress);
        vm.stopBroadcast();
    }
}
