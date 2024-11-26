# DegenToken

DegenToken is a custom ERC20 token implemented using Solidity. It incorporates features such as token minting, burning, transfer, and redemption for marketplace rewards. Built on OpenZeppelin's standard libraries, the token is designed with custom functionalities suitable for marketplaces or gamified ecosystems.

## Features

- **Minting**: Tokens can be minted by the contract owner.
- **Burning**: Users can burn their tokens to reduce the total supply.
- **Custom Decimals**: Token operates without fractional units (0 decimals).
- **Transfer**: Users can transfer tokens securely between accounts.
- **Redemption**: Users can redeem tokens for rewards (e.g., merchandise or in-game items).

## Prerequisites

- Solidity `^0.8.9`
- OpenZeppelin Contracts
- Hardhat for local development and testing

## Installation

1. Clone the repository.
2. Install dependencies:
   ```bash
   npm install
   ```
3. Compile the contract:
   ```bash
   npx hardhat compile
   ```

## Contract Overview

### Constructor
- Initializes the token with:
  - **Name**: `Degen`
  - **Symbol**: `DGN`
- Sets the token owner.

### Functions

1. **Mint Tokens**
   - Allows the contract owner to mint tokens.
   - ```solidity
     function mint(address to, uint256 amount) public onlyOwner
     ```

2. **Burn Tokens**
   - Enables users to burn their own tokens.
   - ```solidity
     function burnTokens(uint256 _value) external
     ```

3. **Transfer Tokens**
   - Allows users to transfer tokens to another address.
   - ```solidity
     function transferTokens(address _receiver, uint256 _value) external
     ```

4. **Redeem Tokens**
   - Users can redeem tokens for rewards:
     - 10 tokens: Redeem merchandise from Catizens partnership.
     - 5 tokens: Redeem merchandise from Telegram Games collaboration.
   - ```solidity
     function redeemTokens(uint8 input) external payable returns (bool)
     ```

5. **Get Balance**
   - Retrieves the token balance of the caller.
   - ```solidity
     function getBalance() external view returns (uint256)
     ```

### Customization

- **Decimals**: The token uses 0 decimals for simplicity.
- **Reward System**: Tokens can be redeemed for different rewards based on pre-defined input.

## Usage

1. Deploy the contract using Hardhat or Remix.
2. Mint tokens using the `mint` function (owner only).
3. Users can transfer, redeem, or burn tokens based on their balance.

## Example Workflow

1. **Minting Tokens**
   ```solidity
   mint(0xRecipientAddress, 100);
   ```

2. **Transferring Tokens**
   ```solidity
   transferTokens(0xReceiverAddress, 50);
   ```

3. **Burning Tokens**
   ```solidity
   burnTokens(20);
   ```

4. **Redeeming Tokens**
   - Input `1` for Catizens rewards (10 tokens required).
   - Input `2` for Telegram Games rewards (5 tokens required).
   ```solidity
   redeemTokens(1);
   ```

## Security Considerations

- Only the owner can mint tokens.
- Proper checks ensure users have sufficient balances for transfers, burns, and redemptions.
- Uses OpenZeppelin's libraries for safe and secure implementation.

## License

This project is licensed under the [Curt Russel Celeste](https://www.facebook.com/profile.php?id=100069766380432).
