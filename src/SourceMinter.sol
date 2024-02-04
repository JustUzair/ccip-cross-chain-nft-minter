// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {LinkTokenInterface} from "./utils/LinkTokenInterface.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {Withdraw} from "./utils/Withdraw.sol";

contract SourceMinter is Withdraw {
    enum PayFeesIn {
        Native,
        LINK
    }

    error NotEnoughBalance(uint256 currentBalance, uint256 calculatedFees); // Used to make sure contract has enough balance to cover the fees.
    error NothingToWithdraw(); // Used when trying to withdraw Ether but there's nothing to withdraw.
    error FailedToWithdrawEth(address owner, address target, uint256 value); // Used when the withdrawal of Ether fails.
    error DestinationChainNotAllowlisted(uint64 destinationChainSelector); // Used when the destination chain has not been allowlisted by the contract owner.

    event TokensTransferred(bytes32 indexed messageId, uint64 indexed destinationChainSelector);

    ///////////////////////////////
    //////// State Variables //////
    ///////////////////////////////
    IRouterClient immutable i_router;
    LinkTokenInterface immutable i_link;
    mapping(uint64 chain => bool isValid) whiteListedChain;

    constructor(address _router, address _linkToken) {
        i_router = IRouterClient(_router);
        i_link = LinkTokenInterface(_linkToken);

        LinkTokenInterface(i_link).approve(address(i_router), type(uint256).max);
    }

    modifier allowOnlyWhiteListedChain(uint64 _destinationChainSelector) {
        if (!whiteListedChain[_destinationChainSelector]) {
            revert DestinationChainNotAllowlisted(_destinationChainSelector);
        }
        _;
    }

    function allowlistDestinationChain(uint64 _destinationChainSelector, bool allowed) external onlyOwner {
        whiteListedChain[_destinationChainSelector] = allowed;
    }

    function mint(uint64 destinationChainSelector, address receiver, PayFeesIn payFeesIn) external {
        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({
            receiver: abi.encode(receiver),
            data: abi.encodeWithSignature("mint(address)", msg.sender),
            tokenAmounts: new Client.EVMTokenAmount[](0),
            feeToken: payFeesIn == PayFeesIn.Native ? address(0) : address(i_link),
            extraArgs: ""
        });
        // get fee required for cross-chain transfer
        uint256 fees = IRouterClient(i_router).getFee(destinationChainSelector, message);

        // check if we have enough balance to cover the fees
        if (fees > address(this).balance) {
            revert NotEnoughBalance(address(this).balance, fees);
        }
        // approve funds to router for transfer
        bytes32 messageId;
        if (payFeesIn == PayFeesIn.LINK) {
            messageId = IRouterClient(i_router).ccipSend(destinationChainSelector, message);
        } else {
            // paying fee in native currency
            messageId = IRouterClient(i_router).ccipSend{value: fees}(destinationChainSelector, message);
        }

        emit TokensTransferred(messageId, destinationChainSelector);
    }

    receive() external payable {}
}
