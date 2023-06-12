// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RandomNumberGame {

    /* 차례대로 난수로 생성된 숫자, 사용자가 추리한 숫자, 정답자입니다. */
    uint256 private randomNumber;
    uint256 public guessNumer;
    address payable public winner;
    /* 사용자의 추리에 대한 상태를 선언합니다. */
    enum Message { Win, Up, Down }
    Message public message;

    /* 사용자에게 제공될 메시지 이벤트입니다. */
    event messageEvent(string _message);

    constructor() payable {
        /* 컨트랙트 배포 시, 정답이 될 난수를 생성합니다. */
        randomNumber = generateRandomNumber();
    }

    /* 사용자가 1 ETH를 지불하고 숫자를 추리할 때 호출할 함수입니다. */
    function guess(uint256 _guessNumber) public payable {
        /* 1 ETH가 전송되었는지 확인합니다. */
        require(msg.value == 1 ether, "1 ETH is needed to guess");

        if (_guessNumber == randomNumber) {
            winner = payable(msg.sender);
            winner.transfer(address(this).balance);
            randomNumber = generateRandomNumber();
            message = Message.Win;
            emit messageEvent(getMessage());
        } else if (_guessNumber < randomNumber) {
            message = Message.Up;
            emit messageEvent(getMessage());
        } else {
            message = Message.Down;
            emit messageEvent(getMessage());
        }
    }

    /* 1~100 사이의 난수를 생성하는 함수입니다. */
    function generateRandomNumber() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(
            block.timestamp + block.prevrandao))) % 100 + 1;
    }

    /* message 값에 따른 상태를 문자열로 반환하는 함수입니다. */
    function getMessage() public view returns (string memory) {
        if (message == Message.Win) { return "Win"; }
        else if (message == Message.Up) { return "Up"; }
        else if (message == Message.Down) { return "Down"; }
        else { return "You need to guess first"; }
    }
}