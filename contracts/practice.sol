pragma solidity ^0.4.4;
contract practice{
    address public owner;
    mapping (address => uint) balances;
    //constructor runs once upon contract creation
    function practice(){
        owner = msg.sender;// msg is in built object,
        //above line sets the owner as the one who deployed the contract
        balances[owner] = 1000;
        
    }
    function transfer(address _to, uint _value) returns (bool success){
        if(balances[msg.sender] < _value){
            return false;
        }
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function getBalance(address _user) constant returns (uint _balance){
         return balances[_user];
        }
}
