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
		<!-- memberLevel -->
		const memberLevel = "${sessionScope.memberLevel}"
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
	<!--favicon -->
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/favicon.ico">
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/favicon.ico">

</head>
<style>
	.logo{
		font-size: 50px;
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
      
		.modal-window {
			position: absolute;
			top: calc(100% + 10px);
			left: 50%;
			transform: translateX(-50%);
			border-radius: 1.5em;
			width: 500px;
			background-color: #fff;
			z-index: 999;
			padding: 10px;
			overflow-y: auto;
			overflow-x: hidden;
			box-shadow: 4px 4px 4px -6px rgba(0, 0, 0, 0.5), 0 4px 5px rgba(0, 0, 0, 0.2);
		}


 	  .modal-content.in-header { 
 	  	margin: 10px; 
 	  } 
	
 	  .modal-header.in-header { 
 		  text-align: center; 
 		  margin-bottom: 10px; 
 	  } 
	
  	.modal-body.in-header { 
 	  max-height: 300px;  
 	  overflow-x: hidden;  
 	  overflow-y: auto;  
 	}

 	.modal-footer.in-header { 
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
 	
 	.profile {
        width: 50px;
        height: 50px;
        object-fit: cover;
        object-position: center;
        border-radius: 50%;
    } 
    
      .carousel-inner img {
        width: 470px;
        height: 480px;
        object-fit: cover;
        background-color: white;
    }
    
    .carousel-inner video {
        width: 470px;
        height: 480px;
        object-fit: cover;
    }
    
     .like {
		color:red;
		cursor: pointer;
	}
	
	.fa-heart {
		cursor: pointer;
	}
	
	.fullscreen.in-header{

            position:fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 5555;
            background-color: rgba(0, 0, 0, 0.2);
/*             display: none; */
    }

     .fullscreen > .fullscreen-container.in-header{
         position: absolute;
         left: 50%;
         top: 50%;
         
         width: 1200px;
         height: 700px;
         
         transform: translate(-50%, -50%);
     }
     
    .card-scroll.in-header{
        	overflow-y: auto;
        	-ms-overflow-style: none;
		}        
    .card-scroll.in-header::-webkit-scrollbar {
		    display: none;
	}
	
	.childReply{
		padding-left: 35px;
	}
	.childShow{
		display: none;
	} 

 
	.header-menu-option{
		font-size: 45px;
		color:inherit;
		cursor:pointer
	}
	
	 .nav-link {
        display: inline-block;
    }
</style>

<!--  <script type="text/javascript">
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
</script> -->


<body>
	<main>
		<header id="aside">	
			<nav class="mt-3">
				<div class="container-fluid" style="width:60%; max-width:900px; min-width:700px">
					<div class="row ps-5 pe-5" style="max-width:1200px">
						<div class="col-4">
							<a href="${pageContext.request.contextPath}/" class="logo d-flex align-items-center" style="color:inherit;">
								<img class="ms-4" src="${pageContext.request.contextPath}/static/image/insider2.png" width="250" height="80">
							</a>
						</div>
						<div class="col d-flex align-items-center justify-content-end">
							<div class="row">
							<!-- 관리자 -->
								<c:if test="${sessionScope.memberLevel==1}">
									<div class="col p-0 m-2">
										<a class="" href="${pageContext.request.contextPath}/admin/?adminMenu=1" style="color:inherit"><i class="fa-regular fa-id-card header-menu-option" style="font-size:43px;margin-top:2px"></i></a>
									</div>
								</c:if>
							<!-- 검색 -->
								<div class="col p-0 m-2">
									<a class="" href="${pageContext.request.contextPath}/search" style="color:inherit"><i class="fa-regular fa-solid fa-magnifying-glass header-menu-option" style="font-size:40px;margin-top:2px"></i></a>
								</div>
								<!-- 알림 --> 
								<div class="col p-0 m-2" style="position:relative;">
								  <div>
									  <a class="notice" @click="toggleModal" style="color:inherit">
									    <i class="fa-regular fa-heart header-menu-option"></i>
									    <i class="fa-solid fa-circle" v-show="hasNewNotification" style="display:none;position: absolute;font-size: 0.3em;color: #eb6864;right:15%;bottom: 17%;"></i>
									  </a>
								  </div>
								  <div class="modal-window" v-if="showModal">
								    <div class="modal-content in-header">
								      <div class="modal-header in-header"></div>
								      <div class="modal-body in-header">
								        <ul class="notification-list">
								        <div v-if="notifications.length >0">
								        	<span style="display: flex; align-items: center;"><i class="fa-sharp fa-regular fa-bell fa-shake" style="color:#f1c40f; font-size: 1.5em; margin-right: 10px;"></i>새로운 알림</span>
								        	<hr>
								          <li v-for="(notification,index) in notifications"   >
								          	<div>
									          	<a class="nav-link" :href="'${pageContext.request.contextPath}/member/'+ notification.memberNick">
									          	<img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+notification.imageURL">
									          	{{ notification.memberNick }} 님이
									          	</a>
									          	<a class="nav-link" @click="loadBoard(notification.boardNo),detailViewOn(index)" style="cursor: pointer;">
									          	<span v-if="notification.type == 1">게시글을 좋아요 하였습니다.</span>
									          	<span v-if="notification.type == 2">게시글에 댓글을 달았습니다.</span>
									          	<span v-if="notification.type == 3">회원님의 댓글을 좋아합니다.</span>
									          	<span v-if="notification.type == 4">회원님의 댓글에 댓글을 달았습니다.</span>
									          	</a>
									          	<span v-if="notification.type == 5">팔로우하였습니다.</span>
									          	<b>· {{dateCount(notification.boardTimeAuto)}}</b>
								          	</div>
								          </li>
								          <hr>
								          </div>
								          <span style="display: flex; align-items: center;"><i class="fa-regular fa-eye" style="color: #3498db; font-size: 1.5em; margin-right: 10px;"></i>읽은 알림</span>
								          <a @click="deleteAllNotifications" class="btn btn-secondary" style="position: fixed; top:6%; left:75%;transform: transform(-50%,-50%);">전체삭제</a>
								          <hr>
								          <li v-for="(notification,index) in storedNotifications" :key="notification.id">
											  <div :class="{ 'read': notification.status === 'read' }">
											    <a class="nav-link" :href="'${pageContext.request.contextPath}/member/'+ notification.memberNick">
											      <img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+notification.imageURL">
											      {{ notification.memberNick }} 님이
											    </a>
										        <a class="nav-link"  @click="loadBoard(notification.boardNo),detailViewOn(index)" style="cursor: pointer;">
									          	<span v-if="notification.type == 1">게시글을 좋아요 하였습니다.</span>
									          	<span v-if="notification.type == 2">게시글에 댓글을 달았습니다.</span>
									          	<span v-if="notification.type == 3">회원님의 댓글을 좋아합니다.</span>
									          	<span v-if="notification.type == 4">회원님의 댓글에 댓글을 달았습니다.</span>
									          	</a>
									          	<span v-if="notification.type == 5">팔로우하였습니다.</span>
											    <b>· {{dateCount(notification.boardTimeAuto)}}</b>
	<!-- 										    <a @click="deleteNotification(notification)" class="btn btn-secondary">알림삭제</a> -->
											  </div>
											</li>
								          
								        </ul>
								      </div>
								      <div class="modal-footer in-header"></div>
								    </div>
								  </div>
								</div>
							<!-- dm -->
								<div class="col p-0 m-2"style="position:relative;">
									<a class="" href="${pageContext.request.contextPath}/dm/channel" style="color:inherit">
										<i class="fa-regular fa-message header-menu-option" style="font-size:40px; margin-top:3px"></i>
					                    <i class="fa-solid fa-circle"v-if="hasUnreadMessages"style="cursor:pointer; position: absolute;font-size: 0.3em;color: #eb6864;right:15%;bottom: 17%;"></i>
					                </a>
								</div>
							<!-- 게시물작성 -->
								<div class="col p-0 m-2">
									<a class="" href="${pageContext.request.contextPath}/board/insert" style="color:inherit"><i class="fa-regular fa-square-plus header-menu-option"></i></a>
								</div>
							<!-- 프로필 -->
								<div class="col p-0 m-2">
									<a class="" style="cursor:pointer; color:inherit" @click="moveToMyPage()" ><i class="fa-regular fa-circle-user header-menu-option" style="font-size:43px;margin-top:2px"></i></a>
								</div>
							</div>
						</div>
					</div>
					
				</div>
			</nav>
			<aside style="position:absolute; right:5em; top:5em" >
<%-- 				<c:if test="${sessionScope.memberLevel==0}">
		        	<div class="darkmode">
		            	<div class="inner">
		                	<input type="radio" name="toggle" id="toggle-radio-light" checked><label for="toggle-radio-light" class="tolight"><i class="fas fa-sun tolight"></i></label>
		                	<input type="radio" name="toggle" id="toggle-radio-dark"><label for="toggle-radio-dark" class="todark"><i class="fas fa-moon todark"></i></label>
		                	<div class="darkmode-bg"></div>
		            	</div>
		        	</div>
				</c:if> --%>
				<div class="dropdown" :class="{'show':sideMenu}">
					<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" @click="showSideMenu()">
						<i class="fa-solid fa-bars"></i>
					</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" v-show="sideMenu" :class="{'show' : sideMenu}">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/setting?page=1">환경설정</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/?adminMenu=1">관리자 메뉴</a>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/login">로그인</a>
						<c:if test="${socialUser != null}">
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
						</c:if>
						<a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
					</div>
				</div>
			</aside>
			
			
<!-- ---------------------------------게시물 상세보기 모달-------------------------- -->

<div v-if="detailView" class="container-fluid fullscreen in-header" @click="closeDetail">
	
	<div class="p-4 mt-2 ms-4 d-flex justify-content-end">
		<h2 class="btn btn-default" @click="closeDetail()" style="font-size: 30px; color:#FFFFFF;">X</h2>
	</div>
	<div class="row fullscreen-container in-header" @click.stop >
		<div class="col-7 offset-1" style="padding-right: 0;padding-left: 0;">
			<div :id="'detailCarousel'+ detailIndex" class="carousel slide">
                <div class="carousel-indicators">
                  <button v-if="boardData[0].boardAttachmentList.length > 1"  v-for="(attach, index2) in boardData[0].boardAttachmentList" :key="index2" type="button" :data-bs-target="'#detailCarousel'+ detailIndex" :data-bs-slide-to="index2" :class="{'active':index2==0}" :aria-current="index2==0?true:false" :aria-label="'Slide '+(index2+1)"></button>
                </div>
               
                <div class="carousel-inner">
                  <div v-for="(attach, index2) in boardData[0].boardAttachmentList" :key="index2" class="carousel-item" :class="{'active':index2==0}">
                   	<video  style="width:700px; height:700px; object-fit:cover" class="d-block" :src="'${pageContext.request.contextPath}'+attach.imageURL" v-if="attach.video"
							:autoplay="memberSetting.videoAuto" muted controls :loop="memberSetting.videoAuto" 
							@dblclick="likePost(boardData[0].boardWithNickDto.boardNo,detailIndex)" ></video>
	                <img v-else :src="'${pageContext.request.contextPath}/rest/attachment/download/'+attach.attachmentNo" class="d-block" @dblclick="likePost(board.boardWithNickDto.boardNo,detailIndex)"
	                 style="width:700px; height:700px;" @dblclick="likePost(boardData[0].boardWithNickDto.boardNo,detailIndex)"> 
                  </div>
                </div>
               
                <button v-if="boardData[0].boardAttachmentList.length > 1" class="carousel-control-prev" type="button" :data-bs-target="'#detailCarousel' + detailIndex" data-bs-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button v-if="boardData[0].boardAttachmentList.length > 1"  class="carousel-control-next" type="button" :data-bs-target="'#detailCarousel' + detailIndex" data-bs-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button>
                
           </div>
		</div>
           
        <div class="col-4" style="padding-left: 0;">
        	<div class="card in-header bg-light" style="border-radius:0; max-height: 700px">
           		<div class="card-header in-header">
	           		<img class="profile" :src="profileUrl(detailIndex)">
           			<a class="btn btn-default" style="padding: 0 0 0 0; margin-left: 0.5em;" :href="'${pageContext.request.contextPath}/member/'+boardData[0].boardWithNickDto.memberNick"><b>{{boardData[0].boardWithNickDto.memberNick}}</b></a>
           		</div>
				
				<div class="card-body in-header card-scroll" ref="scrollContainer"  style="height:490px; padding-top: 0px; padding-left:0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title in-header"></h5>
					<p class="card-text in-header" style="margin-left: 0.5em;">{{boardData[0].boardWithNickDto.boardContent}}
					<br v-if="boardData[0].boardTagList.length > 0"><br v-if="boardData[0].boardTagList.length > 0">
                            	<a @click="moveToTagPage(tag.tagName)" v-for="(tag, index3) in boardData[0].boardTagList" :key="index3" style="margin-right: 0.5em; color: blue; cursor: pointer;">\#{{tag.tagName}}</a>
					</p>
					
					
					<div v-if="replyList.length > 0" v-for="(reply,index) in replyList" :key="index" class="card-text in-header" :class="{'childReply':reply.replyParent!=0}" style="position: relative;">
						<a :href="'${pageContext.request.contextPath}/member/'+ replyList[index].memberNick" style="color:black; text-decoration:none; position:relative;">
							<img v-if="replyList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ replyList[index].attachmentNo" width="45" height="45" style="border-radius: 70%;position:absolute; margin-top:9px; margin-left: 4px">
							<img v-else src="https://via.placeholder.com/45x45?text=profile" style="border-radius: 70%;position:absolute; margin-top:9px; margin-left: 4px">
							
							<p style="padding-left: 3.5em; margin-bottom: 1px; font-size: 0.9em; margin-left: 3.5px; font-weight: bold;">{{replyList[index].memberNick}}</p>
												
						</a>
						<p style="padding-left:3.5em; margin-bottom:1px; font-size:0.9em; margin-left: 3.5px;">{{replyList[index].replyContent}}</p>
<!-- 						<p style="padding-left:4.0em;margin-bottom:1px;font-size:0.8em; color:gray;"> -->
						<div class="row" style="height: 25px">
							<div class="col-10">
								<p style="padding-left:4.25em;margin-bottom:2px;font-size:0.8em; color:gray;">{{dateCount(replyList[index].replyTimeAuto)}} &nbsp; 좋아요 {{replyLikeCount[index]}}개 &nbsp;
									<a style="cursor: pointer;" v-if="reply.replyParent==0" @click="reReply(replyList[index].replyNo)">답글 달기</a>  
									<i :class="{'fa-heart': true, 'like':isReplyLiked[index],'ms-2':true, 'fa-solid': isReplyLiked[index], 'fa-regular': !isReplyLiked[index]}" @click="likeReply(reply.replyNo,index)" style="font-size: 0.9em;"></i>
									
								</p>
							</div>
						<!-- 댓글 신고창 -->
							<div class="col-2 p-0 d-flex justify-content-center">
								<p class="d-flex align-items-center"><i class="fa-solid fa-ellipsis" style="display:flex; flex-direction: row-reverse;" @click="showAdditionalMenuModal(reply.replyNo, reply.replyMemberNo, 'reply',index,detailIndex)"></i></p>
							</div>
						</div>
						
<!-- 						<p v-if="replyList[index].replyParent == 0"> -->
<!-- 							<span @click="showReReply(reply.replyNo, index)" style="cursor:pointer; padding-left:4em; font-size:0.8em; color:gray;">{{replyStatus(index)}}</span> -->
<!-- 						</p> -->
					</div>
					
					<div v-else class="card-text in-header" style="position: relative;">
						<b style="margin-left: 0.5em;">첫 댓글을 작성해보세요</b>
					</div>
					
					
				</div>
				<hr style="margin-top: 0; margin-bottom: 0;">
				
				<div class="card-body in-header"  style="height:110px; padding-top: 0px; padding-left: 0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title in-header"></h5>
					<!-- 북마크 오른쪽 정렬 수정 06/04 재영 -->
					<!-- <p class="card-text" style="margin: 0 0 4px 0;">
						
						<i :class="{'fa-heart': true, 'like':isLiked[detailIndex],'ms-2':true, 'fa-solid': isLiked[detailIndex], 'fa-regular': !isLiked[detailIndex]}" @click="likePost(boardList[detailIndex].boardWithNickDto.boardNo,detailIndex)" style="font-size: 27px;"></i>
						&nbsp;
						<i class="fa-regular fa-message mb-1" style="font-size: 25px;"></i>
						
					</p> -->
				  <div class="d-flex row">
					  <div class="col-10">
						<span class="card-text in-header" style="margin: 0 4px 4px 0; padding-left: 0.5em">
						    <i :class="{'fa-heart': true, 'like':isLikedOne, 'fa-solid': isLikedOne, 'fa-regular': !isLikedOne}"
						       @click="likePost(boardData[0].boardWithNickDto.boardNo,detailIndex)" style="font-size: 27px;"></i>
						</span>
						<span class="card-text in-header" style="margin: 0 0 4px 0; padding-left: 0.5em;">
					    	<i class="fa-regular fa-message mb-1" style="font-size: 25px;"></i>
						</span>
					  </div>
					  <div class="col-1 p-0 flex-grow-1">
					    <span class="ms-4">
					      <i class="fa-regular fa-bookmark" @click="bookmarkInsert(boardData[0].boardWithNickDto.boardNo)"
					         v-show="bookmarkChecked(boardData[0].boardWithNickDto.boardNo)" style="font-size: 25px;"></i>
					      <i class="fa-solid fa-bookmark" @click="bookmarkInsert(boardData[0].boardWithNickDto.boardNo)"
					         v-show="!bookmarkChecked(boardData[0].boardWithNickDto.boardNo)" style="font-size: 25px;"></i>
					    </span>
					  </div>
				  </div>
					
					
					<p class="card-text in-header" style="margin: 0 0 4px 0; cursor: pointer;" @click="showLikeListModal(boardData[0].boardWithNickDto.boardNo)"><b style="margin-left: 0.5em;">좋아요 {{boardLikeCountOne}}개</b></p>
					<p class="card-text in-header" style="margin: 0 0 0 0.5em">{{dateCount(boardData[0].boardWithNickDto.boardTimeAuto)}}</p>
					
				</div>
				
				<div class="input-group">
					<input ref="replyInput" type="text" class="form-control" @click="disabledReply(detailIndex)" :placeholder="placeholder"  v-model="replyContent" style="border: none;" aria-label="Recipient's username" aria-describedby="button-addon2" @input="replyContent = $event.target.value" @keyup.enter="replyInsert(detailIndex)">
					<button class="btn" type="button" id="button-addon2" style="border-top-right-radius: 0!important;" @click="replyInsert(detailIndex)">작성</button>
				</div>
								        	
        	</div>
        </div>
	</div>
</div>

<!-- ---------------------------------좋아요 목록 모달-------------------------- -->
<div class="modal" tabindex="-1" role="dialog" id="likeListModal" data-bs-backdrop="static" ref="likeListModal" style="z-index:9999;">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
				<div class="modal-header">
        			<h5 class="modal-title col-7" style="font-weight:bold;">좋아요</h5>
        			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click="hideLikeListModal"></button>
      			</div>
				<div v-if="likeList.length != 0" class="modal-body p-0">				
					<div class="row p-2 mt-2"  v-for="(like,index) in likeList" :key="index">
						<div  class="col d-flex">
							<a :href="'${pageContext.request.contextPath}/member/'+ like.memberNick">
								<img v-if="like.attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ like.attachmentNo" width="50" height="50" style="border-radius: 70%;">
								<img v-else src="https://via.placeholder.com/50x50?text=profile" style="border-radius: 70%; ">
							</a>
							<a :href="'${pageContext.request.contextPath}/member/'+ like.memberNick" style="color:black;text-decoration:none; position:relative;">
								<h6 style="margin: 14px 0 0 10px;">{{like.memberNick}}</h6>
							</a>
						</div>
					</div>
				</div>
				
				<div class="modal-body p-0" v-else>
					<div class="row p-2 mt-2" >
						<div class="col text-center">
							<h2 class="mt-1">아직 좋아요가 없습니다</h2><br>
							<h3>첫 번째 좋아요를 눌러주세요</h3>
						</div>
	 			 	</div>		
				</div>
					
				
				
		</div>
	</div>
	</div>
			
			
		</header>
<section>	


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
	/* GPS 데이터 저장 */
	let memberGpsLon;
	let memberGpsLat;
	  Vue.createApp({
	    data() {
	      return {
	        sideMenu: false,
	        showModal: false,
	        notifications: [],
	        hasNewNotification: false,
	        intervalId: null,
	        storedNotifications: [],
	        memberNick : "${socialUser.memberNick}",
	        loginMemberNo:"${sessionScope.memberNo}", // 로그인한 세션 값
	        
          //dm 읽지 않은 메세지 수
          hasUnreadMessages: false,
          //dm 채팅방 번호
          roomNo: [],
          unreadMessage: [],
          
	      	//상세보기 및 댓글
			detailView:false,
			detailIndex:"",
			boardData : [],
			replyList:[],
			replyParent:0,
			replyContent:"",
			placeholder:"댓글 입력..",
	      	//게시물 작성자 팔로우 리스트
			followList : [],
			followerList : [],
	      	//게시물 좋아요 기능 전용 변수
			boardLikeCountOne:0, // 좋아요 수를 저장할 변수
            isLikedOne : false, // 로그인 회원이 좋아요 체크 여부
            likeList : [],
            likeListData : [],
            likeListModal : false,
          	//게시물 댓글 좋아요 기능 전용 변수
			replyLikeCount : [], // 댓글 좋아요 수 저장 변수
			isReplyLiked : [], // 로그인 회원이 댓글 좋아요 체크 여부 
			//북마크
			bookmarkCheck : [],
			
			memberSetting:{
	            //반경설정
	            watchDistance:"",
	            //동영상 자동재생
	            videoAuto:false,
            },
              
	      };
	    },
	    computed: {
	      // 계산영역
	    	profileUrl(index){
	    		 return index => {
	    		      const board = this.boardData[0];
	    		      if (board && board.boardWithNickDto && board.boardWithNickDto.attachmentNo > 0) {
	    		        return contextPath + "/rest/attachment/download/" + board.boardWithNickDto.attachmentNo;
	    		      }
	    		      else {
	    		        return "https://via.placeholder.com/100x100?text=profile";
	    		      }
	    		    };
	    		  },
	    },
	    methods: {
	    	
	      // 메소드영역
	      showSideMenu() {
	        this.sideMenu = !this.sideMenu;
	      },
	      
	      async loadBoard(boardNo) {
	    	  const resp = await axios.get("${pageContext.request.contextPath}/rest/board/one", {
	    	        params: {
	    	            boardNo: boardNo
	    	        }
	    	    });
	    	  this.isLikedOne = await this.likeChecked(resp.data.boardWithNickDto.boardNo);
	    	  this.boardLikeCountOne = resp.data.boardWithNickDto.boardLike;
	    	  this.boardData = [resp.data];	  
	    	  
	    	  this.replyLoad(boardNo);
	      },
	      
	    	//회원 환경 설정 로드
	        async loadMemberSetting(){
				const resp = await axios.get(contextPath+"/rest/member/setting");
	            this.memberSetting.watchDistance=resp.data.settingDistance;
	            this.memberSetting.videoAuto=resp.data.videoAuto;
			},
			
			 //로그인한 회원이 좋아요 눌렀는지 확인
	        async likeChecked(boardNo) {
	        	const resp = await axios.post("${pageContext.request.contextPath}/rest/board/check", {boardNo:boardNo});			
	        	return resp.data;
	        },
	        
	        //로그인한 회원이 댓글 좋아요 눌렀는지 확인
	        async likeReplyChecked(replyNo) {
	        	const resp = await axios.post("${pageContext.request.contextPath}/rest/reply/check", {replyNo:replyNo});
	        	return resp.data;
	        },
	        
	        //좋아요
	        async likePost(boardNo) {
	            const resp = await axios.post("${pageContext.request.contextPath}/rest/board/like", {boardNo:boardNo});
	            if(resp.data.result){
	            	this.isLikedOne = true;
	            }
	            else {
	            	this.isLikedOne = false;
	            }
	            
	            this.boardLikeCountOne = resp.data.count;
	        },
	        
	        //좋아요 리스트
	        async likeListLoad(boardNo) {
	        	const resp = await axios.get("${pageContext.request.contextPath}/rest/board/like/list/" + boardNo);
	        	this.likeList = [...resp.data];
	        },
	        
	        //댓글 좋아요
	        async likeReply(replyNo, index) {
	        	const resp = await axios.post("${pageContext.request.contextPath}/rest/reply/like", {replyNo:replyNo});
	        	
	        	if(resp.data.result) {
	        		this.isReplyLiked[index] = true;
	        	}
	        	else {
	        		this.isReplyLiked[index] = false;
	        	}
	        	this.replyLikeCount[index] = resp.data.count;
	        },
			
	      //댓글 조회
	        async replyLoad(boardNo) {
	        	this.replyList = [];
	        	this.isReplyLiked = [];
	        	this.replyLikeCount = [];
	        	const resp = await axios.get("${pageContext.request.contextPath}/rest/reply/"+ boardNo);
	            
	        	for (const reply of resp.data) {
	            	this.isReplyLiked.push(await this.likeReplyChecked(reply.replyNo));
	            	this.replyLikeCount.push(reply.replyLike);
	              }
	        	
	        	this.replyList=[...resp.data];
	        },
	        
	      //댓글 등록
	        async replyInsert(index) {
	        	  const boardNo = this.boardData[0].boardWithNickDto.boardNo;
	        	  const memberNo = this.boardData[0].boardWithNickDto.memberNo;
	        	  const loginNo = parseInt(this.loginMemberNo);
	        	  
	        	  //세팅값 불러오기
	        	  const response = await axios.get(contextPath+"/rest/member/setting/" + memberNo);
	        	  const set = response.data.settingAllowReply;
	        	  
	        	  const requestData = {
	        	    replyOrigin: boardNo,
	        	    replyContent: this.replyContent,
	        	    replyParent : this.replyParent
	        	  };
	        	  this.replyContent='';
	        	  
	        	  //모든 사람 작성 가능한 경우
	        	  if(set == 0){
	        	    const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
	        	    this.replyLoad(boardNo);	            		  
	        	  }
	        	  //내가 팔로우 하는 사람만 작성 가능한 경우
	        	  else if(set == 1){
	        		  //게시물 작성자 팔로우 로드
	        		  await this.loadFollow(memberNo);
	              	  if(loginNo == memberNo) this.followList.push(loginNo); 
	        		  
	              	  if(this.followList.includes(loginNo)){
	        			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
	              	      this.replyLoad(boardNo); 
	              	      this.followList = [];
	        		  }
	        		  else{
	        			  alert("댓글 사용이 불가능합니다.");
	        		  }
	        	  }
	        	  //팔로워만 댓글 작성 가능한 경우
	        	  else if(set == 2){
	        		  await this.loadFollower(memberNo);
	              	  if(loginNo == memberNo) this.followerList.push(loginNo); 
	        		  if(this.followerList.includes(loginNo)){
	        			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
	              	      this.replyLoad(boardNo);
                	      this.followerList = [];
	        		  }
	        		  else{
	        			  alert("댓글 사용이 불가능합니다.");
	        		  }
	        	  }
	        	  else{
	        		  //게시물 작성자 팔로우 로드
	        		  await this.loadFollow(memberNo);
	              	  if(loginNo == memberNo) this.followList.push(loginNo); 
	        		  //게시물 작성자 팔로워 로드
	              	  await this.loadFollower(memberNo);
	              	  if(loginNo == memberNo) this.followerList.push(loginNo); 
	        		  
	              	  if(this.followList.includes(loginNo) || this.followerList.includes(loginNo)){
	        			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
	              	      this.replyLoad(boardNo);
	              	      this.followList = [];
                	      this.followerList = [];
	        		  }
	        		  else{
	        			  alert("댓글 사용이 불가능합니다.");
	        		  }
	        	  }
	        	   
	        },
	        
	        //댓글 가능 팔로우 체크
	        async loadFollow(memberNo) {
	        	const resp = await axios.post(contextPath + "/rest/follow/getFollow/" + memberNo);
	        	this.followList.push(...resp.data);
	        },
	        
	        //댓글 가능 팔로워 체크
	        async loadFollower(memberNo) {
	        	const resp = await axios.post(contextPath + "/rest/follow/getFollower/" + memberNo);
	        	this.followerList.push(...resp.data);
	        },
	        
	        //댓글 삭제
	        async replyDelete(index) {
	        	const resp = await axios.delete("${pageContext.request.contextPath}/rest/reply/"+ this.replyList[index].replyNo);
	        	this.replyLoad(this.boardData[0].boardWithNickDto.boardNo);
	        },
	        
	        //대댓글
	        reReply(replyNo) {
	        	if(replyNo==this.replyParent){
	        		this.replyParent = 0;
	        		this.placeholder = "댓글 입력.."
	        	}
	        	else{
	        		this.replyParent = replyNo;
	        		this.placeholder = "답글 입력..";
	        		this.$refs.replyInput.focus();
	        	}
	        },
	        
	        //댓글 사용 불가 알림
	         disabledReply(index) {
	        	 if(this.boardData[0].boardWithNickDto.boardReplyValid != 0){
	        		 alert("댓글 사용이 불가능합니다.");
	        	 }
	         },
	        
	        //상세보기 모달창 열기
	        detailViewOn(index) {
	        	this.detailView = true;
	        	this.detailIndex = index;
	        	//this.loadBoard(boardNo);
	        	//this.replyLoad();
	        	this.bookmarkList();
	        	this.loadMemberSetting();
	        	document.body.style.overflow = "hidden";
	        },
	        
	        //상세보기 모달창 닫기
	        closeDetail() {
	        	this.detailView = false;
	        	this.replyList = [];
	        	document.body.style.overflow = "unset";
	        },
	        
	        //좋아요 모달창 열기
	        showLikeListModal(boardNo){
				if(this.likeListModal==null) return;
				this.likeListLoad(boardNo);
				this.likeListModal.show();
				this.likeListData=[boardNo];
			},
			
			//좋아요 모달창 닫기
			hideLikeListModal(){
				if(this.likeListModal==null) return;
				this.likeList=[];
				this.likeListModal.hide();
			},
			
			//북마크
			async bookmarkInsert(boardNo) {
			  const resp = await axios.post("/rest/bookmark/" + boardNo);
			
			  if (resp.data === true) {
			    this.bookmarkCheck.push({ boardNo });
			  } else {
			    const index = this.bookmarkCheck.findIndex(item => item.boardNo === boardNo);
			    if (index !== -1) {
			      this.bookmarkCheck.splice(index, 1);
			    }
			  }
			
			},
			
			bookmarkChecked(boardNo){
				  return !this.bookmarkCheck.some(item => item.boardNo === boardNo);
				},
			
			async bookmarkList(){
				const resp = await axios.get("/rest/bookmark/selectOne");
				this.bookmarkCheck.push(...resp.data);
			},
	      
	      loadNotifications() {
	    	  axios
	    	    .get("${pageContext.request.contextPath}/rest/notice/")
	    	    .then((response) => {
	    	      const result = response.data;
	    	      if (result.length > 0) {
	    	        // 알림이 있을 경우 처리 로직
	    	        this.notifications = result;
	    	        this.hasNewNotification = true;

	    	        if (!this.showModal) {
	    	          this.storedNotifications = JSON.parse(localStorage.getItem("storedNotifications")) || [];
	    	          this.notifications = [];
	    	          localStorage.setItem("storedNotifications", JSON.stringify(this.storedNotifications));
	    	        }
	    	      } else {
	    	        // 알림이 없을 경우 처리 로직
	    	        this.notifications = [];
	    	        this.hasNewNotification = false;
	    	        this.storedNotifications = JSON.parse(localStorage.getItem("storedNotifications")) || [];
	    	      }
	    	   	  //dm 읽지 않은 메세지 수 조회
	    	      //this.unreadMessageCount();
	    	    })
	    	    .catch((error) => {
	    	      console.log(error);
	    	    });
	    	},
	    	
	    	//dm 읽지 않은 메세지 수 알림
			async unreadMessageCount() {
				  try {
				    const memberNo = this.loginMemberNo;
				    const roomNoUrl = "${pageContext.request.contextPath}/rest/notice/enteredRoomNo";
				    const roomNoResp = await axios.get(roomNoUrl);
				    const roomNoList = roomNoResp.data;
				    
				    const unreadDmCountUrl = "${pageContext.request.contextPath}/rest/notice/unreadMessageCount";
				    const unreadMessageList = await Promise.all(roomNoList.map(async (roomNo) => {
				      const unreadMessageResp = await axios.get(unreadDmCountUrl, { params: { roomNo, memberNo } });
				      return unreadMessageResp.data;
				    }));
			
				    const hasUnreadMessages = unreadMessageList.some(count => count > 0);
				    this.hasUnreadMessages = hasUnreadMessages;
				  } catch (error) {
				    this.hasUnreadMessages = false;
				  }
			},

	      toggleModal() {
    		if (!this.showModal) {
    	        this.loadNotifications();
    	      }
    	      this.showModal = !this.showModal;

    	      if (!this.showModal) {
    	    	this.cleanupLocalStorage();
    	        this.check();
    	      }
    	    },
    	    
	      check() {
		  //알림확인
		       axios
			       .put("${pageContext.request.contextPath}/rest/notice/check/")
			       .then((response) => {
		    	      this.notifications.forEach((notification) => {
		    	        notification.status = "read";
		    	        this.storedNotifications.unshift(notification);
		    	      });
		    	      this.notifications = [];
		    	      localStorage.setItem("storedNotifications", JSON.stringify(this.storedNotifications));
		    	    })
		    	    .catch((error) => {
		    	      console.log(error);
		    	    });
	      },
	      
	      //알림 삭제
// 	      deleteNotification(notification) {
// 	    	    const index = this.storedNotifications.findIndex((n) => n.id === notification.id);
// 	    	    if (index !== -1) {
// 	    	      this.storedNotifications.splice(index, 1);
// 	    	      localStorage.setItem("storedNotifications", JSON.stringify(this.storedNotifications));
// 	    	    }
// 	    	  },
	    
		  //알림 전체 삭제
    	  deleteAllNotifications() {
    		  this.storedNotifications = [];
    		  localStorage.removeItem("storedNotifications");
   		  },
	    	  
	    	 //게시글 날짜 계산 함수
	        dateCount(date) {
	        	const curTime = new Date();
	        	const postTime = new Date(date);
	        	const duration = Math.floor((curTime - postTime) / (1000 * 60));
	        	
	        	if(duration < 1){
	        		return "방금 전";
	        	}
	        	else if(duration < 60){
	        		return duration + "분 전";
	        	}
	        	else if(duration < 1440) {
	        		const hours = Math.floor(duration / 60);
	        		return hours + "시간 전"
	        	} 
	        	else {
	        		const days = Math.floor(duration / 1440);
	        		return days + "일 전";
	        	}
	        },
	        //이동버튼 클릭 시
	        async moveToMyPage(){
	        	const resp = await axios.get(contextPath+"/rest/member/nickname");
        		window.location.href=contextPath+'/member/'+resp.data;
	        },
	        
	        //7일 뒤 알림 자동 삭제
			cleanupLocalStorage() {
			  const storedNotifications = JSON.parse(localStorage.getItem("storedNotifications")) || [];
			
			  const expirationDate = new Date();
			  expirationDate.setDate(expirationDate.getDate() + 7);
			
			  setTimeout(() => {
			    const updatedStoredNotifications = storedNotifications.filter((notification) => {
			      const notificationDate = new Date(notification.date);
			      return notificationDate >= expirationDate;
			    });
			
			    localStorage.setItem("storedNotifications", JSON.stringify(updatedStoredNotifications));
			  }, 7 * 24 * 60 * 60 * 1000); // 7일 뒤 삭제
			},


			//10초 뒤 알림 자동 삭제
// 	        cleanupLocalStorage() {
// 	        	  const storedNotifications = JSON.parse(localStorage.getItem("storedNotifications")) || [];

// 	        	  const expirationDate = new Date();
// 	        	  expirationDate.setTime(expirationDate.getTime() + 10 * 1000);

// 	        	  setTimeout(() => {
// 	        	    const updatedStoredNotifications = storedNotifications.filter((notification) => {
// 	        	      const notificationDate = new Date(notification.date);
// 	        	      return notificationDate >= expirationDate;
// 	        	    });

// 	        	    localStorage.setItem("storedNotifications", JSON.stringify(updatedStoredNotifications));
// 	        	  }, 10000);
// 	        	},

			/* GPS 얻기 */
			getGps(){
				if (navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(this.showGps, this.showError);
				} 
				else {
				// 브라우저가 Geolocation을 지원하지 않는 경우 처리할 로직
				}
			},
			showGps(position){
				// 위치 정보 가져오기 성공 시 처리할 로직
				memberGpsLat = position.coords.latitude;
				memberGpsLon = position.coords.longitude;
				this.setGpsToMember();
			},
			showError(error) {
				// 위치 정보 가져오기 실패 시 처리할 로직(기존꺼 불러옴)
				switch (error.code) {
					case error.PERMISSION_DENIED:
						this.getGpsFromMember();
						break;
					case error.POSITION_UNAVAILABLE:
						this.getGpsFromMember();
						break;
					case error.TIMEOUT:
						this.getGpsFromMember();
						break;
					case error.UNKNOWN_ERROR:
						this.getGpsFromMember();
						break;
				}
			},
			async getGpsFromMember(){
				const resp = await axios.get("/rest/member/");
				memberGpsLat = resp.data.memberLat;
				memberGpsLon = resp.data.memberLon;
			},
			async setGpsToMember(){
				const data = {memberLon : memberGpsLon, memberLat:memberGpsLat}
				const resp = await axios.put("/rest/member/", data);
			},
			/* GPS 끝 */
	    },
	
	    created() {
	      // 데이터 불러오는 영역
	    	this.cleanupLocalStorage();
			this.getGps();
	    },
	    watch: {
	      // 감시영역
	    },

	    mounted() {
	      this.loadNotifications(); // 컴포넌트가 마운트될 때 알림 데이터를 로드
	      this.intervalId = setInterval(this.loadNotifications, 5000); // 5초마다 알림 데이터를 갱신
	      this.likeListModal = new bootstrap.Modal(this.$refs.likeListModal);
          //this.unreadMessageCount(); //dm 알림
	    },
	    
	    beforeUnmount() {
	      clearInterval(this.intervalId); //메모리 누수방지
	   	},
	   	
	  }).mount("#aside");
</script>