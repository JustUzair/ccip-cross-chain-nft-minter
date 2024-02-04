// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {OwnerIsCreator} from "@chainlink/contracts/src/v0.8/shared/access/OwnerIsCreator.sol";
import {IERC20} from
    "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.0/contracts/token/ERC20/IERC20.sol";

contract Withdraw is OwnerIsCreator {
    error Withdraw__FailedToWithdraw(address owner, address target, uint256 value);

    function withdraw(address beneficiary) public onlyOwner {
        uint256 amount = address(this).balance;
        (bool success,) = beneficiary.call{value: amount}("");
        if (!success) {
            revert Withdraw__FailedToWithdraw(msg.sender, beneficiary, amount);
        }
    }

    function withdraw_Token(address beneficiary, address token) public onlyOwner {
        uint256 amount = IERC20(token).balanceOf(address(this));
        require(amount > 0, "not enough balance");
        IERC20(token).transfer(beneficiary, amount);
    }
}
