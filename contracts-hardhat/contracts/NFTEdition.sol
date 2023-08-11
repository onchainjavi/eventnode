// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// tengo un struct prototypo Edition
// tengo un mapping de id => Edition
// incicializo una struct Edition llamada edition con los datos introducidos en el constructor

contract NFTEdition is ERC1155, Ownable {
    struct Edition {
        string name;
        uint256 price;
        uint256 maxSupply;
        uint256 currentSupply;
        string uri;
    }

    mapping(uint256 => Edition) public editions;
    uint256 public nextEditionId;

    constructor(
        string memory _name,
        uint256 _priceInEther, // Accept the price in Ether
        uint256 _maxSupply,
        string memory _uri
    ) ERC1155(_uri) {
        nextEditionId = 1;


        editions[nextEditionId] = Edition({
            name: _name,
            price: _priceInEther, // * 1 ether,
            maxSupply: _maxSupply,
            currentSupply: 0,
            uri: _uri
        });
    }

    //Edition public edition = editions[nextEditionId];

    function mint(uint256 id, uint256 amount) public payable {
        require(editions[id].currentSupply + amount <= editions[id].maxSupply, "Exceeded max supply");
        require(msg.value == editions[id].price * amount, "Insufficient payment");

        editions[id].currentSupply += amount;
        _mint(msg.sender, id, amount, new bytes(0));
    }

    function getCircSupply(uint256 id) public view returns(uint256) {
        return(editions[id].currentSupply);
    }
}

//"ETHBCN", 1, 100, "ipfs://bafkreidwanm5ltxxnlurkoikqirraxotyzi3fxlc4363xwunp7ph25mwbq"

/*JavaSript Unix timestamp conversion

// Example JavaScript code to convert Unix timestamp to human-readable date and time

// Unix timestamp in seconds
const unixTimestamp = 1678934400; // Replace with your timestamp

// Create a new JavaScript Date object using the Unix timestamp (convert to milliseconds)
const date = new Date(unixTimestamp * 1000);

// Extract various components of the date
const year = date.getFullYear();
const month = date.getMonth() + 1; // Months are zero-indexed
const day = date.getDate();
const hours = date.getHours();
const minutes = date.getMinutes();
const seconds = date.getSeconds();

// Create a formatted string for the date and time
const formattedDateTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

console.log(formattedDateTime);
*/