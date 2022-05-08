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

    uint _price;

    bool isPreSale;
    bool paused;

    string public baseURI;
    string public baseExtension = ".json";

    Counters.Counter private _tokenIds;

    uint[] private _teamShares = [33, 33, 34];

    address[] private _team = [
        0x594DB4be0477A6835AA2608119eA5Dd6F45F1C94,
        0x594DB4be0477A6835AA2608119eA5Dd6F45F1C94,
        0x594DB4be0477A6835AA2608119eA5Dd6F45F1C94
    ]; 

    constructor(string memory _name, string memory _symbol, string memory _baseUri)
        ERC721(_name, _symbol)
        PaymentSplitter(_team, _teamShares)
        ReentrancyGuard()
    {
        setBaseURI(_baseUri);
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

    // @dev Minting function during public sales
    function publicSaleMint(uint _amount) external payable onlyAccounts
    {
        require(isPreSale, "NFTeamWestCoast: PublicSale is OFF");
        require(!paused, "NFTeamWestCoast: Contract is paused");
        require(_amount > 0, "NFTeamWestCoast: zero amount");

        uint current = _tokenIds.current();

        require(current + _amount <= maxSupply, "NFTeamWestCoast: Max supply exceeded");
        require(_price * _amount <= msg.value, "NFTeamWestCoast: Not enough ethers sent");
        
        for (uint i = 0; i < _amount; i++) {
            mintInternal();
        }
    }
 
    // @dev Simple internal minting function
    function mintInternal() internal nonReentrant {
        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();
        _safeMint(msg.sender, tokenId);
    }

    function totalSupply() public view  returns(uint) {
        return _tokenIds.current();
    }

}