<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DM 테스트</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
  
<style>
	.message {
		border-bottom: 1px solid gray;
		padding: 10px;
	}
</style>
</head>
<body>

    <div id="app">
    
        <h1>DM 테스트</h1>
        <p>회원 닉네임 : {{memberNick}}</p>
        
        <hr>
        
        <input type="text" v-model="text" v-on:input="text=$event.target.value">
        <button v-on:click="sendMessage">전송</button>
        
        <hr>
        
        <div class="message-wrapper">
            <div class="message" v-for="(message, index) in messageList" :key="message.no">
                <div>
                	{{message.memberNick}}
                	<div v-if="message.memberNick == memberNick">(본인)</div>
                </div>
                <div>{{message.content}}</div>
                <div>{{timeFormat(message.time)}}</div>
            </div>
        </div>
    </div>

	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
    <script>
        Vue.createApp({
            data(){
                return {
                    text:"",//사용자가 입력하는 내용
                    messageList:[],//채팅 기록
                    memberNick:"${sessionScope.memberNick}",//나의 아이디
                    socket:null,//웹소켓 연결 객체
                };
            },
            methods:{
            	// 메세지 불러오는 함수
            	async loadMessage() {
            	    const roomNo = new URLSearchParams(location.search).get("room");
            	    const url = "${pageContext.request.contextPath}/rest/message/"+roomNo;

            	    try {
            	        const resp = await axios.get(url);
            	        this.messageList = resp.data.map(msg => JSON.parse(msg.messageContent));
            	    } catch (err) {
            	        console.error("메세지를 불러올 수 없습니다.");
            	    }
            	},
            	// 메세지 리스트 불러오는 함수
	            displayMessageList(resp) {
				    this.messageList = resp.map(msg => {
				        const msgContent = JSON.parse(msg.messageContent);
				        return {
				            memberNick: msgContent.memberNick,
				            content: msgContent.content,
				            time: this.timeFormat(msgContent.time),
					    };
					});
				},
			    connect(){
            		const url = "${pageContext.request.contextPath}/ws/channel";
            		this.socket = new SockJS(url);
            		
            		const app = this;
            		this.socket.onopen = function(){
            			app.openHandler();
            		};
            		this.socket.onclose = function(){
            			app.closeHandler();
            		};
            		this.socket.onerror = function(){
            			app.errorHandler();
            		};
            		this.socket.onmessage = function(e){
            			app.messageHandler(e);
            		};
            	},
            	openHandler(){
            		const room = new URLSearchParams(location.search).get("room");
                    const data = { type:2, room: room };
                    this.socket.send(JSON.stringify(data));
                    console.log("서버에 연결되었습니다.");
            	},
            	closeHandler(){
            		console.log("서버와의 연결이 종료되었습니다.");
            	},
            	errorHandler(){
            		console.log("연결 중 오류가 발생했습니다.");
            	},
            	messageHandler(e){
            		this.messageList.push(JSON.parse(e.data));
            	},
            	sendMessage() {
            		if(this.text.length == 0) return;
            		this.socket.send(this.jsonText);
            		this.text = "";
            	},
            	timeFormat(time) {
            		return moment(time).format("A h:mm");
            	}
            },
            computed:{ 
            	//실시간으로 메세지가 입력될 때마다 실행되므로 성능의 무리가 간다. 
            	//vue에서 역할을 구분하기 위해서 사용한다.
            	jsonText() {
            		return JSON.stringify({ type: 1, content: this.text });
            	},
            },
            created(){
            	//웹소켓 연결 코드
            	this.connect();
            	// 메시지 불러오기
                this.loadMessage();
            }
        }).mount("#app");
    </script>
</body>
</html>