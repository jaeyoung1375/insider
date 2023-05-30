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
	<!-- SockJS라이브러리 의존성 추가  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>

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
	
     html, body{
          width: 100%;
          height: 100%;
          margin: 0;
          padding: 0;
      }
      .wrap{
          width: 100%;
          height: 100%;
          display: flex;
          justify-content: center;
          align-items: center;
      }
      body[data-darkmode=on] {
          background-color: #1e1f21;
          color: #e8e8e8 !important;
      }
      /* Darkmode Toggle */
      body[data-darkmode=on] .darkmode > .inner{
          background-color: rgba(255,255,255,0.25);
      }
      .darkmode > .inner{
          position: relative;
          display: inline-flex;
          padding: 5px;
          border-radius: 1.5em;
          background-color: rgba(0,0,0,0.1);
      }
      .darkmode label {
          cursor: pointer;
      }
      .darkmode label:first-of-type{
          padding: 5px 5px 5px 10px;
          border-radius: 50% 0 0 50%;
      }
      .darkmode label:last-of-type{
          padding: 5px 10px 5px 5px;
          border-radius: 0 50% 50% 0;
      }
      .darkmode i{
          font-size: 1.5em;
          color: #aaa;
      }
      .darkmode input[type=radio]{
          display: none;
      }
      .darkmode input[type=radio]:checked + label > i {
          color: #fff;
          transition: all 0.35s ease-in-out;
      }
      .darkmode .darkmode-bg{
          width: 39px;
          height: 34px;
          position: absolute;
          left: 5px;
          border-radius: 50px 15px 15px 50px;
          z-index: -1;
          transition: all 0.35s ease-in-out;
          background-color: #03a9f4;
      }
      #toggle-radio-dark:checked ~ .darkmode-bg{
          border-radius: 15px 50px 50px 15px;
          top: 5px;
          left: 44px;
      }
      
 	  .nav-item { 
 		  position: relative; 
 	  } 
		
 	  .nav-link { 
 		  display: flex; 
 		  align-items: center; 
	  } 
		
 	 .modal-window { 
 		  position: absolute; 
 		  top: calc(100% + 10px); 
 		  left: 50%; 
 		  transform: translateX(-50%); 
 		  border-radius: 1.5em; 
 		  border: 1px solid #000; 
 		  width: 400px; 
 		  background-color: #fff; 
 		  z-index: 999; 
 		  padding: 10px; 
 		  overflow-y: auto; 
 		  overflow-x: hidden;  
 	  } 

 	  .modal-content { 
 	  	margin: 10px; 
 	  } 
	
 	  .modal-header { 
 		  text-align: center; 
 		  margin-bottom: 10px; 
 	  } 
	
 	.modal-body { 
 	  max-height: 300px;  
 	  overflow-x: hidden;  
 	  overflow-y: auto;  
 	} 

 	.modal-footer { 
 	  -align: center; 
 	  margin-top: 10px; 
 	} 
	
 	.notification-list { 
 	  list-style-type: none; 
 	  padding: 0; 
 	  margin: 0; 
 	} 
	
 	.notification-list li { 
 	  margin-bottom: 10px; 
 	} 

</style>

 <script>
  document.addEventListener('DOMContentLoaded', function() {

    const darkModeEnabled = localStorage.getItem('darkmode') === 'on';

    document.body.dataset.darkmode = darkModeEnabled ? 'on' : 'off';

    const toggleRadioDark = document.querySelector('#toggle-radio-dark');

    toggleRadioDark.checked = darkModeEnabled;

    document.querySelector('.darkmode').addEventListener('click', function(e) {
      if (e.target.classList.contains('todark')) {

        document.body.dataset.darkmode = 'on';
        localStorage.setItem('darkmode', 'on');
      } else if (e.target.classList.contains('tolight')) {

        document.body.dataset.darkmode = 'off';
        localStorage.setItem('darkmode', 'off');
      }
    });
  });
</script>




<body>
	<main>
		<header id="aside">	
			<nav class="navbar navbar-expand-lg navbar-light mt-3">
				<div class="container-fluid">
					<a class="navbar-brand" href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/static/image/logo.png" width="50" height="50"></a>
					<a href="${pageContext.request.contextPath}/" class="logo">insider</a>
    				<div class="wrap">
			        	<div class="darkmode">
			            	<div class="inner">
			                	<input type="radio" name="toggle" id="toggle-radio-light" checked><label for="toggle-radio-light" class="tolight"><i class="fas fa-sun tolight"></i></label>
			                	<input type="radio" name="toggle" id="toggle-radio-dark"><label for="toggle-radio-dark" class="todark"><i class="fas fa-moon todark"></i></label>
			                	<div class="darkmode-bg"></div>
			            	</div>
			        	</div>
			    	</div>
			    	
					<div class="collapse navbar-collapse justify-content-end" id="navbarColor03">
						<ul class="navbar-nav">
						<!-- 검색 -->
							<li class="nav-item mt-2">
								<a class="nav-link" href="${pageContext.request.contextPath}/search"><i class="fa-regular fa-solid fa-magnifying-glass" style="font-size: 45px;"></i></a>
							</li>
						<!-- 알림 -->
							 <li class="nav-item mt-2">
							    <a class="nav-link" @click="toggleModal"><i class="fa-regular fa-heart"></i></a>
							
							    <div class="modal-window" v-if="showModal">
							      <div class="modal-content">
							        <div class="modal-header">
							          <h6>알림창</h6>
							        </div>
							        <div class="modal-body">
							          <ul class="notification-list">
							            <li>Notification 1</li>
							            <li>Notification 2</li>
							            <li>Notification 3</li>
							          </ul>
							        </div>
							        <div class="modal-footer">
							        </div>
							      </div>
							    </div>
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
				showModal:false,
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
			
		    toggleModal() {
			      this.showModal = !this.showModal;
			},
         },	

		created(){
			//데이터 불러오는 영역
		},
		watch:{
			//감시영역
		},
        
	}).mount("#aside");

</script>


