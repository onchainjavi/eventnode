// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol"; //ownable, Clones
import "./NFTEdition.sol";

contract NFTEditionFactory {
    address public owner;
    address[] public deployedEditions; //mejor mapping
    mapping(uint256 => mapping(string => address)) public Editions; // editionID => (editionAddress => editionName)
    uint256 public editionId;

    constructor() {
        owner = msg.sender;
        editionId = 0;
    }

    function createEdition(
        string memory _name,
        uint256 _price,
        uint256 _maxSupply,
        string memory _uri
    ) external payable {
        require(msg.sender == owner, "Only owner can create editions");

        NFTEdition newEdition = new NFTEdition(
            _name,
            _price,
            _maxSupply,
            _uri
        );
        editionId += 1;
        Editions[editionId][_name] = address(newEdition);
        deployedEditions.push(address(newEdition)); //no necesario -> mapping
    }

    function getEditionAddress(uint256 _id, string memory _name) public view returns(address){
        return (Editions[_id][_name]);
    }
}
//"ETHBCN", 1, 100, "ipfs://bafkreievpopzxnpzz77ebsx7dzde5eooeb77nw7gwjhyznhtxwkbh5fhga"