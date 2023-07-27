// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "./NonFungibleToken.sol";

contract ExtensionNonFungibleToken is ERC2981, NonFungibleToken {
    uint16 private immutable _maxBatchSize = 200;

    constructor(
        string memory name_,
        string memory symbol_,
        address minter_
    ) NonFungibleToken(name_, symbol_, minter_) {}

    function safeBulkMint(
        address[] calldata _tos,
        uint256[] calldata _tokenIds,
        bytes[] calldata _tokenURIs,
        uint96[] calldata _feeNumerators
    ) external virtual onlyOwner {
        uint batchSize = _tos.length;

        require(_maxBatchSize >= batchSize, "Batch too large");
        require(_tokenIds.length == batchSize, "Mismatched number of parameters");
        require(_tokenURIs.length == batchSize, "Mismatched number of parameters");
        require(_feeNumerators.length == batchSize, "Mismatched number of parameters");

        for(uint i = 0; i < batchSize; i++) {
            safeMint(_tos[i], _tokenIds[i], _tokenURIs[i]);
            _setTokenRoyalty(_tokenIds[i], _msgSender(), _feeNumerators[i]); // _msgSender() == owner()
        }
    }

    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);
        _resetTokenRoyalty(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(NonFungibleToken, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
