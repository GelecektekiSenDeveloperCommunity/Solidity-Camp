//// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract VariableTypes {
    bool trueOrFalse = true;
    //default bool type is false.
    //variableType variable name. Here we dont need to decleare it's value.

    int256 integer;
    // int256 integer = 1+1 ; or int256 integer= 2^3 ; If the result of calculation is integer we can express without any error.
    uint256 unsignedInteger;
    uint8 unsignedIntegerLow;

    /* 
    1)uint cant be negative.
    2)256 refers to 256 bits. And bits are used for binary system. 256 means this variable can take 2^256 -1 at most. It cannot be more than 256 bits.
   */
    address myAddress = 0x7EFd0B777026A9c42757d92A3f79361467372435;

    bytes32 name;
    //bytes type can be decleared from bytes1 to bytes32 -> these declerations are static but if we decleare as bytes this is dynamic.abi

    string surname;
    //String is more expensive than bytes . However for storing arbitrary-length string (UTF-8) data that's longer than 32 bytes using string is better. If we use smaller data bytes are more efficent.

    string[4] arrayName0 = ["a", "b", "c", "d"]; // For declaring static
    uint256[] arrayName; //For declaring as dynamic
    uint256[] arrayName2 = [0, 1, 2, 3];
    // arrayName[1] = 1 not 0

    mapping(uint256 => string) idToName;

    struct fruitJuice {
        string brand;
        uint256 price;
    }
    fruitJuice f1;
    fruitJuice f2;

    /* 
public = Variables can be used both externally and internally. For public state variable, Solidity automatically creates a getter function.
external = External functions are meant to be called by other contracts. They cannot be used for internal call. To call external function within contract this.function_name() call is required. State variables cannot be marked as external.
private =  Variables can only be used internally and not even by derived contracts.
internal = Variables can only be used internally or by derived contracts


pure = It can only use local variables that are declared in the function and the arguments that are passed to the function to compute or return a value
function addTwoNumber(uint _number1 , uint _number2) public pure returns(uint){
    uint sum = _number1 + _number2 ;
    return(sum);
 }   
view =  a function that only reads but doesn't alter the state variables defined in the contract is called a View Function



*/
    function change(string memory _newBrandName1, string memory _newBrandName2) public {
        f1.brand = _newBrandName1;
        f2.brand = _newBrandName2;
    }

    function read() public view returns (string memory, string memory) {
        return (f1.brand, f2.brand);
    }
    function pureFunc(uint n1 , uint n2) public pure returns (uint) {
        uint sum = n1 + n2 ;
        return (sum);
    }

    function callOtherFunction(string memory _studentName, uint256 _id) public {
        studentList(_studentName, _id);
    }

    function studentList(string memory studentName, uint256 id) public {
        idToName[id] = studentName;
    }

    function push() public {
        //  array1.pop();
        // array1.push();
    }
}
