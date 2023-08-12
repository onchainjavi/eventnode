// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./NFTEdition.sol";

contract NFTEditionFactory is Ownable {

    mapping(uint256 => mapping(string => address)) public Editions; // editionID => (editionAddress => editionName)
    mapping(uint256 => address) editionOwner;
    mapping(address => bool) public Organizer;
    uint256 public editionId;

    constructor() {
        editionId = 0;
    }

    modifier onlyOrg() {
        require((Organizer[msg.sender] == true || msg.sender == owner()), "Not listed as Organizer");
        _;
    }

    event EditionCreated(
    uint256 indexed editionId,
    NFTEdition indexed editionAddress,
    address indexed organizer,
    string  name,
    uint256 price,
    uint256 maxSupply,
    string uri
    );

    function createEdition(
        string memory _name,
        uint256 _price,
        uint256 _maxSupply,
        string memory _uri
    ) external payable onlyOrg  {

        NFTEdition newEdition = new NFTEdition(
            _name,
            _price,
            _maxSupply,
            _uri
        );
        Editions[editionId][_name] = address(newEdition);
        editionOwner[editionId] = msg.sender;
        editionId += 1;

        emit EditionCreated(
            editionId,
            newEdition,
            msg.sender,
            _name,
            _price,
            _maxSupply,
            _uri
        );
    }
    function setOrganizer(address _organizer) onlyOwner public {
        Organizer[_organizer] = true;
    }
    function getEditionAddress(uint256 _id, string memory _name) public view returns(address){
        return (Editions[_id][_name]);
    }
}
//"ETHBCN", 1, 100, "ipfs://bafkreievpopzxnpzz77ebsx7dzde5eooeb77nw7gwjhyznhtxwkbh5fhga"