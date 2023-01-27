pragma solidity ^0.8.0;

contract ValueAndNFTViewer {
    mapping (address => uint) public addressValues;
    mapping (address => mapping (uint => address)) public addressNFTs;
    address payable owner;

    event ValueChanged(address indexed _address, uint _oldValue, uint _newValue);
    event NFTChanged(address indexed _address, uint _tokenId, address _oldNFT, address _newNFT);

    constructor() public {
        owner = msg.sender;
    }

    function viewAddressValue(address _address) public view returns (uint) {
        return addressValues[_address];
    }

    function setAddressValue(address _address, uint _value) public {
        require(msg.sender == owner, "Only the owner can set address values");
        uint oldValue = addressValues[_address];
        addressValues[_address] = _value;
        emit ValueChanged(_address, oldValue, _value);
    }

    function viewAddressNFT(address _address, uint _tokenId) public view returns (address) {
        return addressNFTs[_address][_tokenId];
    }

    function setAddressNFT(address _address, uint _tokenId, address _NFT) public {
        require(msg.sender == owner, "Only the owner can set NFTs for an address");
        address oldNFT = addressNFTs[_address][_tokenId];
        addressNFTs[_address][_tokenId] = _NFT;
        emit NFTChanged(_address, _tokenId, oldNFT, _NFT);
    }
}

/*
This version of the contract includes the following additional features:

The contract has an owner, and only the owner can call the setAddressValue() and setAddressNFT() functions. This is checked using a require() statement.
An event ValueChanged is emitted when the value of an address is changed, which includes the address, old value, and new value. This allows other contracts or external entities to listen for changes to address values.
An event NFTChanged is emitted when the NFT associated with a given address is changed, which includes the address, token id, old NFT and new NFT. This allows other contracts or external entities to listen for changes to the NFTs associated with an address.
The viewAddressNFT() function allows to view the NFT associated with a given address and token id.

You also should note that, this contract is not dealing with any ERC721 or ERC1155 standard and it's using a mapping to store the NFTs associated with an address, which is not the correct way to store NFTs.

*/