// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    uint256 internal tokenId;
    string constant TOKEN_URI = "https://ipfs.io/ipfs/QmTxEyXaehnU3MMzRB2Coazobvc3fQUtCpsdX49i9R2Qa7";

    constructor() ERC721("JustUzair", "JustUzair") Ownable(msg.sender) {}

    function mint(address to) public onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, TOKEN_URI);
        tokenId++;
    }
}
