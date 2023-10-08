// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";

contract AgentsNFT is ERC721Enumerable, Ownable {
    Whitelist whitelist;

    uint256 constant public _price = 0.01 ether;
    uint256 constant public maxTokenIds = 100;
    uint256 public reservedTokens;
    uint256 public reservedTokensClaimed = 0;

    constructor(address whitelistContract) ERC721("Agents", "AI") Ownable(msg.sender){
        whitelist = Whitelist(whitelistContract);
        reservedTokens = whitelist.maxWhitelistAddresses();
    }

    function mint() public payable {
        require(totalSupply() + reservedTokens - reservedTokensClaimed < maxTokenIds, "EXCEEDED_MAX_SUPPLY");

        if(whitelist.whitelistAddress(msg.sender) && msg.value < _price){
            require(balanceOf(msg.sender) == 0, "NFT OWNED ALREADY");
            reservedTokensClaimed += 1;
        } else {
            require(msg.value >= _price, "NOT_ENOUGH_ETHER");
        }
        uint256 tokenId = totalSupply();
        _safeMint(msg.sender, tokenId);
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}