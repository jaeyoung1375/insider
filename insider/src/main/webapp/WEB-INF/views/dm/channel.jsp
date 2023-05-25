<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insider DM</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<style>
	.room-image {
	    min-width:50px;
	    width:100%;
	}
	@media screen and (max-width:576px) {
	    .room-image {
	    display: none;
	    }
	}
	.message-wrapper {
        background-color: white;
        overflow: hidden;
    }
	.message-wrapper > .message {
	    display: flex;
	    font-size: 17.5px;
	    margin-top: 0.65em;
	}
	.message-wrapper > .message > .profile-wrapper {
	    min-width: 45px;
	    max-width: 45px;
	}
	.message-wrapper > .message > .profile-wrapper > img {
	    border-radius: 50%;
	    width:100%;
	}
	.message-wrapper > .message > .content-wrapper {
	    flex-grow: 1;
	    display: flex;
	    flex-direction: column;
	    padding: 0 0.5em;
	}
	.message-wrapper > .message > .content-wrapper > .content-header {
	    font-size: 0.90em;
	    padding-right: 0.3em;
	    padding-left: 0.3em;
	    color: #3c6382;
	}
	.message-wrapper > .message > .content-wrapper > .content-body {
	    display: flex;
	    font-weight: normal;
	    padding-top: 0.35em;
	    align-items: flex-end;
	}
	.message-wrapper > .message > .content-wrapper > .content-body > .message-wrapper {
	    background-color: rgba(239, 239, 239);
	    font-size: 0.85em;
	    border-radius: 1.5em;
	    max-width: 500px;
	    word-break: break-all;
	    padding-top: 0.35em;
		padding-bottom: 0.35em;
		padding-left: 0.9em;
		padding-right: 0.9em;
	}
	.message-wrapper > .message > .content-wrapper > .content-body > .info-wrapper {
	    min-width: 50px;
	}
	.message-wrapper > .message > .content-wrapper > .content-body > .info-wrapper > .time-wrapper {
	    font-size: 0.5em;
	    padding: 0 0.25em;
	}
	.message-wrapper > .message > .content-wrapper > .content-body > .info-wrapper > .number-wrapper {
	    font-size: 0.5em;
	    padding: 0 0.35em;
	    color: orange;
	    font-weight: bold;
	}
	.message-wrapper > .message > .content-wrapper > .content-footer {
	    padding-top: 0.05em;
	    align-items: flex-end;
	}
	.message-wrapper > .message > .content-wrapper > .content-footer > .heart {
	    display: inline-block;
	    padding-left: 0.75em;
	}
	.message-wrapper > .message > .content-wrapper > .content-footer > .heart-number {
	    display: inline-block;
	    padding-left: 0.28em;
	    font-size: 0.7em;
	    color: #c23616;
	}
	
	.message-wrapper > .message.my > .content-wrapper > .content-header {
	    text-align: right;
	    padding-right: 0.5em;
	}
	.message-wrapper > .message.my > .content-wrapper > .content-body {
	    flex-direction: row-reverse;
	}
	.message-wrapper > .message.my > .content-wrapper > .content-body > .message-wrapper {
	    background-color: rgba(75, 161, 255);
	    color: white;
	}
	.message-wrapper > .message.my > .content-wrapper > .content-body > .info-wrapper > .time-wrapper {
	    text-align: right;
	    padding-right: 0.45em;
	}
	.message-wrapper > .message.my > .content-wrapper > .content-body > .info-wrapper > .number-wrapper {
	    text-align: right;
	    padding-right: 0.45em;
	}
	.message-wrapper > .message.my > .content-wrapper > .content-footer {
	    text-align: right;
	}
	.message-wrapper > .message.my > .content-wrapper > .content-footer > .heart {
	    padding-left: 0.65em;
	}
	.message-wrapper > .message.my > .content-wrapper > .content-footer >.heart-number {
	    padding-left: 0.28em;
	    font-size: 0.7em;
	    padding-right: 1.1em;
	    color: #c23616;
	}
</style>

