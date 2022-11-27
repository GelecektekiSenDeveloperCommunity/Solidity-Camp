//// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/* 

    token coin difference 
    if it has own blockchain then coin 

     1 Ether = 1 Ether
    1 Ether = 10^9 / 10**9 Gwei -> only use second one
    1 Ether = 10^18 / 10**18 Wei
    hash -> password , 256 bit , if we change even one character whole hash changes

    result = number1 + result ; is the same thing with result += number1;
    msg.sender = the addres of message
    msg.value = the value of message

    Transfer, (2300 gas) , throws error , gas is limited for preventing reenteracy attacks
    call ,return bool + dat , can limit gas useage -> reccomended way to send eth
    (bool sent , bytes memory data) = targetAddress.call{value:1000, gas: 10000}(""); in paranthesis we can call functions
    send  (2300 gas) return bool gas is limited for preventing reenteracy attacks
    
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
        require(balances[msg.sender] > (10 ** 18), "not enough money");
        uint amount2 = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool done, ) = msg.sender.call{value: amount2}("");
    }

    function reader(address _address) public view returns (uint) {
        return (balances[_address]);
    }
}

contract a1 {
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
