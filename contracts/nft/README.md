# Extension NFT Contract
## Simple Summary
Extension of ERC721 for additional functions
 - Batch creation of NFTs (bulk-minting)
 - NFT royalties

## Description
We want to mint NFTs to multiple accounts in one transaction.
1. Minter can mint multiple NFTs to multiple accounts.
2. Data(to, tokenID, tokenURI, feeNumerators) required for minting will be received as an array of the same size.
3. The royalty rate can be set when minting NFTs, and the beneficiary is forcibly designated as the minter.

## Specification
```solidity
interface ExtensionNonFungibleToken /* is ERC2981, ERC721, IERC5679Ext721 */ {
    /// @notice batch creation of NFTs
    /// @param _tos Address list to receive NFTs to be minted
    /// @param _tokenIds The identifier list for NFTs
    /// @param _tokenURIs The NFT URI(Metadata JSON Schema) list
    ///  To comply with the ERC5679 specification, the token URI is received as a bytes type.
    /// @param _feeNumerators Commission rate(basis point, ‱) on secondary sales
    function safeBulkMint(address[] calldata _tos, uint256[] calldata _tokenIds, bytes[] calldata _tokenURIs, uint96[] calldata _feeNumerators) external;
}
```

## Standard Interface Used
* [ERC-721: Non-Fungible Token Standard](https://eips.ethereum.org/EIPS/eip-721)
* [ERC-2981: NFT Royalty Standard](https://eips.ethereum.org/EIPS/eip-2981)
* [ERC-5679: Token Minting and Burning](https://eips.ethereum.org/EIPS/eip-5679)