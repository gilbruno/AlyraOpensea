// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import "./node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "./node_modules/@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./node_modules/@openzeppelin/contracts/finance/PaymentSplitter.sol";
import "./node_modules/@openzeppelin/contracts/utils/Counters.sol";

// @author TeamWestCoast
contract NFTeamWestCoast is ERC721, Ownable, ReentrancyGuard, PaymentSplitter {

    using Counters for Counters.Counter;

    uint public maxSupply;

    string public baseURI;
    string public baseExtension = ".json";

    Counters.Counter private _tokenIds;

    uint[] private _teamShares = [33, 33, 34];

    address[] private _team = [
        0x594DB4be0477A6835AA2608119eA5Dd6F45F1C94,
        0x594DB4be0477A6835AA2608119eA5Dd6F45F1C94,
        0x594DB4be0477A6835AA2608119eA5Dd6F45F1C94
    ]; 

    constructor(string memory _baseURI) 
        ERC721("NFTeamWestCoast", "TWC")
        PaymentSplitter(_team, _teamShares)
        ReentrancyGuard()
    {
        setBaseURI(_baseURI);
    }

    // @dev The msg.sensder must be the first one who called the function
    modifier onlyAccounts() {
        require(msg.sender == tx.origin, "Not allowed origin of the call");
        _;
    }

    // @dev set state variable base URI : Can be set after deploy the contract in case of URI error
    function setBaseURI(string memory _uri) public onlyOwner
    {
        baseURI = _uri;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

 


}