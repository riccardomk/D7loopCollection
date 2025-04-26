// Copyright (c) 2025 Riccardo D7
// 
// This smart contract is provided under the MIT License. You are free to use, modify, 
// and distribute this software as long as the original copyright and license notice 
// are included. See the LICENSE file for more details.
//
// Author: Riccardo D7
// Project: D7LoopNFT

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/////////////////////////////////////////////////////////////////////////////////////////////////////////

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract D7LoopNFT is ERC721URIStorage, Ownable, IERC2981 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    uint256 public royaltyFee = 750; // 7.5% royalty (750 = 7.5%)
    address payable public royaltyRecipient;

    constructor() ERC721("D7Loop", "D7L") Ownable(msg.sender) {
        royaltyRecipient = payable(0x707F439a5e49C742fF35e9335d87aff8805636d0);
    }

    function setRoyaltyRecipient(address payable newRecipient) external onlyOwner {
        royaltyRecipient = newRecipient;
    }

    function mintNFT(uint256 tokenId, string memory tokenURI) public onlyOwner {
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenIdCounter.increment();
    }

    function mintNFTs() public onlyOwner {
        string[15] memory tokenURIs = [
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreibt2hkqkir6dhuzr4yoyhtwhh67itqwjxjch37erch2ny3kgfoqpy", // DNA FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreialo7fdcof5su6adreu2ar7ylxdj6u5bzmusl3je2ncyceeurrhmi", // EyeOfHorus FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreiaaojtu224kpcsqe6suxwz7cq2rnhhlsuhayz7m2533vh44fu77ey", // Eyes FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreibsqramuprncanjvrlhdxzc4o7e2l7mnkibeyt3dwn3u7ueza46ee", // FlowerOfLife FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreigoucd6uv3pu3m3vbzuy4zhlk2ez63u6ssasg46cj6zrrmoeneu2i", // Infinity FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreic7axz6fk4iasn6hyqy7tfsijrf2lwicvxhtvcreo5qrrk75fy5gi", // LandBreath FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreihlmh2n5kh3kekjn6mpoc3uy4rdb6ie56gl7rxcxrwrr7horysbsy", // LifeKey FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreiepux6inevsvp33mkx52gaqcx62ulije3zkotlhyiuuo34e6tkiby", // LunarCycle FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreiexq2g4wswqcwzzun7jeldghrx4ogufxrewahhb2uwkkjqssod5a4", // Pgrego FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreibuchbr556rnh2dnghqhmfwepha25leoyr24ytjov2dswvz2tmr64", // PointZero FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreicl7jnskr2dqbksaeduvsjgfdk4ljvpbzixllwd5rpbja6fu645nm", // PowerRain FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreiciyyg3trnc4lf432z56xf3lvwld4r2yv7ywcjxr24hzlibruf5vm", // Spirale FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreigrjoh2krau2cw4o6j4x66wls5ktj3jksfhuflcolxnjcvaiwagem", // Stair FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreiffvhxfwtjipfjkwflduxnqqg6qvq2cfmkdkvtnjh6txtt2dpjvda", // TimeLine FILE JSON
            "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreihqbrrebmhrniuwao5vwz2v7snea4i5thnryhjlrwsn7backyt6r4"  // Yin-Yang FILE JSON
        ];

        for (uint256 i = 0; i < tokenURIs.length; i++) {
            mintNFT(i, tokenURIs[i]);
        }
    }

    function mintNewNFT(uint256 tokenId, string memory tokenURI) public onlyOwner {
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenIdCounter.increment();
    }

    function mintBatchNFTs(uint256[] memory tokenIds, string[] memory tokenURIs) public onlyOwner {
        require(tokenIds.length == tokenURIs.length, "Token IDs and URIs length mismatch");
        for (uint256 i = 0; i < tokenIds.length; i++) {
            _safeMint(msg.sender, tokenIds[i]);
            _setTokenURI(tokenIds[i], tokenURIs[i]);
            _tokenIdCounter.increment();
        }
    }

    function royaltyInfo(uint256, uint256 salePrice) external view override returns (address receiver, uint256 royaltyAmount) {
        royaltyAmount = (salePrice * royaltyFee) / 10000; // 7.5% royalty
        receiver = royaltyRecipient;
    }

    string public collectionDocumentationURL = "https://scarlet-bright-catfish-118.mypinata.cloud/ipfs/bafkreidpdsp66ms2lroebqn4hq444fttnkpbqfumy6vcemkh4uqisfwov4";

    function setCollectionDocumentation(string memory url) external onlyOwner {
        collectionDocumentationURL = url;
    }
}
