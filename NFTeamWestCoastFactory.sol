// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import "./NFTeamWestCoast.sol";

// @author TeamWestCoast
contract NFTeamWestCoastFactory {

    NFTeamWestCoast[] private collection;

    mapping(address => address[]) private collectionsByArtist; // An artist can create multiple NFT collections

    // @dev Factory to create NFT smart contract
    function createNFTCollection(string memory _artistName, string memory _artistSymbol, string memory _baseUri) external {
        NFTeamWestCoast nft = new NFTeamWestCoast(_artistName, _artistSymbol, _baseUri);
        collection.push(nft);
    }

    // @dev Get the collection
    function getCollection() public view returns(NFTeamWestCoast[] memory) {
        return collection;
    }

    // @dev Get the collections by artist
    function getCollectionsByArtist(address _address) public view returns(address[] memory) {
        return collectionsByArtist[_address];
    }
}