// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Whitelist {
    /// @dev total number of whitelist slots available
    uint16 public maxWhitelistAddresses;
    uint16 public numOfWhitelistedAddresses;

    /// @dev keep track of addresses in whitelist
    mapping(address => bool) public whitelistAddress;

    constructor(uint16 _maxWhitelistAddresses){
        maxWhitelistAddresses = _maxWhitelistAddresses;
    }

    /// @dev addAddressToWhitelist() adds the caller's address to the whitelist
    function addAddressToWhitelist() public {
        require(!whitelistAddress[msg.sender], 'This address has been whitelisted already');
        require(numOfWhitelistedAddresses < maxWhitelistAddresses, 'Limit of whitelist reached');

        whitelistAddress[msg.sender] = true;
        numOfWhitelistedAddresses += 1;
    }
}