// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    struct Item {
        string name;
        uint256 price;
    }

    Item[] public items;

    event ItemPurchased(address indexed buyer, string itemName, uint256 itemPrice);

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") {
        _mint(msg.sender, initialSupply);

        addItem("Tshirt", 20); //index 0 
        addItem("Pants", 50);//index 1  
        addItem("Underwear", 100); //index 2
    }

    function addItem(string memory name, uint256 price) internal onlyOwner {
        items.push(Item(name, price));
    }

    function getItem(uint256 index) public view returns (string memory name, uint256 price) {
        require(index < items.length, "Item index out of bounds");
        Item storage item = items[index];
        return (item.name, item.price);
    }

    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    function burn(uint256 amount) public {
        require(amount > 10, "Amount should be greater than 10");
        require(amount <= balanceOf(msg.sender), "Insufficient balance to burn");
        _burn(msg.sender, amount);
    }

    function buyItem(uint256 itemIndex) public {
        require(itemIndex < items.length, "Item index out of bounds");
        Item storage item = items[itemIndex];
        require(balanceOf(msg.sender) >= item.price, "Insufficient balance to buy item");
        _burn(msg.sender, item.price);
        emit ItemPurchased(msg.sender, item.name, item.price);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }
}