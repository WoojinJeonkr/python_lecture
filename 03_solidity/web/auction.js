
var web3 = new Web3('ws://localhost:7545');
var bidder;
var participants = new Set();

web3.eth.getAccounts().then(function(acc){
  console.log(acc)
  web3.eth.defaultAccount = acc[0]
  bidder = acc[0]

  auctionContract.methods.auction_end().call().then( (result)=>{
    document.getElementById("auction_end").innerHTML=result;
  });

  auctionContract.methods.highestBidder().call().then( (result)=>{
    document.getElementById("HighestBidder").innerHTML=result;
  }); 
      
  auctionContract.methods.highestBid().call().then( (result)=>{
    console.log("highest bid info: ", result)
    var bidEther = web3.utils.fromWei(web3.utils.toBN(result), 'ether');
    document.getElementById("HighestBid").innerHTML=bidEther;

  }); 

  auctionContract.methods.STATE().call().then( (result)=>{
    document.getElementById("STATE").innerHTML=result;
  }); 

  auctionContract.methods.Mycar().call().then( (result)=>{
    document.getElementById("car_brand").innerHTML=result[0];
    document.getElementById("registration_number").innerHTML=result[1];
  }); 

  auctionContract.methods.bids(bidder).call().then( (result) => {
    var bidEther = web3.utils.fromWei(web3.utils.toBN(result), 'ether');
    document.getElementById("MyBid").innerHTML=bidEther;
    console.log(bidder);
  }); 
}); // end of web3.eth.getAccounts()

