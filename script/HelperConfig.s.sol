// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
// Refer to CCIP Testnet docs here : https://docs.chain.link/ccip/supported-networks/v1_2_0/testnet

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    struct NetworkConfig {
        uint256 deployerKey;
        address linkTokenAddress;
        address routerAddress;
        uint64 chainSelectorId;
    }

    NetworkConfig public activeNetworkConfig;
    // uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    constructor() {
        if (block.chainid == 80001) {
            activeNetworkConfig = getPolygonMumbaiConfig();
        } else if (block.chainid == 43113) {
            activeNetworkConfig = getAvalancheFujiTestnetConfig();
        } else if (block.chainid == 420) {
            activeNetworkConfig = getOptimismGoerliTestnetConfig();
        } else if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaTestnetConfig();
        } else if (block.chainid == 421614) {
            activeNetworkConfig = getArbitrumSepoliaTestnetConfig();
        }
    }

    function getPolygonMumbaiConfig() public view returns (NetworkConfig memory polygonMumbaiNetworkConfig) {
        polygonMumbaiNetworkConfig = NetworkConfig({
            deployerKey: vm.envUint("PRIVATE_KEY"),
            linkTokenAddress: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB,
            routerAddress: 0x1035CabC275068e0F4b745A29CEDf38E13aF41b1,
            chainSelectorId: 12532609583862916517
        });
    }

    function getAvalancheFujiTestnetConfig() public view returns (NetworkConfig memory avalancheFujiTestnetConfig) {
        avalancheFujiTestnetConfig = NetworkConfig({
            deployerKey: vm.envUint("PRIVATE_KEY"),
            linkTokenAddress: 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846,
            routerAddress: 0xF694E193200268f9a4868e4Aa017A0118C9a8177,
            chainSelectorId: 14767482510784806043
        });
    }

    function getSepoliaTestnetConfig() public view returns (NetworkConfig memory sepoliaTestnetConfig) {
        sepoliaTestnetConfig = NetworkConfig({
            deployerKey: vm.envUint("PRIVATE_KEY"),
            linkTokenAddress: 0x779877A7B0D9E8603169DdbD7836e478b4624789,
            routerAddress: 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59,
            chainSelectorId: 16015286601757825753
        });
    }

    function getOptimismGoerliTestnetConfig() public view returns (NetworkConfig memory optimismGoerliTestnetConfig) {
        optimismGoerliTestnetConfig = NetworkConfig({
            deployerKey: vm.envUint("PRIVATE_KEY"),
            linkTokenAddress: 0xdc2CC710e42857672E7907CF474a69B63B93089f,
            routerAddress: 0xcc5a0B910D9E9504A7561934bed294c51285a78D,
            chainSelectorId: 2664363617261496610
        });
    }

    function getArbitrumSepoliaTestnetConfig()
        public
        view
        returns (NetworkConfig memory arbitrumSepoliaTestnetConfig)
    {
        arbitrumSepoliaTestnetConfig = NetworkConfig({
            deployerKey: vm.envUint("PRIVATE_KEY"),
            linkTokenAddress: 0xb1D4538B4571d411F07960EF2838Ce337FE1E80E,
            routerAddress: 0x2a9C5afB0d0e4BAb2BCdaE109EC4b0c4Be15a165,
            chainSelectorId: 3478487238524512106
        });
    }
}
