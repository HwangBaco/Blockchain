// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Greeter {

    string public greeting;

    struct Greeting {
        address sender;
        string message;
    }
    Greeting[] public greetings;

    

    /* greeting의 초기값은 "Hello World!" */
    constructor() {
        greeting = "Hello World!";

        greetings.push(Greeting({
            sender: msg.sender,
            message: "Hello World!"
        }));
    }

    /* 사용자로부터 greeting을 입력받습니다. 구조체에서는 사용자의 주소도 함께 입력해주세요. */
    function setGreeting(string memory _greeting) public {
        // greeting = /* 채우세요 */
        greeting = _greeting;
        greetings.push(Greeting({
        sender: msg.sender,
        message: _greeting
    }));
    }

    /* greeting을 반환합니다. */
    function greet() view public returns (string memory) {

           return greeting;

    }


    function greetingHistory() view public returns (Greeting[] memory) {
    return greetings;
    }
}