</head>
<body>

	<div id="app">
	
		<div class="container-fluid">
			<div class="row">
				<div class="row mt-3" style="width:1000px;margin-bottom:0;margin-left:7px; margin-right:0px;height:70px;">
					<!-- 로그인한 회원 프로필 -->
					<div class="card col-3" style="width:290px;border-radius:0;padding-bottom:0;align-content: center;flex-wrap: wrap;flex-direction: row;">
						<div style="padding-left: 0.4em;">
							<a href="#"   style="color: black; text-decoration: none;">
							<img src="https://via.placeholder.com/45x45?text=P" style="border-radius: 50%; position:absolute; top:0.75em" >
								<span style="padding-left:3.5em; word-wrap:normal;">
										${sessionScope.memberNick}
								</span>
							</a>
						</div>
						<span style="position:absolute; top:21px; right:0; margin-right:30px;">
							<i class="fa-regular fa-pen-to-square fa-lg" style="cursor:pointer;" @click="fetchFollowerList(); showModal();"></i>
						</span>
					</div>
					
					<!-- 채팅방 이름 -->
					<div class="card col-8" style="border-radius:0;border-left:0;align-content: center;flex-wrap: wrap;flex-direction: row;">
						채팅방 이름
						<span style="position:absolute; top:21px; right:0; margin-right:30px;">
							<i class="fa-solid fa-circle-info fa-xl" style="cursor:pointer; color: #b2bec3"></i>
						</span>
					</div>
				</div>
				
				<div class="row" style="width:1000px;margin-left:7px; margin-right:100px; margin-top:0; height:70vh">
					<!-- 채팅방 목록 -->
					<div class="card col-3" style="width:290px;border-radius:0;border-top:none;padding:0;">
						<div class="card-body" style="padding:0;padding-top:10px;">
						<div class="room" v-for="(room, index) in dmRoomList" :key="room.roomNo">
						    <h5>
						    <a :href="'channel?room=' + room.roomNo" style="color: black; text-decoration: none;">
							    {{room.roomName}}
							</a>
						    </h5>
						</div>
						</div>
					</div>
					
					<!-- 채팅창 -->
					<div class="card col-8" style="border-radius:0;border-top:none;border-left:0;padding-right:0;">
						<div class="card-body" style="padding:0;" v-show="isRoomJoin">
					        <div class="message-wrapper">
					            <div class="message" v-for="(message, index) in messageList" :key="message.no" :class="{my:checkMyMessage(index)}">
					                <div class="profile-wrapper" v-if="!checkMyMessage(index)">
                                			<img src="https://via.placeholder.com/100x100?text=P" width="100%" v-if="!checkSameTime(index)">
					                </div>
					                
					                <div class="content-wrapper">
						                <div class="content-header" v-if="!checkSameTime(index)">
						                	{{message.memberNick}}
						                </div>
						                <div class="content-body">
							                <div class="message-wrapper">{{message.content}}</div>
							                <div class="info-wrapper">
							                	<div class="number-wrapper">{{unreadCount[index]}}</div>
							                	<div class="time-wrapper" v-if="calculateDisplay(index)">{{timeFormat(message.time)}}</div>
							                </div>
						                	<i class="fa-solid fa-x fa-xs" v-on:click="deleteMessage(index)" style="padding-bottom: 0.51em;"></i>
						                </div>
						                <div class="content-footer">
						                	<div class=heart><i class="fa-solid fa-heart fa-xs" style="color: #c23616;"></i></div>
							                <div class=heart-number>23</div>
						                </div>
						            </div>
						            
					            </div>
					        </div>
					        
					        <div class="row justify-content-between" style="margin-top:10px;margin-bottom:10px;padding-left:calc(var(--bs-gutter-x) * .5);padding-right:calc(var(--bs-gutter-x) * .5);height:38px;">
						        <!-- 입력창 -->
						        <input type="text" v-model="text" v-on:input="text=$event.target.value" placeholder="메세지 입력" style="border-radius: 3rem;width:75%;">
						        <button v-on:click="sendMessage" style="border-radius: 3rem; width:25%;">전송</button>
					        </div>
	        
						</div>
					</div>
					
				</div>
				
			</div>
		</div>
		
		<!-- 회원 목록을 모달창으로 불러오기 -->
		<div class="modal fade" tabindex="-1" id="memberListModal" data-bs-backdrop="static" ref="memberListModal">
		  <div class="modal-dialog modal-dialog-scrollable modal-fullscreen-sm-down" style="width:400px; margin: 0; position: fixed; top: 60%; left: 50%; transform: translate(-50%, -50%);">
		    <div class="modal-content" style="align-content: center;flex-wrap: wrap;">
		      <div class="modal-header" style="width:300px;">
		        <h4 class="modal-title" id="memberListModalLabel" style="font-weight: bold; color: #222f3e;">메세지 보내기</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" style="width:300px;">
		        <div style="margin-bottom:10px;">
		          <input type="text" placeholder="검색" v-model="keyword" class="form-control me-sm-2" @input="keyword = $event.target.value">
		        </div>
		        <div v-if="searchDmList.length==0"  v-for="(member,index) in dmMemberList" :key="index" style="margin-top:20px;position:relative;">
		          <img src="https://via.placeholder.com/40x40?text=P" style="border-radius: 50%; position:absolute; top:0.3em" >
		          <span style="padding-left:3.3em;font-size:0.9em;">{{member.memberNick}}</span>
		          <br>
		          <span style="padding-left:4.2em; padding-bottom: 1.5m; font-size:0.75em;color:#7f8c8d;">{{member.memberName}}</span>
		          <span style="position:absolute;right:0;top:10px;">
		            <button class="btn btn-outline-primary" style="padding: 0.3rem 0.5rem;font-weight: 100;line-height: 1;font-size:0.8em;" @click="createRoomAndInvite(member.memberNo)" data-bs-dismiss="modal" data-bs-target="#my-modal" aria-label="Close" >
		              채팅
		            </button>
		          </span>
		        </div>
		        <div v-if="searchDmList.length>0"  v-for="(member,index) in searchDmList" :key="index" style="margin-top:20px;position:relative;">
		          <img src="https://via.placeholder.com/40x40?text=P" style="border-radius: 50%; position:absolute; top:0.3em" >
		          <span style="padding-left:3.3em;font-size:0.9em;">{{member.memberNick}}</span>
		          <br>
		          <span style="padding-left:4.2em; padding-bottom: 1.5m; font-size:0.75em;color:#7f8c8d;">{{member.memberName}}</span>
		          <span style="position:absolute;right:0;top:10px;">
		            <button class="btn btn-outline-primary" style="padding: 0.3rem 0.5rem;font-weight: 100;line-height: 1;font-size:0.85em;" @click="createRoomAndInvite(member.memberNo)" data-bs-dismiss="modal" data-bs-target="#my-modal" aria-label="Close">
		              채팅
		            </button>
		          </span>
		        </div>
		        
		      </div>
		    </div>
		  </div>
		</div>
		
	</div>
    
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>

    <script>
        Vue.createApp({
            data(){
                return {
                    text:"",//사용자가 입력하는 내용
                    messageList:[],//채팅 기록
                    memberNick:"${sessionScope.memberNick}",
                    memberNo:"${sessionScope.memberNo}",
                    socket:null,//웹소켓 연결 객체
                    modal:null, //modal 제어
                    dmMemberList:[],//팔로워 회원 목록
                    
                    //차단한 회원을 제외한 전체 회원 검색
                    searchDmList:[],
                    keyword:"",
                    
                    dmRoomList: [], //채팅방 목록
                    isRoomJoin:false,
                    
                    //채팅방 참가자 시간 정보 리스트
                    userTimeList:[],
                    //읽지 않은 수
                    unreadCount:[],
                    
                    //초대
                    inviterNo: "",
                    roomNo:"",
                    inviteeNo:"",
                    
                };
            },
            methods:{
            	// 메세지 불러오는 함수
            	async loadMessage() {
            	    const roomNo = new URLSearchParams(location.search).get("room");
            	    if(roomNo==null){
            	    	this.isRoomJoin=false;
            	    	return;
            	    }
            	    this.isRoomJoin=true;
            	    const url = "${pageContext.request.contextPath}/rest/message/"+roomNo;

            	    try {
            	        const resp = await axios.get(url);
            	        this.messageList = resp.data.map(msg => JSON.parse(msg.messageContent));
            	    } 
            	    catch (err) {
            	        console.error("메세지를 불러올 수 없습니다.");
            	    }
            	},
            	// 메세지 리스트 불러오는 함수
           		displayMessageList(resp) {
				    this.messageList = resp.map((msg) => {
				        const msgContent = JSON.parse(msg.messageContent);
				        return {
				            messageNo: msgContent.messageNo,  // 메세지 삭제를 위해 추가
				            memberNick: msgContent.memberNick,
				            content: msgContent.content,
				            time: this.timeFormat(msgContent.time),
				        };
				    });
				},
				//모달창
				showModal(){
                    if(this.modal == null) return;
                    this.modal.show();
                },
                hideModal(){
                    if(this.modal == null) return;
                    this.modal.hide();
                },
			    connect(){
            		const url = "${pageContext.request.contextPath}/ws/channel";
            		this.socket = new SockJS(url);
            		
            		//this = view이므로 개조 (this가 웹소켓이어야 사용 가능)
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
                    const data = { type:2, room:room };
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
            		const message = JSON.parse(e.data);
            		
            		//리스트 형태(시간정보 배열) 일때
            		if(message.length>0){
            			this.userTimeList=[...message];
            		}
            		//메세지 일 때
            		else{
	            		this.messageList.push(message);
            		}
            	},
            	sendMessage() {
            		if(this.text.length == 0) return;
            		this.socket.send(this.jsonText);
            		this.text = "";
            	},
            	timeFormat(time) {
            		return moment(time).format("A h:mm");
            	},
            	//메세지 삭제
            	deleteMessage(index) {
            	    const messageNo = this.messageList[index].messageNo;
            	    const data = { type: 3, messageNo: messageNo, memberNo: this.memberNo };
            	    this.socket.send(JSON.stringify(data));
            	    this.loadMessage();
            	},
            	//디자인 - 시간
                checkSameTime(index) {
                    if(index == 0) return false;
                    const before = this.messageList[index-1];
                    const current = this.messageList[index];
                    
                    if(before.memberNick != current.memberNick) return false;
                    if(this.timeFormat(before.time) != this.timeFormat(current.time)) return false;
                    return true;
               },
               //디자인 - 프로필
               calculateDisplay(index) {
                    if(index + 1 == this.messageList.length) return true;
                    const after = this.messageList[index+1];
                    const current = this.messageList[index];
                    if(current.memberNick != after.memberNick) return true;
                    if(this.timeFormat(current.time) != this.timeFormat(after.time)) return true;
                    return false;
               },
               //디자인 - 본인 메세지
               checkMyMessage(index) {
                    if(this.memberNick == this.messageList[index].memberNick) return true;
                    return false;
               },
               //팔로우 회원 목록
               async fetchFollowerList() {
            	   const url = "${pageContext.request.contextPath}/rest/dmMemberList";
            	    try {
            	      const resp = await axios.get(url);
            	      this.dmMemberList.splice(0); //전체삭제
	                  this.dmMemberList.push(...resp.data);
            	    } 
            	    catch (error) {
            	      console.error(error);
            	    }
            	},
                //차단한 회원을 제외한 전체 회원 검색
				async chooseDmSearch() {
				    const url = "${pageContext.request.contextPath}/rest/dmMemberSearch";
				    try {
				        const resp = await axios.get(url, {
				            params: {
				                keyword: this.keyword
				            }
				        });
				        this.searchDmList.splice(0); //전체삭제
	                    this.searchDmList.push(...resp.data);
				    } catch (error) {
				        console.error(error);
				    }
				},			
				//로그인한 회원의 채팅방 목록
				async fetchDmRoomList() {
				    try {
				        const resp = await axios.get("${pageContext.request.contextPath}/rest/dmRoomList");
				        this.dmRoomList.push(...resp.data);
				    } catch (error) {
				        console.error(error); 
				    }
				},
				//채팅방 생성 및 입장, 초대
				async createRoomAndInvite(memberNo) {
				    try {
				        // 방 생성
				        const dmRoomVO = await axios.post("${pageContext.request.contextPath}/rest/createChatRoom");
				        const roomNo = dmRoomVO.data.roomNo;
				        
				        // 방 입장
				        const user = {
				            roomNo,
				            memberNo: this.memberNo
				        };
				        await axios.post("${pageContext.request.contextPath}/rest/joinDmRoom", user);

				        // 초대자의 정보를 설정
				        const invite = {
				            inviterNo: this.memberNo,
				            roomNo: roomNo,
				            inviteeNo: memberNo
				        };

				        // 초대 실행
				        const inviteUrl = "${pageContext.request.contextPath}/rest/inviteUser";
				        await axios.post(inviteUrl, invite);

				        console.log("방 생성, 입장, 초대가 성공적으로 수행되었습니다.");
				    } catch (error) {
				        console.error("방 생성, 입장, 초대 중 오류가 발생했습니다.", error);
				    }
				},
            },
            watch:{
            	//검색
            	keyword:_.throttle(function(){
        			if(this.keyword=="") {
        				this.searchDmList = [];
        				return;
        			}
        			this.chooseDmSearch();
        		}, 200),
        		//메세지 읽음 표시
        		userTimeList:{
        			deep:true,
        			handler:function(){
	            		let joiner = this.userTimeList.length;
	            		for(let j=0; j<this.messageList.length; j++){
		            		let count=0;
		            		for(let i=0; i<this.userTimeList.length; i++){
		            			let timeTemp=this.messageList[j].time
		            			if(this.userTimeList[i]>=timeTemp){
		            				count++;
		            			}
		            		}
		            		this.unreadCount[j]= joiner-count;
	            		}
        			}
        		}
            },
            computed:{ 
            	jsonText() {
            		return JSON.stringify({ type: 1, content: this.text });
            	},
            },
            created(){
            	//웹소켓 연결 코드
            	this.connect();
            	//메시지 불러오기
                this.loadMessage();
            	//로그인한 회원의 채팅방 목록
            	this.fetchDmRoomList();
            },
			mounted(){
				//Bootstrap modal 인스턴스를 초기화하고 저장
				this.modal = new bootstrap.Modal(this.$refs.memberListModal);
					    
				//검색창 초기화
			    $('#memberListModal').on('hidden.bs.modal', () => {
			    	this.keyword = '';
			        this.searchDmList = [];
			    });
	          },
        }).mount("#app");
    </script>
    
</body>
</html>
