// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Import OpenZeppelin's ERC20 and Ownable contracts
import "@openzeppelin/contracts@4.9/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9/access/Ownable.sol";

// DegenToken is an ERC20 token with additional functionality for a marketplace
contract DegenToken is ERC20, Ownable {
    // Structure to represent an item in the marketplace
    struct Item {
        string name; // Name of the item
        uint256 price; // Price of the item in Degen tokens
    }

    // Array to store all available items in the marketplace
    Item[] public items;

    // Event emitted when an item is purchased
    event ItemPurchased(address indexed buyer, string itemName, uint256 itemPrice);

    // Constructor to initialize the token and create default items
    constructor(uint256 initialSupply) ERC20("Degen", "DGN") {
        // Mint the initial supply of tokens to the contract deployer
        _mint(msg.sender, initialSupply);

        // Add default items to the marketplace
        addItem("Tshirt", 20); // Item at index 0
        addItem("Pants", 50);  // Item at index 1
        addItem("Underwear", 100); // Item at index 2
    }

    // Internal function to add a new item to the marketplace (only callable by the owner)
    function addItem(string memory name, uint256 price) internal onlyOwner {
        items.push(Item(name, price)); // Add the item to the items array
    }

    // Public function to retrieve details of an item by index
    function getItem(uint256 index) public view returns (string memory name, uint256 price) {
        require(index < items.length, "Item index out of bounds"); // Ensure index is valid
        Item storage item = items[index];
        return (item.name, item.price);
    }

    // Function to mint additional tokens (only callable by the owner)
    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    // Function to burn tokens from the caller's balance
    function burn(uint256 amount) public {
        require(amount > 10, "Amount should be greater than 10"); // Ensure minimum burn amount
        require(amount <= balanceOf(msg.sender), "Insufficient balance to burn"); // Check balance
        _burn(msg.sender, amount); // Burn the tokens
    }

    // Function to purchase an item using Degen tokens
    function buyItem(uint256 itemIndex) public {
        require(itemIndex < items.length, "Item index out of bounds"); // Ensure index is valid
        Item storage item = items[itemIndex];
        require(balanceOf(msg.sender) >= item.price, "Insufficient balance to buy item"); // Check balance

        // Burn the tokens equal to the item's price
        _burn(msg.sender, item.price);

        // Emit an event for the purchase
        emit ItemPurchased(msg.sender, item.name, item.price);
    }

    // Override the transfer function to allow token transfers between users
    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }
}
