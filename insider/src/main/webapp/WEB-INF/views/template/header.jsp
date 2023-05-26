<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insider</title>
	<script>
		<!-- 전역변수 contextPath 설정 -->
		const contextPath = "${pageContext.request.contextPath}";
		<!-- MemberNo -->
		const memberNo = "${sessionScope.memberNo}";
	</script>
	<!-- BootStrap CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<!-- commons.css -->
	<link rel="stylesheet" type="text/css" href="/static/css/commons.css" />
	<!-- font-awesome cdn -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"/>
	<!-- vue, axios, lodash cdn -->
	<script src="https://unpkg.com/vue@3.2.36"></script>
	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
	<!-- jquery cdn -->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<style>
	main{
		width:1000px;
		margin: 0 auto;
	}

	.logo{
		font-size: 50px;
		color: black;
	}

	.nav-item > a {
		font-size: 51px;
		
	}

	.navbar-light .navbar-nav .nav-link {
		color: black;
	}
	
/* 	알람테스트 */

        .fa-solid{
            width: 30px;
        }

        
        .card-text{
            font-size: 0.8em;
        }
        
        .show {
        	display:block!important;
        }
        
        .showAlarm{
        	display:block!important;
        }
	
	
</style>

<body>
	<main>
		<header id="aside">	
			<nav class="navbar navbar-expand-lg navbar-light mt-3">
				<div class="container-fluid">
					<a class="navbar-brand" href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/static/image/logo.png" width="50" height="50"></a>
					<a href="${pageContext.request.contextPath}/" class="logo">insider</a>
    
					<div class="collapse navbar-collapse justify-content-end" id="navbarColor03">
						<ul class="navbar-nav">
						<!-- 검색 -->
							<li class="nav-item mt-2">
								<a class="nav-link" href="${pageContext.request.contextPath}/search"><i class="fa-regular fa-solid fa-magnifying-glass" style="font-size: 45px;"></i></a>
							</li>
						<!-- 알림 -->
						    <li class="nav-item" style="position: relative;">
                                <a class="nav-link" style="cursor: pointer;" @click.stop="noticeOn(),loadAlarm(),checkAlarm()">
                                    <i class="fa-regular fa-heart"></i>
                                    <i class="fa-solid fa-circle" :class="{'showAlarm':insiderAlarm}" style="display:none;position: absolute;font-size: 0.5em;color: #eb6864;left: 10%;top: 60%;"></i>
                                </a>
                                <div v-if="noticeValue" :class="{'show':noticeValue}" style="position: absolute; right: -150px; width: 450px; max-height: 300px; overflow: auto; border-radius: 0.2em; box-shadow: rgba(0, 0, 0, 0.15) 0px 5px 15px 0px;display:none;" @click.stop>
                                    <div class="card border-light">
                                        <div v-for="(alarm, index) in alarmList" :key="index" class="card-body" style="padding:0;">
                                          <p class="card-title"><hr v-if="alarmTime(index)!=''&&alarmTime(index)!='오늘'">{{alarmTime(index)}}</p>
                                          <div style="position:relative;font-size:0.7em;font-weight:100;height: 30px;">
                                          	<a :href="'${pageContext.request.contextPath}/member/page?memberNo='+alarm.memberNo" style="color:black;text-decoration:none;">
	                                          	<img v-if="alarm.attachmentNo > 0" :src="'${pageContext.request.contextPath}/file/download/'+alarm.attachmentNo" width="30" height="30" style="border-radius: 70%;position:absolute;top:0;">
			                                	<img v-else src="${pageContext.request.contextPath}/image/user.jpg" width="30" style="border-radius: 70%;position:absolute;top:0;">
												<span style="padding-left:35px;font-weight:600;">{{alarm.memberNick}}</span>
                                          	</a>
											<span v-if="alarm.type==0&&alarm.etc==1">님이 <a :href="'${pageContext.request.contextPath}/member/page?memberNo='+${login}+'&boardNo='+alarm.boardNo+'&type='+alarm.type" style="text-decoration:none;">게시글에 좋아요를 누르셨습니다!</a></span>
											<span v-if="alarm.type==0&&alarm.etc>1">님 외 <a :href="'${pageContext.request.contextPath}/member/page?memberNo='+${login}+'&boardNo='+alarm.boardNo+'&type='+alarm.type" style="text-decoration:none;">{{alarm.etc-1}}명이 게시글에 좋아요를 누르셨습니다!</a></span>
											<span v-if="alarm.type==1&&alarm.etc==1">님이 <a :href="'${pageContext.request.contextPath}/member/page?memberNo='+${login}+'&boardNo='+alarm.boardNo+'&type='+alarm.type" style="text-decoration:none;">게시글에 좋아요를 누르셨습니다!</a></span>
											<span v-if="alarm.type==1&&alarm.etc>1">님 외 <a :href="'${pageContext.request.contextPath}/member/page?memberNo='+${login}+'&boardNo='+alarm.boardNo+'&type='+alarm.type" style="text-decoration:none;">{{alarm.etc-1}}명이 게시글에 좋아요를 누르셨습니다!</a></span>
											<span v-if="alarm.type==2&&alarm.etc==0">
												<span>님이 팔로우 요청을 하셨습니다!</span>
												<span style="position:absolute; right:0;">
													<button class="btn btn-outline-primary" style="margin-right: 2px;padding: 5px 5px;font-weight: 100;font-size: 0.9em;" @click="followAccept(alarm.memberNo)">승인</button>
													<button class="btn btn-primary" style="margin-right: 2px;padding: 5px 5px;font-weight: 100;font-size: 0.9em;" @click="followRefuse(alarm.memberNo)">취소</button>
												</span>
											</span>
											<span v-if="alarm.type==2&&alarm.etc==1">님이 팔로우 하셨습니다!</span>
											<span v-if="alarm.type==3&&alarm.etc==1">님이 <a :href="'${pageContext.request.contextPath}/member/page?memberNo='+${login}+'&boardNo='+alarm.boardNo+'&type='+alarm.type" style="text-decoration:none;">게시글에 댓글을 작성하셨습니다!</a></span>
											<span v-if="alarm.type==3&&alarm.etc>1">님 외 <a :href="'${pageContext.request.contextPath}/member/page?memberNo='+${login}+'&boardNo='+alarm.boardNo+'&type='+alarm.type" style="text-decoration:none;">{{alarm.etc-1}}명이 게시글에 댓글을 작성하셨습니다!</a></span>
											<span v-if="alarm.type==4&&alarm.etc==1">님이 <a :href="'${pageContext.request.contextPath}/member/page?memberNo='+${login}+'&boardNo='+alarm.boardNo+'&type='+alarm.type" style="text-decoration:none;">게시글에 댓글을 작성하셨습니다!</a></span>
											<span v-if="alarm.type==4&&alarm.etc>1">님 외 <a :href="'${pageContext.request.contextPath}/member/page?memberNo='+${login}+'&boardNo='+alarm.boardNo+'&type='+alarm.type" style="text-decoration:none;">{{alarm.etc-1}}명이 게시글에 댓글을 작성하셨습니다!</a></span>
											
                                          </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/member/page?memberNo=${login}">
                                    <i class="fa-regular fa-heart"></i>
                                </a>
                            </li>
						<!-- dm -->
							<li class="nav-item mt-2">
								<a class="nav-link" href="${pageContext.request.contextPath}/dm/channel"><i class="fa-regular fa-message mt-1" style="font-size: 45px;"></i></a>
							</li>
						<!-- 게시물작성 -->
							<li class="nav-item mt-2">
								<a class="nav-link" href="${pageContext.request.contextPath}/board/insert"><i class="fa-regular fa-square-plus"></i></a>
							</li>
						<!-- 프로필 -->
							<li class="nav-item">
								<a class="nav-link" href="${pageContext.request.contextPath}/member/${socialUser.memberNick}"><img src="${pageContext.request.contextPath}/static/image/user.jpg" width="70" height="70"></a>
							</li>
						</ul>
					</div>
				</div>
			</nav>
			<aside style="position:fixed; left:0; top:50%" >
				<div class="dropdown" :class="{'show':sideMenu}">
					<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" @click="showSideMenu()">
						<i class="fa-solid fa-bars"></i>
					</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" v-show="sideMenu" :class="{'show' : sideMenu}">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/setting?page=1">환경설정</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/">관리자 메뉴</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/login">로그인</a>
						<c:if test="${socialUser != null}">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
						</c:if>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
					</div>
				</div>
			</aside>
		</header>
	</main>
