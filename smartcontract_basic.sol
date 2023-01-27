pragma solidity ^0.8.0;

contract AddressValueViewer {
    mapping (address => uint) public addressValues;

    function viewAddressValue(address _address) public view returns (uint) {
        return addressValues[_address];
    }

    function setAddressValue(address _address, uint _value) public {
        addressValues[_address] = _value;
    }
}

/*
The contract declares a public mapping called addressValues, which is used to store a value at a given address. 
The viewAddressValue() function takes an address as input and returns the value stored at that address. The setAddressValue() function allows you to set the value stored at a given address.
*/