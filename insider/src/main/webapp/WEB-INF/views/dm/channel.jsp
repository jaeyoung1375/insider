<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.message {
		border-bottom: 1px solid gray;
		padding: 10px;
	}
</style>

<h1>DM 테스트</h1>
<p>회원 번호 : ${sessionScope.memberNo}</p>
<p>회원 닉네임 : ${sessionScope.memberNick}</p>

<hr>

<!-- 메세지 입력창 + 전송버튼 -->
<input type="text" class="user-input">
<button class="btn-send">전송</button>

<hr>

<!-- 메세지가 표시될 공간 -->
<div class="message-wrapper">

</div>


<script type="text/template" id="message-template">
	<div class="message">
		<h3 class="memberNick">보낸사람</h3>
		<p class="content">내용</p>
		<span class="time">HH:mm</span>
	</div>
</script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
<script>
	$(function(){
		// 시작하자마자 채팅방 메세지 불러오기
		loadMessage();
		
		//console.log(window.socket)
		// 메세지 불러오는 함수
		function loadMessage() {
			const roomNo = new URLSearchParams(location.search).get("room");
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/message/"+roomNo,
				method:"get",
				success:function(resp){
					//resp에 있는 목록의 모든 메세지를 화면에 추가
					displayMessageList(resp);
					//웹소켓 연결
					connectWebSocket();
				},
			});
		}
		
		// 메세지 리스트 불러오는 함수
		function displayMessageList(resp){
			for(let i=0; i < resp.length; i++) {
				//수신한 데이터(e.data)가 JSON 문자열 형태이므로 해석 후 처리
				const data = JSON.parse(resp[i].messageContent);
				const time = moment(data.time).format("HH:mm");
				
				// 템플릿 불러오기
				var template = $("#message-template").html();
				// 템플릿을 html로 해석
				var html = $.parseHTML(template);
				// html에 정보 담기
				$(html).find(".memberNick").text(data.memberNick);
				$(html).find(".content").text(data.content);
				$(html).find(".time").text(time);
				
				// 템플릿 화면에 찍기
				$(".message-wrapper").append(html);
			}
		}
		
		// 웹소켓 연결하는 함수
		function connectWebSocket() {
			changeToDisconnect();
			
			// sockjs로 달라지는 부분(주소, 연결생성)
//			const url = "/ws/sockjs";
			const url = "${pageContext.request.contextPath}/ws/channel";
			window.socket = new SockJS(url);
			
			window.socket.onopen = function() {
				// const data = { type:2, room:"${param.room}" }; -> jsp에만 할 수 있음
				const room = new URLSearchParams(location.search).get("room");
				const data = { type:2, room : room};	// js파일에서도 할 수 있음
				window.socket.send(JSON.stringify(data));
				
				changeToConnect();
				$("<p>").text("서버에 연결되었습니다.").appendTo(".message-wrapper");
			};
			window.socket.onclose = function() {
				changeToDisconnect();
				$("<p>").text("서버와의 연결이 종료되었습니다.").appendTo(".message-wrapper");
			};
			window.socket.onerror = function() {
				changeToDisconnect();
				$("<p>").text("연결 중 오류가 발생했습니다.").appendTo(".message-wrapper");
			};
			// 메세지 수신 시 수신된 메세지로 태그를 만들어서 추가
			window.socket.onmessage = function(e) {
				// 수신한 데이터(e.data)가 JSON 문자열 형태이므로 해석 후 처리
				const data = JSON.parse(e.data);
				// fromNow: n초 전(갱신은 따로 처리해줘야 함)
				const time = moment(data.time).format("HH:mm");
				
				// 템플릿 불러오기
				const template = $("#message-template").html();
				// 템플릿을 html로 해석
				const html = $.parseHTML(template);
				// html에 정보 담기
				$(html).find(".memberNick").text(data.memberNick);
				$(html).find(".content").text(data.content);
				$(html).find(".time").text(time);
				
				// 템플릿 화면에 찍기
				$(".message-wrapper").append(html);
			};
			
			// 전송 버튼을 누르면 서버에 메세지를 전송하도록 구현
			$(".btn-send").click(function() {
				const text = $(".user-input").val();
				if(text.length == 0) return;
				
				const data = { type : 1, content : text };
				
				// 자바스크립트에서 JSON을 처리하는 병령
				// JSON.stringify(객체) -> 객체를 JSON 문자열로 반환
				// JSON.parse(JSON 문자열) -> JSON 문자열을 객체로 변환
				window.socket.send(JSON.stringify(data));
				
				// 입력창 초기화
				$(".user-input").val("");
			});
			
			// 연결 상태일 때의 화면을 만드는 함수
			function changeToConnect() {
				$(".user-input").prop("disabled", false);
				$(".btn-send").prop("disabled", false);
			}
			
			// 종료 상태일 때의 화면을 만드는 함수
			function changeToDisconnect() {
				$(".user-input").prop("disabled", true);
				$(".btn-send").prop("disabled", true);
			}
		}
		
	});
</script>