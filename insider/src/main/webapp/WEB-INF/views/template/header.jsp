<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insider</title>
	<!-- BootStrap CDN -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<!-- commons.css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/commons.css" />
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
			
		<header>	
			<nav class="navbar navbar-expand-lg navbar-light mt-3">
				<div class="container-fluid">
					<a class="navbar-brand" href="/"><img src="/static/image/logo.png" width="50px" height="50px"></a>
<!-- 					<a class="navbar-brand" href="/"><img src="./image/insta.png" width="50px" height="50px"></a> -->
					<a href="/" class="logo">insider</a>
    
					<div class="collapse navbar-collapse justify-content-end" id="navbarColor03">
						<ul class="navbar-nav">
						<!-- 검색 -->
							<li class="nav-item mt-2">
								<a class="nav-link" href="search"><i class="fa-regular fa-solid fa-magnifying-glass" style="font-size: 45px;"></i></a>
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
								<a class="nav-link" href="attachment/file"><i class="fa-regular fa-square-plus"></i></a>
							</li>
						<!-- 프로필 -->
							<li class="nav-item">
								<a class="nav-link" href="#"><img src="/static/image/user.jpg" width="70px" height="70px"></a>
							</li>
						</ul>
					</div>
				</div>
			</nav>
		</header>
		
		
	<section>

