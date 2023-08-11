//SPDX-License_identifier: MIT
pragma solidity ^0.8.9;

contract ERC1155 {
    // token id => (address => balance) how much of this token has this address
    mapping(uint256 => mapping(address => uint256)) internal _balances;
    // owner => (operator => yes/no) owners operator's
    mapping(address => mapping(address => bool)) internal _operatorApprovals;
    //token id => token uri (upload to IPFS to get the uri)
    mapping(uint256 => string) internal _tokenUris;
    // token id => supply - supply for a given id
    mapping(uint256 => uint256) public totalSupply;

    uint256 public nextTokenIdToMint;
    string public name;
    string public symbol;
    address public owner;

    
}
