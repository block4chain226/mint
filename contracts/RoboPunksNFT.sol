//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract RoboPunksNFT is ERC721, Ownable{
uint public mintPrice;
uint public totalSupply;
uint public maxSupply;
uint public maxPerWallet;
bool public isPublicMintEnabled;
string internal baseTokenUri;
address payable public withdrawWallet;
mapping(address=>uint) walletMints;

constructor() payable ERC721("RoboPunksNFT", "RBP"){
mintPrice=0.02 ether;
totalSupply = 0;
maxSupply = 1000;
maxPerWallet = 3 ;
}

function setIsPublicMintEnabled(bool isPublicMintEnabled_) external onlyOwner {
isPublicMintEnabled=isPublicMintEnabled_;
}

function setBaseTokenUri(string calldata baseTokenUri_) external onlyOwner{
baseTokenUri=baseTokenUri_;
}

function tokenURI(uint tokenId_) public view override returns( string memory){
    require(_exists(tokenId_), "Token does not exist!");
    return string(abi.encodePacked(baseTokenUri, Strings.toString(tokenId_), ".json"));
}

function withdraw() external onlyOwner{
    withdrawWallet.transfer(address(this).balance);
}
}

