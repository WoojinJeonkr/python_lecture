// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // 솔리디티 컴파일러 버전 지정

// Auction 추상 컨트랙트 정의
contract Auction {
    address internal auction_owner; // 경매 소유자 주소 (내부 접근)
    uint256 public auction_start; // 경매 시작 시간 (유닉스 타임스탬프)
    uint256 public auction_end; // 경매 종료 시간 (유닉스 타임스탬프)
    uint256 public highestBid; // 현재 최고 입찰가
    address public highestBidder; // 현재 최고 입찰자 주소

    mapping(address => uint256) public pendingReturns;

    // 경매 상태를 나타내는 enum (시작됨, 취소됨)
    enum auction_state {
        ACTIVATE, CANCELL
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
        require(block.timestamp < auction_end, "Auction has ended"); // 경매 종료 시간 전인지 확인
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
    event CanceledEvent(uint256 indexed message, uint256 time, address indexed highestBidder, uint256 refundAmount); // 경매 취소 시 이벤트
    event StateUpdated(auction_state newState); // 경매 상태 변경 시 이벤트
    event AuctionEnded(address winner, uint amount);
}

// Auction을 상속받아 실제 경매 로직을 구현한 MyAuction 컨트랙트
contract MyAuction is Auction {
    mapping(address => bool) private isParticipant;

    // 생성자: 경매 기간, 소유자, 차량 정보 입력받아 초기화
    constructor(uint _biddingTime, address _owner, string memory _brand, string memory _Rnumber) {
        auction_owner = _owner; // 경매 소유자 설정
        auction_start = block.timestamp; // 경매 시작 시간 설정
        auction_end = auction_start + _biddingTime * 1 hours; // 경매 종료 시간 설정 (입력값 시간 단위)
        STATE = auction_state.ACTIVATE; // 경매 상태를 시작으로 설정
        Mycar.Brand = _brand; // 차량 브랜드 저장
        Mycar.Rnumber = _Rnumber; // 차량 등록번호 저장
    }

    // 부모 컨트랙트의 bid 함수 재정의 (override)
    function bid() public payable override an_ongoing_auction returns (bool) {
        // 경매가 활성 상태인지 확인
        require(STATE == auction_state.ACTIVATE, "Auction not active");
        
        // 경매 종료 시간이 지나지 않았는지 확인
        require(block.timestamp <= auction_end, "Auction already ended");
        
        // 새 입찰이 현재 최고 입찰보다 높은지 확인
        require(bids[msg.sender] + msg.value > highestBid, "There already is a higher bid");

        // 새 입찰의 총액 계산 (기존 입찰액 + 새로운 입찰액)
        uint newBidAmount = bids[msg.sender] + msg.value;
        
        // 이전 최고 입찰자가 있다면, 그 입찰자에게 환불 금액을 pendingReturns에 추가
        if (highestBidder != address(0)) {
            pendingReturns[highestBidder] += highestBid;
        }
        
        // 새로운 최고 입찰자와 금액 설정
        highestBidder = msg.sender;
        highestBid = newBidAmount; // 누적 대신 직접 할당

        require(!isParticipant[msg.sender], "Already participated");

        bidders.push(msg.sender);
        isParticipant[msg.sender] = true;
        
        // 해당 입찰자의 현재 입찰 금액 업데이트 
        bids[msg.sender] = newBidAmount;
        
        // BidEvent 이벤트 발생
        emit BidEvent(highestBidder, highestBid);
        
        return true;
    }

    // 부모 컨트랙트의 cancel_auction 함수 재정의 (override)
    function cancel_auction() external override only_owner an_ongoing_auction returns (bool) {
        // 경매 종료 시간 확인 추가
        require(block.timestamp < auction_end, "Auction already ended");
        
        STATE = auction_state.CANCELL;
    
        // 모든 입찰자 환급 처리
        for (uint i = 0; i < bidders.length; i++) {
            address bidder = bidders[i];
            pendingReturns[bidder] += bids[bidder];
            bids[bidder] = 0;
        }
        
        emit CanceledEvent(1, block.timestamp, highestBidder, highestBid);
        return true;
    }

    // 경매 비활성화 (selfdestruct 대신 사용)
    function deactivateAuction() external only_owner {
        require(block.timestamp > auction_end, "Auction is still ongoing"); // 경매가 종료된 후에만 호출 가능
        STATE = auction_state.CANCELL; // 경매 상태를 취소로 변경
        emit CanceledEvent(2, block.timestamp, highestBidder, highestBid); // 취소 이벤트 발생
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
        uint amount = bids[msg.sender];
        require(amount > 0, "No funds to withdraw");
        
        bids[msg.sender] = 0;
        
        // 안전한 전송 방법 사용
        (bool success, ) = payable(msg.sender).call{value: amount, gas: 5000}(""); 
        require(success, "Transfer failed");
        
        emit WithdrawalEvent(msg.sender, amount);
        return true;
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