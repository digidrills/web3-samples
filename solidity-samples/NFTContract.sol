// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTContract is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Property", "PRT") {}

    function mint_and_transfer(address user_address,string memory name,string memory latitude,string memory longitude,string memory url)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIds.current();
        _mint(user_address, newItemId);
        // creating a JSON object with 4 fields name,latitude,longitude and url
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "', name, '",',
                '"latitude": "', latitude, '",',
                '"longitude": "', longitude, '",',
                '"url": "', url, '"',
            '}'
        );
        //the uri field contains the base64 encoded string of the above json , which is stored on chain
        _setTokenURI(newItemId,string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        )
        );

        _tokenIds.increment();
        return newItemId;
    }
}
