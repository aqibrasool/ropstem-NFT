// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract Ropstam is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    uint256 currentToken = 0;
uint256 public mintRate = 0.01 ether;
uint256 public Max_Supply = 1000;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("ropstam", "ROP") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://www.api.mynft/tokens";
    }

    function safeMint(address to) public payable{
require(totalSupply()<Max_Supply,"you cant mint more");
require(msg.value>=mintRate,"not enough eth");
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    function  withdraw() public onlyOwner{
    require(address(this).balance > 0,"not enough balance");
        payable(owner()).transfer(address(this).balance);
    }
}
