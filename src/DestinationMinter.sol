// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {MyNFT} from "./MyNFT.sol";

contract DestinationMinter is CCIPReceiver {
    MyNFT mynft;

    error DestinationMinter__NFTMintFailed();

    event NFTMinted();

    constructor(address _router, address nftAddress) CCIPReceiver(_router) {
        mynft = MyNFT(nftAddress);
    }

    function _ccipReceive(Client.Any2EVMMessage memory message) internal override {
        (bool success,) = address(mynft).call(message.data);
        if (!success) {
            revert DestinationMinter__NFTMintFailed();
        }
        emit NFTMinted();
    }
}
