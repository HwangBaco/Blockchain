// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLottery{

    address public manager;
    address payable[] public players;

    /* 컨트랙트를 배포한 자를 manager로 지정합니다. */
    constructor() {
        manager = msg.sender;

    }

    /* 1 ETH 이상을 지불하여 Lottery에 참여할 수 있습니다. */
    function enter() public payable {
        require(msg.value >= 1 ether);
        players.push(payable(msg.sender));
    }

    /* 당첨자 추첨용 난수 생성 함수입니다. */
    function random() private view returns (uint256) {
        return
            uint256(keccak256(abi.encodePacked(
                block.timestamp, msg.sender, players.length)));
    }

    /* 당첨자 추첨용 함수입니다. */
    function pickWinner() public managerOnly {
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        players = new address payable[](0);
    }

    /* 함수 실행 요건을 설정합니다. */
    modifier managerOnly {
        require(msg.sender == manager);
        _;
    }
}