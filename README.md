# DegenToken (DGN)

A Solidity smart contract implementing an ERC-20 token with a marketplace for purchasing items.

## Features

- **ERC-20 Token:** Based on OpenZeppelin's ERC-20 implementation.
- **Mint and Burn:**
  - `mint(uint256 amount)`: Mint tokens (owner only).
  - `burn(uint256 amount)`: Burn tokens (amount > 10 and within balance).
- **Marketplace:**
  - Items can be purchased using Degen Tokens.
  - Items have predefined names and prices.
- **Ownership:** Only the contract owner can mint tokens or add new items.

## Contract Overview

- **Token Name:** Degen
- **Token Symbol:** DGN
- **Initial Supply:** Defined during deployment.
- **Default Items:**
  - Tshirt (20 DGN)
  - Pants (50 DGN)
  - Underwear (100 DGN)

## Functions

### Token Management
- `mint(uint256 amount)`: Mint new tokens (owner-only).
- `burn(uint256 amount)`: Burn tokens from the caller's balance.

### Marketplace
- `addItem(string memory name, uint256 price)`: Add a new item (owner-only).
- `getItem(uint256 index)`: Retrieve details of an item by index.
- `buyItem(uint256 itemIndex)`: Purchase an item by burning tokens equal to the item's price.

### Events
- `ItemPurchased(address buyer, string itemName, uint256 itemPrice)`: Emitted when an item is purchased.

## How to Use

1. **Deployment:**
   - Deploy the contract with an initial supply of tokens.
   
2. **Minting:**
   - Use `mint` to add new tokens to the owner's balance.

3. **Buying Items:**
   - Call `buyItem` with the desired item's index.
   - Ensure the caller has enough DGN balance.

4. **Burning Tokens:**
   - Use `burn` to reduce tokens from the caller's balance.

## Dependencies

- [OpenZeppelin Contracts v4.9](https://github.com/OpenZeppelin/openzeppelin-contracts)

## License

This project is licensed under the [Curt Russel Celeste](https://www.facebook.com/profile.php?id=100069766380432) License.
