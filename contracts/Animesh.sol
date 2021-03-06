pragma solidity ^0.4.3;
/*ERC Standard token Animesh*/
contract tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData); }

contract Animesh {
    /* Public variables of the token */
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* This notifies clients about the amount burnt */
    event Burn(address indexed from, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function Animesh(
        
        ) {
        balanceOf[msg.sender] = 100000000;              // Give the creator all initial tokens
        totalSupply = 100000000;                        // Update total supply
        name = "animesh";                                   // Set the name for display purposes
        symbol = "AJAIN";                               // Set the symbol for display purposes
        decimals = 5;                            // Amount of decimals for display purposes
    }

    /* Internal transfer, only can be called by this contract */
    function _transfer(address _from, address _to, uint _value) internal {
        if(_to != 0x0 && balanceOf[_from] > _value
                       && balanceOf[_to] + _value > balanceOf[_to]
                        )
        {               
        
        balanceOf[_from] -= _value;                         // Subtract from the sender
        balanceOf[_to] += _value;                            // Add the same to the recipient
        Transfer(_from, _to, _value);}
    }

   
    function transfer(address _to, uint256 _value) {
        _transfer(msg.sender, _to, _value);
    }

    
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (_value < allowance[_from][msg.sender]){     // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;}
    }

    
    function approve(address _spender, uint256 _value)
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    
    function approveAndCall(address _spender, uint256 _value, bytes _extraData)
        returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }        

    
    function burn(uint256 _value) returns (bool success) {
        if(balanceOf[msg.sender] > _value){            // Check if the sender has enough
        balanceOf[msg.sender] -= _value;                      // Subtract from the sender
        totalSupply -= _value;                                // Updates totalSupply
        Burn(msg.sender, _value);
        return true;}
    }

    function burnFrom(address _from, uint256 _value) returns (bool success) {
        if(balanceOf[_from] >= _value &&                // Check if the targeted balance is enough
        _value <= allowance[_from][msg.sender]){    // Check allowance
        balanceOf[_from] -= _value;                         // Subtract from the targeted balance
        allowance[_from][msg.sender] -= _value;             // Subtract from the sender's allowance
        totalSupply -= _value;                              // Update totalSupply
        Burn(_from, _value);
        return true;}
    }
}