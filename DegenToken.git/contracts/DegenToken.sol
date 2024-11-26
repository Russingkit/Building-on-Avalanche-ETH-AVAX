// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Importing OpenZeppelin's ERC20 standard contract, Ownable for access control, and ERC20Burnable for burn functionality
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

// DegenToken is an ERC20 token with custom features for a marketplace
contract DegenToken is ERC20, Ownable, ERC20Burnable {
    // Constructor to initialize the token name as "Degen" and symbol as "DGN"
    constructor() ERC20("Degen", "DGN") {}

    // Function to mint new tokens; restricted to the owner
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount); // Calls the internal _mint function to create tokens
    }

    // Override to set token decimals to 0 (no fractional units)
    function decimals() override public pure returns (uint8) {
        return 0; // DegenToken will not allow fractional values
    }

    // Function to get the balance of the caller
    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender); // Returns balance of the caller's address
    }

    // Function to transfer tokens to a receiver
    function transferTokens(address _receiver, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Not enough DGN Tokens"); // Ensure sender has sufficient balance
        approve(msg.sender, _value); // Approve the transaction
        transferFrom(msg.sender, _receiver, _value); // Execute transfer
    }

    // Function to burn tokens from the caller's balance
    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Not enough DGN"); // Ensure caller has enough tokens to burn
        burn(_value); // Burn the specified amount
    }

    // Function to redeem tokens for rewards based on input
    function redeemTokens(uint8 input) external payable returns (bool) {
        if (input == 1) {
            // Case 1: Redeem 10 tokens for Degen Merch (Catizens partnership)
            require(this.balanceOf(msg.sender) >= 10, "Not enough DGN Tokens"); // Check token balance
            approve(msg.sender, 10); // Approve the token transfer
            console.log("Degen Merch with Partnership with Catizens's [Redeemed]!"); // Log success message
            return true;
        } else if (input == 2) {
            // Case 2: Redeem 5 tokens for Degen Merch (Telegram Games collaboration)
            require(this.balanceOf(msg.sender) >= 5, "You do not have enough Degen Tokens"); // Check token balance
            approve(msg.sender, 5); // Approve the token transfer
            transferFrom(msg.sender, owner(), 5); // Transfer tokens to the contract owner
            console.log("Degen Merch with Collaboration with Telegram Games [Redeemed]!"); // Log success message
            return true;
        } else {
            // Invalid input
            console.log("That is not a valid choice"); // Log invalid input message
            return true; // Return true but no redemption happens
        }
    }
}