</body>
	
<script>
	Vue.createApp({
		data() {
			return {
				sideMenu:false,
				
				noticeValue:false,
                searchValue:false,
                keyword:"",
                
                searchList:[],
                searchLength:null,
                
                alarmList:[],
                
                chatAlarm:false,
                insiderAlarm:false,
                
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
			showSideMenu(){
				if(this.sideMenu){
					this.sideMenu=false;
				}
				else{
					this.sideMenu=true;
				}
			},
	      
	      //알람 테스트
	      noticeOn(){
              if(this.noticeValue) {
                  this.noticeValue = false;
              }else{
                  this.noticeValue = true;
                  this.searchValue = false;
              }
              
          },
          searchOn(){
                  this.searchValue = true;
                  this.noticeValue = false;
          },
          searchOff(){
                  /* this.searchValue = false; */
                  this.noticeValue = false;
          },
          
          //알람 읽은 체크
          checkAlarm(){
          	axios({
          		url:"${pageContext.request.contextPath}/rest/alarm/check",
          		method: "Put",
          	})
          	.then(resp=>{
          		this.insiderAlarm = false;
          	})
          },
          
          
          
          //알람 불러오기
          loadAlarm(){
          	axios({
          		url:"${pageContext.request.contextPath}/rest/alarm",
          		method:"get",
          	})
          	.then(resp=>{
          		console.log("허허");
					this.alarmList = resp.data;       		
          	});
          	
          },
          
          //알람 날짜계산
          alarmTime(index){
          		const today = moment().format("YYYY-MM-DD");
          		const target = moment(this.alarmList[index].alarmTime).format("YYYY-MM-DD");
          		console.log(index +"ㅎ"+target);
          		if(index==0&&today==target){
          			return "오늘";
          		}
          		else if(index!=0&&today==target){
          			return "";
          		}
          		
          		if(index!=0){
              		const target2 = moment(this.alarmList[index-1].alarmTime).format("YYYY-MM-DD");
              		const thisWeek = moment(moment().startOf('week').valueOf()).format("YYYY-MM-DD");
          		
              		if(thisWeek<=target&&today==target2){
		                	return "이번 주";
              		}else if(thisWeek<=target&&target2!=today){
              			return "";
              		}
              		const thisMonth = moment(moment().startOf('month').valueOf()).format("YYYY-MM-DD");
              		console.log(thisMonth);
             			if(thisMonth<=target&&thisWeek<=target2){
             				return "이번 달";
             			}else if(thisMonth<=target&&thisWeek>target2){
             				return "";
             			}else if(thisMonth>target&&thisMonth<=target2){
	                		return "이전 활동";
             			}
          		}
          		return "";
          },	
          
          followAccept(memberNo){
          	axios({
          		url : "${pageContext.request.contextPath}/rest/follow/follow_accept",
          		method:"post",
          		params:{
          			followWho : memberNo
          		}
          	})
          	.then(resp=>{
          		this.loadAlarm();
          		console.log("승인");
          	});
          },
          
          followRefuse(memberNo){
          	axios({
          		url : "${pageContext.request.contextPath}/rest/follow/follow_refuse",
          		method : "Post",
          		params : {
          			followWho : memberNo
          		}
          	})
          	.then(resp=>{
          		this.loadAlarm();
          		console.log("거절");
          	});
          }
	      
		},
		watch:{
			//감시영역
			
			//알람 테스트
        	keyword:_.throttle(function(){
        		if(!this.searchValue) this.searchValue=true;
        		if(this.keyword == "") return;
                axios({ 
                    url:"${pageContext.request.contextPath}/rest/search",
                    method:"get",
                    params:{
                    	keyword : this.keyword
                    }
                })
                .then((resp)=>{
                	this.searchLength = resp.data.length;
                    this.searchList = resp.data;
                })
            }, 200),
        },
        //데이터 및 구성요소 초기화 전
        beforeCreate(){},
        //데이터 및 구성요소 초기화 후, data에 접근 가능하므로 ajax를 여기서 사용하여 데이터를 불러온다
        created(){
        	if(${hashTagName != null}){
        		this.keyword = "${hashTagName}"
        	}
        	
        	axios({
        		url:"${pageContext.request.contextPath}/rest/alarm/is_insider",
        		method:"get"
        	})
        	.then(resp=>{
        		if(resp.data>0){
        			this.insiderAlarm = true;
        		}
        	});
        	
        	axios({
        		url:"${pageContext.request.contextPath}/rest/alarm/is_chat",
        		method:"get"
        	})
        	.then(resp=>{
        		if(resp.data>0){
        			this.chatAlarm = true;
        		}
        	});
        },
        boeforeMount(){},
        
        
        mounted(){
        	var uri = "${pageContext.request.contextPath}/ws/dm";
    		
    		//접속
    		socket = new SockJS(uri);
    		
    		socket.onopen = event => {
    			//접속하자마자 나의 채널명을 서버로 전송해야한다(입장메세지)
    			var message = {
    				type:1,
    			};
    			var json = JSON.stringify(message);
    			socket.send(json);
    		};
    		
    		socket.onmessage = (event) => {
    			var data = JSON.parse(event.data);//json을 객체로 복구
    			console.log("메세지가 올텐데요");
    			console.log(data.who);
    			console.log(${login});
    			if(data.who==${login}&&data.dmType==3){
    				console.log("알람 수신 (채팅)");
    				this.chatAlarm = true;
    			}
    			if(data.who==${login}&&data.dmType==4){
    				console.log("알람 수신 (인사이더)");
    				this.insiderAlarm = true;
    			}
    		};
        	
        	$("body,html").click(resp=>{
                this.noticeValue = false;
                this.searchValue = false;
            });
        	this.searchValue=false;
        },
        beforeUpdate(){},
        updated(){},
        

	})
	.mount("#aside");

</script>


