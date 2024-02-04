// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MyNFT} from "../src/MyNFT.sol";
import {SourceMinter} from "../src/SourceMinter.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {console} from "forge-std/console.sol";

contract MintNFtUsingSource is Script {
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////// Deployed Address from 1_DeploySource.sol - 0x232B510Ea4105ed6B036677c82cfC65d9D209792 ///////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////

    address user = makeAddr("user");
    MyNFT mynft;
    SourceMinter source;

    function run() public {
        HelperConfig helperConfig = new HelperConfig();

        (uint256 deployerKey,,,) = helperConfig.activeNetworkConfig();
        vm.startBroadcast(deployerKey);
        source = SourceMinter(payable(0x232B510Ea4105ed6B036677c82cfC65d9D209792));
        console.log("balance of source minter : ", address(source).balance);

        // chainSelectorId: 12532609583862916517 for polygon
        // uint64 destinationChainSelector, address receiver, PayFeesIn payFeesIn
        // 0x56964A98b0407BbFCAD796CB2a76d618Bc89Eadc is address of destination minter
        source.mint(
            12532609583862916517, address(0x56964A98b0407BbFCAD796CB2a76d618Bc89Eadc), SourceMinter.PayFeesIn(0)
        );

        vm.stopBroadcast();
    }
}
