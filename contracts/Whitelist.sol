// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Whitelist {
    uint16 public maxWhitelistAddresses;
    uint16 public numOfWhitelistedAddresses;
    mapping(address => bool) public whitelistAddress;

    constructor(uint16 _maxWhitelistAddresses){
        maxWhitelistAddresses = _maxWhitelistAddresses;
    }

    function addAddressToWhitelist() public {
        require(!whitelistAddress[msg.sender], 'This address has been whitelisted already');
        require(numOfWhitelistedAddresses < maxWhitelistAddresses, 'Limit of whitelist reached');

        whitelistAddress[msg.sender] = true;
        numOfWhitelistedAddresses += 1;
    }
}