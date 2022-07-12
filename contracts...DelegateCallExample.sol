// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// A delegates repsonsibility to B on the call. B gets full control of A's state variables 

contract A {

    uint256 public num; 
    uint256 public value; 
    address public sender; 

    function setVars(address _contract, uint _num) public payable {
        (bool success, ) = _contract.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        require(success, "delegatecall failed.");
    }

}

contract B {

    event DelegateCalled(uint _num, uint _value, address _sender);

    uint256 public num; 
    uint256 public value; 
    address public sender; 

    function setVars(uint _num) public payable {
        num = _num; 
        value = msg.value; 
        sender = msg.sender; 

        emit DelegateCalled(num, value, sender);

    }

}
