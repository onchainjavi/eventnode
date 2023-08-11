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

    event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256[] ids, uint256[] values);

    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    event ApprovalForAll(address indexed account, address indexed operator, bool approved);

    constructor(string memory _name, string memory _symbol) {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        nextTokenIdToMint = 0;
    }

    function balanceOf(address _owner, uint256 _tokenId) public view returns(uint256) {
        require(_owner != address(0), "Not valid Address");
        return _balances [_tokenId][_owner];
    }

    function setApprovalForAll(address _operator, bool _approved) public {
        _operatorApprovals[msg.sender][_operator] = _approved;
    }
    
}
