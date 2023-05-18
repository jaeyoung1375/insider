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
							<li class="nav-item mt-2">
								<a class="nav-link" href="#"><i class="fa-regular fa-heart"></i></a>
							</li>
						<!-- dm -->
							<li class="nav-item mt-2">
								<a class="nav-link" href="#"><i class="fa-regular fa-message mt-1" style="font-size: 45px;"></i></a>
							</li>
						<!-- 게시물작성 -->
							<li class="nav-item mt-2">
								<a class="nav-link" href="attachment/test"><i class="fa-regular fa-square-plus"></i></a>
							</li>
						<!-- 프로필 -->
							<li class="nav-item">
								<a class="nav-link" href="#"><img src="${pageContext.request.contextPath}/static/image/user.jpg" width="70" height="70"></a>
							</li>
						</ul>
					</div>
				</div>
			</nav>
			<aside style="position:fixed; left:0" >
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
  
<script>
	Vue.createApp({
		data() {
			return {
				sideMenu:false,
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
			}
		},
		created(){
			//데이터 불러오는 영역
		},
		watch:{
			//감시영역
		}
	}).mount("#aside");
</script>
 
	<section>