var auctionContract =  new web3.eth.Contract(
  [
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_biddingTime",
          "type": "uint256"
        },
        {
          "internalType": "address",
          "name": "_owner",
          "type": "address"
        },
        {
          "internalType": "string",
          "name": "_brand",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "_Rnumber",
          "type": "string"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "highestBidder",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "highestBid",
          "type": "uint256"
        }
      ],
      "name": "BidEvent",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "message",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "time",
          "type": "uint256"
        }
      ],
      "name": "CanceledEvent",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "enum Auction.auction_state",
          "name": "newState",
          "type": "uint8"
        }
      ],
      "name": "StateUpdated",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "address",
          "name": "withdrawer",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "WithdrawalEvent",
      "type": "event"
    },
    {
      "inputs": [],
      "name": "Mycar",
      "outputs": [
        {
          "internalType": "string",
          "name": "Brand",
          "type": "string"
        },
        {
          "internalType": "string",
          "name": "Rnumber",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "STATE",
      "outputs": [
        {
          "internalType": "enum Auction.auction_state",
          "name": "",
          "type": "uint8"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "auction_end",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "auction_start",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "bid",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "payable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "name": "bids",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "cancel_auction",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "deactivateAuction",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "get_owner",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "highestBid",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "highestBidder",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "enum Auction.auction_state",
          "name": "newState",
          "type": "uint8"
        }
      ],
      "name": "updateAuctionState",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "withdraw",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "withdrawRemainingFunds",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ]
);

// 경매 트랜잭션 주소
auctionContract.options.address = '0xbB1cDd6dCDA9483b2D1a68ee6FEAB7f6e12f1D44';
// 경매 참여자 지갑 주소
var userWalletAddress = '0xaD8209F90c822A1aE76F46952677407574da34e6';

function bid() {
  var mybid = document.getElementById('value').value;

  // 입력값 검증 추가
  if (!mybid || isNaN(mybid) || mybid <= 0) {
    document.getElementById("biding_status").innerHTML = "유효한 입찰 금액을 입력하세요";
    return;
  }

  auctionContract.methods.highestBid().call().then((currentBid) => {
    var currentBidEther = web3.utils.fromWei(web3.utils.toBN(currentBid), 'ether');
    if (parseFloat(mybid) <= parseFloat(currentBidEther)) {
      document.getElementById("biding_status").innerHTML = "현재 최고 입찰가보다 높은 금액을 입력하세요";
      return;
    }
    
    // 검증 통과 후 트랜잭션 실행
    auctionContract.methods.bid().send({
      from: userWalletAddress, 
      value: web3.utils.toWei(mybid, "ether"), 
      gas: 200000
    }).then((result) => {
      console.log(result);
      document.getElementById("biding_status").innerHTML = "입찰 성공, 트랜잭션 ID: " + result.transactionHash;
    }).catch((error) => {
      document.getElementById("biding_status").innerHTML = "입찰 실패: " + error.message;
    });
  });
}

auctionContract.events.BidEvent(function(error, event){
  console.log(event);
}).on("connected", function(subscriptionId){
  console.log(subscriptionId);
}).on('data', function(event){
  console.log(event);
  // 참여자 주소 추가
  participants.add(event.returnValues.highestBidder);
  // 참여자 목록 업데이트
  updateParticipantsList();
  $("#eventslog").html(event.returnValues.highestBidder + ' has bidden(' + event.returnValues.highestBid + ' wei)');
});

// 참여자 목록 업데이트 함수 추가
function updateParticipantsList() {
  var listElement = document.getElementById('participants-list');
  listElement.innerHTML = ''; // 목록 초기화
  
  participants.forEach(function(address) {
    var listItem = document.createElement('li');
    listItem.textContent = address;
    listElement.appendChild(listItem);
  });
}
	
function init(){
 // setTimeout(() => alert("아무런 일도 일어나지 않습니다."), 3000);

  // 과거 입찰 이벤트 조회하여 참여자 목록 초기화
  auctionContract.getPastEvents('BidEvent', {
    fromBlock: 0,
    toBlock: 'latest'
  }, function(error, events) {
    if (!error) {
      events.forEach(function(event) {
        participants.add(event.returnValues.highestBidder);
      });
      updateParticipantsList();
    }
  });
}

var auction_owner=null;
auctionContract.methods.get_owner().call().then((result)=>{
  auction_owner=result;
  if(bidder!=auction_owner)
  $("#auction_owner_operations").hide();
})
  
  
  
function cancel_auction(){
  // 경매 주최자인지 확인
  auctionContract.methods.get_owner().call().then((owner) => {
    if (userWalletAddress.toLowerCase() !== owner.toLowerCase()) {
      document.getElementById("cancel_status").innerHTML = "경매 주최자만 취소할 수 있습니다.";
      return;
    }
    
    // 경매 상태 확인
    auctionContract.methods.STATE().call().then((state) => {
      if (state != 0) { // 0은 RUNNING 상태로 가정
        document.getElementById("cancel_status").innerHTML = "이미 종료되었거나 취소된 경매입니다.";
        return;
      }
      
      // 경매 취소 실행
      auctionContract.methods.cancel_auction().send({
        from: userWalletAddress,
        gas: 200000
      })
      .then((result) => {
        console.log(result);
        document.getElementById("cancel_status").innerHTML = "경매가 성공적으로 취소되었습니다.";
        // UI 상태 업데이트
        auctionContract.methods.STATE().call().then((newState) => {
          document.getElementById("STATE").innerHTML = newState;
        });
      })
      .catch((error) => {
        console.error(error);
        document.getElementById("cancel_status").innerHTML = "경매 취소 중 오류가 발생했습니다: " + error.message;
      });
    });
  });
}

function withdraw() {
  auctionContract.methods.withdraw().send({ from: userWalletAddress, gas: 200000 })
  .then((result) => {
    console.log(result);
    document.getElementById("withdraw_status").innerHTML = "Withdraw successful, transaction ID: " + result.transactionHash;
  })
  .catch((error) => {
    console.error(error);
    document.getElementById("withdraw_status").innerHTML = "Withdraw failed: " + error.message;
  });
}

function Destruct_auction(){

}

auctionContract.events.BidEvent(/*{highestBidder:"A",highestBid:"888"},*/function(error, event){ 
  console.log(event); 
}).on("connected", function(subscriptionId){
  console.log(subscriptionId);
}).on('data', function(event){
  console.log(event); // same results as the optional callback above
  $("#eventslog").html(event.returnValues.highestBidder + ' has bidden(' + event.returnValues.highestBid + ' wei)');
}).on('changed', function(event){
  // remove event from local database
  console.log(event);
})
  
auctionContract.events.CanceledEvent( function(error, event){ 
  console.log(event); 
}).on("connected", function(subscriptionId){
  console.log(subscriptionId);
}).on('data', function(event){
  console.log(event); // same results as the optional callback above
  $("#eventslog").html(event.returnValues.message+' at '+event.returnValues.time);
}).on('changed', function(event){
  // remove event from local database
}).on('error', function(error, receipt){ // If the transaction was rejected by the network with a receipt, the second parameter will be the receipt.
  
})

auctionContract.events.WithdrawalEvent({}, function(error, event) {
  if (error) {
    console.error(error);
  } else {
    document.getElementById("STATE").innerHTML = event.returnValues.newState;
    console.log("Auction state updated: ", event.returnValues.newState);
  }
})
