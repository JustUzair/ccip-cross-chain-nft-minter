// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MyNFT} from "../src/MyNFT.sol";
import {DestinationMinter} from "../src/DestinationMinter.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {console} from "forge-std/console.sol";

contract DeployDestinationMinterAndNFT is Script {
    address user = makeAddr("user");
    MyNFT mynft;
    DestinationMinter destination;

    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        (uint256 deployerKey,, address routerAddress,) = helperConfig.activeNetworkConfig();
        vm.startBroadcast(deployerKey);
        mynft = new MyNFT();
        console.log("mynft address : ", address(mynft));
        destination = new DestinationMinter(routerAddress, address(mynft));
        console.log("destination address : ", address(destination));

        mynft.transferOwnership(address(destination));

        vm.stopBroadcast();
    }
}
