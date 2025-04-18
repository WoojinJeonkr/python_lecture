// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // 솔리디티 컴파일러 버전 지정

// Auction 추상 컨트랙트 정의
contract Auction {
    address internal auction_owner; // 경매 소유자 주소 (내부 접근)
    uint256 public auction_start; // 경매 시작 시간 (유닉스 타임스탬프)
    uint256 public auction_end; // 경매 종료 시간 (유닉스 타임스탬프)
    uint256 public highestBid; // 현재 최고 입찰가
    address public highestBidder; // 현재 최고 입찰자 주소

    // 경매 상태를 나타내는 enum (취소됨, 시작됨)
    enum auction_state {
        CANCELLED, STARTED
    }

    // 경매 대상 차량 정보를 담는 구조체
    struct car {
        string Brand; // 차량 브랜드
        string Rnumber; // 차량 등록번호
    }

    car public Mycar; // 경매에 등록된 차량 정보
    address[] bidders; // 입찰자 주소 목록
    mapping(address => uint) public bids; // 입찰자별 입찰 금액 매핑
    auction_state public STATE; // 현재 경매 상태

    // 경매가 진행 중인지 확인하는 modifier
    modifier an_ongoing_auction() {
        require(block.timestamp <= auction_end, "Auction has ended"); // 경매 종료 시간 전인지 확인
        _;
    }

    // 경매 소유자만 호출할 수 있는 modifier
    modifier only_owner() {
        require(msg.sender == auction_owner, "Only auction owner can call this"); // 소유자 확인
        _;
    }

    // 함수 선언에 virtual 키워드 추가
    function bid() public payable virtual returns (bool) {} // 입찰 함수 (추상)
    function withdraw() public virtual returns (bool) {} // 출금 함수 (추상)
    function cancel_auction() external virtual returns (bool) {} // 경매 취소 함수 (추상)

    // 이벤트 선언
    event BidEvent(address indexed highestBidder, uint256 highestBid); // 입찰 발생 시 이벤트
    event WithdrawalEvent(address withdrawer, uint256 amount); // 출금 발생 시 이벤트
    event CanceledEvent(uint message, uint256 time); // 경매 취소 시 이벤트
    event StateUpdated(auction_state newState); // 경매 상태 변경 시 이벤트
}

// Auction을 상속받아 실제 경매 로직을 구현한 MyAuction 컨트랙트
contract MyAuction is Auction {

    // 생성자: 경매 기간, 소유자, 차량 정보 입력받아 초기화
    constructor(uint _biddingTime, address _owner, string memory _brand, string memory _Rnumber) {
        auction_owner = _owner; // 경매 소유자 설정
        auction_start = block.timestamp; // 경매 시작 시간 설정
        auction_end = auction_start + _biddingTime * 1 hours; // 경매 종료 시간 설정 (입력값 시간 단위)
        STATE = auction_state.STARTED; // 경매 상태를 시작으로 설정
        Mycar.Brand = _brand; // 차량 브랜드 저장
        Mycar.Rnumber = _Rnumber; // 차량 등록번호 저장
    }

    // 부모 컨트랙트의 bid 함수 재정의 (override)
    function bid() public payable override an_ongoing_auction returns (bool) {
        require(bids[msg.sender] + msg.value > highestBid, "You can't bid, make a higher bid"); // 기존 입찰금 + 추가 입찰금이 최고가보다 높아야 함
        highestBidder = msg.sender; // 최고 입찰자 갱신
        highestBid = msg.value; // 최고 입찰가 갱신 (주의: 누적이 아님, 마지막 입찰 금액만 반영)
        bidders.push(msg.sender); // 입찰자 목록에 추가
        bids[msg.sender] = bids[msg.sender] + msg.value; // 입찰자별 입찰 금액 누적
        emit BidEvent(highestBidder, highestBid); // 입찰 이벤트 발생

        return true; // 성공 반환
    }

    // 부모 컨트랙트의 cancel_auction 함수 재정의 (override)
    function cancel_auction() external override only_owner an_ongoing_auction returns (bool) {
        STATE = auction_state.CANCELLED; // 경매 상태를 취소로 변경
        emit CanceledEvent(1, block.timestamp); // 취소 이벤트 발생
        return true; // 성공 반환
    }

    // 경매 비활성화 (selfdestruct 대신 사용)
    function deactivateAuction() external only_owner {
        require(block.timestamp > auction_end, "Auction is still ongoing"); // 경매가 종료된 후에만 호출 가능
        STATE = auction_state.CANCELLED; // 경매 상태를 취소로 변경
        emit CanceledEvent(2, block.timestamp); // 취소 이벤트 발생
    }

    // 경매 소유자가 남은 자금을 회수하는 함수
    function withdrawRemainingFunds() external only_owner {
        uint balance = address(this).balance; // 컨트랙트 잔액 조회
        require(balance > 0, "No funds left in the contract"); // 잔액이 있어야 함

        (bool success, ) = payable(auction_owner).call{value: balance}(""); // 소유자에게 잔액 전송
        require(success, "Transfer failed"); // 전송 성공 여부 확인
    }

    // 출금 함수 (입찰자들이 자금을 출금)
    function withdraw() public override returns (bool) {
        uint amount = bids[msg.sender]; // 출금할 금액 조회
        require(amount > 0, "No funds to withdraw"); // 출금할 금액이 있어야 함

        bids[msg.sender] = 0; // 출금 전 입찰 금액 0으로 초기화 (재진입 방지 목적)

        // 안전한 이더 전송 (가스 제한 5000)
        // (bool success, ) = payable(msg.sender).call{value: amount}("");
        (bool success, ) = payable(msg.sender).call{value: amount, gas: 5000}(""); 
        require(success, "Transfer failed"); // 전송 성공 여부 확인

        emit WithdrawalEvent(msg.sender, amount); // 출금 이벤트 발생
        return true; // 성공 반환
    }

    // 소유자 정보 반환 함수
    function get_owner() public view returns (address) {
        return auction_owner; // 소유자 주소 반환
    }

    // 경매 상태를 업데이트하는 함수
    function updateAuctionState(auction_state newState) external only_owner {
        STATE = newState; // 경매 상태 변경
        emit StateUpdated(newState); // 상태 변경 이벤트 발생
    }
}