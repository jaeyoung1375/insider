<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../template/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
   .media-height{
           width: 250px; 
           height:250px; 
           overflow: hidden;
        }
        .imgHover:hover{
         opacity:1!important;
      }
      .nomal{
         text-decoration: none;
         color:black;
      }
      .hide{
      	display:none;
      }
   	.profile-container {
  position: relative;
  display: inline-block;
}

.profile-preview {
  position: fixed;
  margin-left :30px;
  top: 200px;
  left: 270px;
  width: 400px;
  height: 420px;
  background-color: white;
  border: 1px solid gray;
  padding: 10px;
}

.profile-container:hover .profile-preview {
  display: block; 
}
.modalNickName{
	text-decoration: none;
	color:black;
	font-weight: bold;
}
.modalName{
	color:gray;
}

 .carousel-inner img {
        width: 470px;
        height: 480px;
    }

  .card-scroll{
        	overflow-y: auto;
        	-ms-overflow-style: none;
		}        
    .card-scroll::-webkit-scrollbar {
		    display: none;
	} 
    
    
	.moreText{
			display:inline-block!important;
	}
	.moreContent{
		height: auto!important;
	    overflow: auto!important;
	    width: auto!important;
	    white-space: normal!important;
	    text-overflow: inherit!important;
	}
	
	 .fullscreen{
            position:fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 99999;
            
            background-color: rgba(0, 0, 0, 0.2);
/*             display: none; */
      }

     .fullscreen > .fullscreen-container{
         position: absolute;
         left: 50%;
         top: 50%;
         
         width: 1200px;
         height: 700px;
         
         transform: translate(-50%, -50%);
     }
     
        .like {
	color:red;
	cursor: pointer;
	}
	
	.fa-heart {
	cursor: pointer;
	}
	
	.isFollow {
	display: none;
	}
		p .card-text {
  		margin: 0 0 4px;
	}
	
/* 탭 링크에 마우스를 가져다 댔을 때 스타일 변경 */
.nav-link:hover {
  background-color: #eee;
  color: #333;
}

/* 활성화된 탭 링크 스타일 변경 */
.nav-link.active {
  background-color: #333;
  color: #fff;
}

/* 탭 패널 사이즈 및 스크롤바 스타일 조정 */
.tab-content {
  max-height: 300px;
  overflow-y: scroll;
}

/* 각 탭 패널 사이에 구분선 추가 */
.tab-pane {
  border-bottom: 1px solid #eee;
  padding-bottom: 10px;
}

/* 각 탭 패널의 컨텐츠에 여백 추가 */
.tab-pane .content {
  margin-bottom: 10px;
}
	
	
	
   
</style>

      <div id="app" class="container-fluid">
             <div class="row">
                <!-- 본인 여부에 따른 프로필 변경  -->
            <div class="col-4 text-center">
               <c:choose>
               <c:when test="${isOwner}">
                <img style="border-radius: 70%;" :src="profileUrl"
             width = "150" height="150" @click="openFileInput">
             <input ref="fileInput" type="file" @change="handleFileUpload" accept="image/*" style="display: none;">
                </c:when>       
                <c:otherwise> 
                  <img style="border-radius: 70%;" width="150" height="150" :src="profileUrl">
                </c:otherwise>
                </c:choose>           
            </div>
            <div class="col-4" style=" width:40%; margin-left:70px;">   
               <div class="col-7" style="display:flex;">
                  <div class="col-6" style="width:60%;">
                  <a href="#" class="btn btn-default" @click="showModal">${memberDto.memberNick}</a>    
           </div>
              <c:choose>
              <c:when test="${isOwner}"> <!-- 본인 프로필 이라면 -->
                 <div class="col-7">
                  <a class="btn btn-secondary" href="/member/setting?page=1">프로필 편집</a>
                  </div>
                  <div class="col-5" style=" width:30%;">
               <button class="btn btn-secondary" @click="recommend">
               		<i :class="iconClass"></i>
               </button>
               </div>
               <div class="col-5" style="width:40%;">
               <button class="btn btn-secondary" @click="myOptionModalShow" style="background-color: white; border:none;"><i class="fa-sharp fa-solid fa-gear" style="font-size:24px;"></i></button>
             </div>
              </c:when>
              <c:otherwise> <!-- 본인 프로필이 아니라면 -->
                    <div class="col-5">
              <button class="btn btn-primary" @click="follow(${memberDto.memberNo})" v-if="followCheckIf(${memberDto.memberNo})">팔로우</button>
			  <button class="btn btn-secondary" @click="unFollow(${memberDto.memberNo})" v-else>팔로잉</button>
               </div>
               <div class="col-5"  style=" width:70%;">
               <button class="btn btn-secondary">메시지 보내기</button>
               </div>
               
               <div class="col-5" style="width:40%;">
               <button class="btn btn-secondary" @click="showModal2"><i class="fa-solid fa-ellipsis"></i></button>
             </div>
              </c:otherwise>
              </c:choose>
              
             </div>
               <div class="row mt-4" style="width:130%;">
                  <div class="col-7" style="display:flex; margin-left:10px;">
                     <div class="col-6">
                        <span>게시물 
                           <span style="font-weight: bold;">${totalPostCount}</span>
                        </span>
                     </div>
                     <div class="col-6" @click="followerModalShow">
                        <span>팔로워
                        <span style="font-weight: bold;">{{totalFollowerCnt}}</span>
                         </span>
                     </div>
                     <div class="col-6" @click="followModalShow">
                        <span>팔로우
                        <span style="font-weight: bold;">{{totalFollowCnt}}</span>
                         </span>
                     </div>
                  </div>   
               </div>
               <div class="row mt-4">
                  <span style="font-size:12px;">
                  <h5>${memberDto.memberName}</h5>
                  Aespa fashion 에스파 패션             
               팬 페이지
               for aespa 💙
               #aespastyles_ (member)
               est june 2020 ✨ | twitter:
               twitter.com/aespastyles?s=21      
               </span>
               </div>
               
            </div>
            </div>
            <!-- 친구 추천 목록 -->
            <div  style="display: flex; flex-direction: column; width: 930px; height:280px; background-color: white; border:1px solid gray; margin: 0 auto;" v-if="recommendFriends">
        		<div class="recommend-id" style="display:flex; justify-content: space-between;">
        			<span style="color:gray; font-weight: bold;">추천계정</span>
        			<a class="" style="text-decoration: none; font-weight: bold;" @click="recommendFriendsAllListModalShow">모두 보기</a>
        		</div>  
			<div class="card-container" style="display:flex; margin-top:20px;">
			<!-- 이전 페이지로 이동하는 버튼 -->
				<div class="button-container" style="display: flex; justify-content: center; align-items: center;">
					<i class="fa-solid fa-arrow-left"  @click="currentPage--" :class="{'hide' : currentPage === 0}" style="height:24px; weight:24px; margin-left:5px;"></i>
				</div>

			  <div v-for="(item, itemIndex) in displayedItems" :key="itemIndex" style="display:flex;">
			    <div class="card" style="width: 174px; height: 192px; margin-left: 30px;">
			      <div class="ms-auto" style="margin-right:8px;">
			      	<span @click="deleteRecommendFriend(item.memberNo)">x</span>
			      </div>
			      <div class="profile d-flex justify-content-center align-items-start">
			        <img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+item.attachmentNo" width="54" height="54" style="border-radius:50%;">
			      </div>
			      <div class="recommend-nickname d-flex justify-content-center align-items-start">
			        {{ item.memberNick }}
			      </div>
			      <div class="recommend-name d-flex justify-content-center align-items-start">
			        <span style="margin-top:5px;">{{ item.memberName }}</span>
			      </div>
			      <div class="recommend-name d-flex justify-content-center align-items-start">
			      <!-- 다음 페이지로 이동하는 버튼 -->
			        <button class="btn btn-primary" style="width:85px; margin-top:8px;" @click="follow(item.memberNo)">팔로우</button>
			      </div>
			    </div>
			  </div>
		<div class="button-container" style="display: flex; justify-content: center; align-items: center; ">
  		
  			<i class="fa-sharp fa-solid fa-arrow-right" @click="currentPage++"  :class="{'hide':currentPage === paginatedRecommendFriends.length - 1}" 
  			style="height: 24px; weight: 24px; margin-left:20px;"></i>
		</div>
			</div>



            </div>
            
            
            <hr>
     <!-- 게시물 시작 -->
     <!-- 비공개 계정 -->
<div class="position-absolute mt-5 start-50 translate-middle-x media-width" style="display: flex; flex-direction: column; width: 770px; height: 700px;" v-if="(settingHide === 3 && !isOwner) || settingHide === 2 && followCheckIf(${memberDto.memberNo}) && !isOwner">
 	   <div style="display: flex;flex-direction: column; justify-content: center; align-items: center;">    
   <img src="${pageContext.request.contextPath}/static/image/lock.png" width="200" height="200">
   <h4 class="mt-5 text-center">비공개 계정입니다 사진 및 동영상을 보려면 팔로우하세요.</h4>
   </div>
</div>



<!-- 공개 계정 -->
<!-- 게시물이 없는 경우 || 본인 프로필이 아닐 때 -->
<div class="position-absolute mt-5 start-50 translate-middle-x media-width" style="display: flex; flex-direction: column; width: 770px; height:700px;" v-else> 
    <div class="mt-5" style="display: flex;flex-direction: column; justify-content: center; align-items: center;" v-if="myBoardList.length == 0 && !isOwner">    
   <i class="fa-solid fa-camera fa-2xl" style="font-size:100px;"></i>
   <h2 class="mt-5">게시물 없음</h2>
   </div>
   
	<!-- 게시물이 없는 경우 || 본인 프로필일 때 -->
   <div class="mt-5" style="display: flex;flex-direction: column; justify-content: center; align-items: center;" v-if="myBoardList.length == 0 && isOwner" @click="boardInsert">    
   <i class="fa-solid fa-camera fa-2xl" style="font-size:100px;"></i>
   <h2 class="mt-5">사진 공유</h2>
   <p>사진을 공유하면 회원님의 프로필에 표시됩니다.</p>
  
   </div>
   
  

    <div style="margin-bottom:10px;display: flex; width: 110%;"> 
    	 <div style="margin-bottom:10px;display: flex;flex-wrap:wrap; width: 100%;">
	    	<div v-for="(board,index) in myBoardList" :key="index" style="margin-right: 10px;">
    		 <div class="media-height" style="margin-right: 10px; position:relative;">
	    		 	<div v-if="board.boardAttachmentList && board.boardAttachmentList[0]">
					<img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+board.boardAttachmentList[0].attachmentNo" style="width:100%; height:250px;">
					</div>
    		 	 <i class="fa-solid fa-note-sticky fa-lg" style="color:white;position:absolute;right:0;top:20px;"></i>
    		 	  <div class="imgHover" style="cursor:pointer;position:absolute;background-color:#22222221;left:0;right:0;top:0;bottom:0;opacity:0;color:white;"  @click="detailViewOn(index)">
    		 	   <i class="fa-solid fa-heart fa-lg" style="position:absolute;top:50%;left:25%;">{{board.boardWithNickDto.boardLike}}</i>
    		 	     <i class="fa-regular fa-comment fa-lg" style="position:absolute;top:50%;left:50%;">{{board.boardWithNickDto.boardReply}}</i>	    		 	 	    
    		 	  </div> 
    		 </div>  
    	</div>
     
    	</div>
    </div>
    
</div>
<!-- 게시물 영역 끝 --> 

<!-- ---------------------------------게시물 상세보기 모달-------------------------- -->

<div v-if="detailView" class="container-fluid fullscreen" @click.self="closeDetail">
	<div class="row fullscreen-container">
		<div class="col-7 offset-1" style="padding-right: 0;padding-left: 0;">
			<div :id="'detailCarousel'+ detailIndex" class="carousel slide">
                <div class="carousel-indicators">
                  <button v-for="(attach, index2) in myBoardList[detailIndex].boardAttachmentList" :key="index2" type="button" :data-bs-target="'#detailCarousel'+ detailIndex" :data-bs-slide-to="index2" :class="{'active':index2==0}" :aria-current="index2==0?true:false" :aria-label="'Slide '+(index2+1)"></button>
                </div>
               
                <div class="carousel-inner">
                  <div  v-for="(attach, index2) in myBoardList[detailIndex].boardAttachmentList" :key="index2" class="carousel-item" :class="{'active':index2==0}">
                   	<img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+attach.attachmentNo" class="d-block" @dblclick="likePost(board.boardWithNickDto.boardNo,detailIndex)" style="width:700px; height:700px;"> 
                  </div>
                </div>
               
                <button class="carousel-control-prev" type="button" :data-bs-target="'#detailCarousel' + detailIndex" data-bs-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button  class="carousel-control-next" type="button" :data-bs-target="'#detailCarousel' + detailIndex" data-bs-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button> 
                
           </div>
		</div>
           
         <div class="col-4" style="padding-left: 0;">
        	<div class="card bg-light" style="border-radius:0; max-height: 700px">
           		<div class="card-header">
	           		<!-- <img class="profile" :src="profileUrl(detailIndex)"> -->
           			<a class="btn btn-none" style="padding: 0 0 0 0; margin-left: 0.5em;" :href="'${pageContext.request.contextPath}/member/'+myBoardList[detailIndex].boardWithNickDto.memberNick"><b>{{myBoardList[detailIndex].boardWithNickDto.memberNick}}</b></a>
           		</div>
				
				<div class="card-body card-scroll" ref="scrollContainer"  style="height:490px; padding-top: 0px; padding-left:0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<p class="card-text" style="margin-left: 0.5em;">{{myBoardList[detailIndex].boardWithNickDto.boardContent}}
					<br v-if="myBoardList[detailIndex].boardTagList.length > 0"><br v-if="myBoardList[detailIndex].boardTagList.length > 0">
                            	<a href="#" v-for="(tag, index3) in myBoardList[detailIndex].boardTagList" :key="index3">\#{{tag.tagName}}</a>
					</p>
					
					
					<div v-if="replyList.length > 0" v-for="(reply,index) in replyList" :key="index" class="card-text" :class="{'childReply':reply.replyParent!=0}" style="position: relative;">
						<a :href="'${pageContext.request.contextPath}/member/'+ replyList[index].memberNick" style="color:black;text-decoration:none; position:relative;">
							<img v-if="replyList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ replyList[index].attachmentNo" width="42" height="42" style="border-radius: 70%;position:absolute; margin-top:5px; margin-left: 4px">
							<img v-else src="https://via.placeholder.com/42x42?text=profile" style="border-radius: 70%;position:absolute; margin-top:5px; margin-left: 4px">
							
							<p style="padding-left: 3.5em; margin-bottom: 1px; font-size: 0.9em; font-weight: bold;">{{replyList[index].memberNick}}
							</p>							
						</a>
						<p style="padding-left:3.5em;margin-bottom:1px;font-size:0.9em;">{{replyList[index].replyContent}}</p>
<!-- 						<p style="padding-left:4.0em;margin-bottom:1px;font-size:0.8em; color:gray;"> -->
						<p style="padding-left:4.0em;margin-bottom:3px;font-size:0.8em; color:gray;">{{dateCount(replyList[index].replyTimeAuto)}} &nbsp; 좋아요 {{replyLikeCount[index]}}개 &nbsp;
							<a style="cursor: pointer;" v-if="reply.replyParent==0" @click="reReply(replyList[index].replyNo)">답글 달기</a>  
							<i :class="{'fa-heart': true, 'like':isReplyLiked[index],'ms-2':true, 'fa-solid': isReplyLiked[index], 'fa-regular': !isReplyLiked[index]}" @click="likeReply(reply.replyNo,index)" style="font-size: 0.9em;"></i>
							&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
							<i v-if="replyList[index].replyMemberNo == ${memberNo}" @click="replyDelete(index,detailIndex)" class="fa-solid fa-xmark" style="color:red; cursor: pointer;"></i>
							
							
						</p>
						
<!-- 						<p v-if="replyList[index].replyParent == 0"> -->
<!-- 							<span @click="showReReply(reply.replyNo, index)" style="cursor:pointer; padding-left:4em; font-size:0.8em; color:gray;">{{replyStatus(index)}}</span> -->
<!-- 						</p> -->
					</div>
					
					<div v-else class="card-text" style="position: relative;">
						<b style="margin-left: 0.5em;">첫 댓글을 작성해보세요</b>
					</div>
					
					
				</div>
				<hr style="margin-top: 0; margin-bottom: 0;">
				
				<div class="card-body"  style="height:110px; padding-top: 0px; padding-left: 0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<p class="card-text" style="margin: 0 0 4px 0">
						<i :class="{'fa-heart': true, 'like':isLiked[detailIndex],'ms-2':true, 'fa-solid': isLiked[detailIndex], 'fa-regular': !isLiked[detailIndex]}" @click="likePost(myBoardList[detailIndex].boardWithNickDto.boardNo,detailIndex)" style="font-size: 27px;"></i>
						&nbsp;
						<i class="fa-regular fa-message mb-1" style="font-size: 25px; "></i>
					</p>
					<p class="card-text" style="margin: 0 0 4px 0"><b style="margin-left: 0.5em;">좋아요 {{boardLikeCount[detailIndex]}}개</b></p>
					<p class="card-text" style="margin: 0 0 0 0.5em">{{dateCount(myBoardList[detailIndex].boardWithNickDto.boardTimeAuto)}}</p>
					
				</div>
				
				<div class="input-group">
					<input ref="replyInput" type="text" class="form-control" :placeholder="placeholder" v-model="replyContent" style="border: none;" aria-label="Recipient's username" aria-describedby="button-addon2" @input="replyContent = $event.target.value" @keyup.enter="replyInsert(detailIndex)">
					<button class="btn" type="button" id="button-addon2" style="border-top-right-radius: 0!important;" @click="replyInsert(detailIndex)">작성</button>
				</div>
								        	
        	</div> 
			<button @click="closeDetail()">닫기</button>
        </div>
	</div>
</div>
  
      <!-- Modal 창 영역 -->
                   <div class="modal" tabindex="-1" role="dialog" id="modal03"
                            data-bs-backdrop="static"
                            ref="modal03" @click.self="hideModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center;">
                        <h5 class="modal-title" style="text-align:center;">
                            <img style="border-radius: 70%;" :src="profileUrl"
                      width = "150" height="150">
                      <div class="nickname">
                      ${memberDto.memberNick}
                      </div>   
                   <div class="content" style="text-align:left;">
                      <div class="content">
                      <p style="font-size: 12px; color:gray;">신뢰할 수 있는 커뮤니티를 유지하기 위해 Insider 계정에 대한 정보가 표시됩니다</p>
                      </div>
                      <div class="date" style="display:flex;">
                      <i class="fa-solid fa-calendar-days"></i>&nbsp;&nbsp;
                      <h5>최근 로그인 일자</h5>
                      </div>
                      <p style="font-size:12px; color:gray;">
                      ${memberDto.memberLogin}
                      </p>
                      <div class="location" style="display:flex;">
                      <i class="fa-solid fa-location-dot"></i>&nbsp;&nbsp;
                      <h5>계정 기본 위치</h5>
                      </div>
                      <p style="font-size:12px; color:gray;">한국</p>
                   </div>   
                        </h5>
                    </div>
                   
                 
                        <button type="button" class="btn"
                                data-bs-dismiss="modal">닫기</button>
                   
                </div>      
            </div>
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="myOptionModal"
                            data-bs-backdrop="static"
                            ref="addtionModal" @click.self="hideModal2">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center;">
                        <a href="#" class="btn btn-default block" style="color:red;"  @click="blockModalShow">차단</a>
                    </div>
                     
                       <div class="modal-header" style="display:flex; justify-content: center;">
                        <a href="#" class="btn report" style="color:red;">신고</a>
                    </div>
                        <div class="modal-header" style="display:flex; justify-content: center;">
                          <a @click="accountView">이 계정 정보</a>
                    </div>
                   
                 
                        <button type="button" class="btn"
                                data-bs-dismiss="modal">취소</button>
                   
                </div>      
            </div>
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="blockModal"
                            data-bs-backdrop="static"
                            ref="blockModal" @click.self="blockModalHide">
            <div class="modal-dialog" role="document" style="width:30%;">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center; flex-direction: column;">
                     <h5 class="modal-title" style="text-align:center;">
                        ${memberDto.memberNick}님을 차단하시겠어요?
                     </h5>
                     <div class="content" style="font-size:12px; text-align:center;">
                        상대방은 Insider에서 회원님의 프로필, 게시물 및 스토리를 찾을 수 없게 됩니다. Insider은 회원님이 차단한 사실을 상대방에게 알리지 않습니다.                     
                     </div>
                    </div>
                     <div class="modal-header" style="display:flex; justify-content: center;" >
                         <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">취소</button>
                    </div>
                   
                    <div class="modal-header" style="display:flex; justify-content: center;">
                          <a @click="blockResultModalShow">차단</a>
                    </div>
                   
                </div>      
            </div>
        </div>
        
         <div class="modal" tabindex="-1" role="dialog" id="blockResultModal"
                            data-bs-backdrop="static"
                            ref="blockResultModal" @click.self="blockResultModalHide">
            <div class="modal-dialog" role="document" style="width:30%;">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center; flex-direction: column;">
                     <h5 class="modal-title" style="text-align:center;">
                        ${memberDto.memberNick}님을 차단했습니다.
                     </h5>
                     <div class="content" style="font-size:12px; text-align:center;">
                        <p style="font-size:12px; color:gray;">상대방의 프로필에서 언제든지 차단을 해제할 수 있습니다.</p>                    
                     </div>
                     </div>
                     <div class="model-header" style="text-align:center;">
                     <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">닫기</button>   
                     </div>
                     
            </div>
        </div>
      
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="myOptionModal"
                            data-bs-backdrop="static"
                            ref="myOptionModal" @click.self="myOptionModalHide">
            <div class="modal-dialog" role="document">
                   <div class="modal-content">
                          <div class="modal-header" style="display:flex; justify-content: center;">
                          <a href="/member/setting" class="nomal">설정 및 개인정보</a>
                       </div>
                        <div class="modal-header" style="display:flex; justify-content: center;">
                          <a href="/member/setting?page=2" class="nomal">알림</a>
                       </div>
                    
                        <div class="modal-header" style="display:flex; justify-content: center;">
                          <a href="/member/logout" class="nomal">로그아웃</a>
                       </div>
                   
                 
                        <button type="button" class="btn"
                                data-bs-dismiss="modal" style="color:red;">취소</button>
                   
                </div>      
            </div>
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="followerModal"
                            data-bs-backdrop="static"
                            ref="followerModal" @click.self="followerModalHide">	
            <div class="modal-dialog" role="document">
                   <div class="modal-content" style="max-width:400px; min-height:200px max-height:400px;">
                       <div class="modal-header text-center" style="display:flex; justify-content: center;">
							<h5 class="modal-title">팔로워</h5>
                       </div>
                       <div class="modal-body" style="overflow-y: scroll; max-height:300px;"  @scroll="handleScroll2">
                     	<div v-for="item in myFollowerList" :key="item.attachmentNo">
                     	 						
                  <!-- 프로필 미리보기 내용 -->
  						    <div class="profile-preview" v-if="selectedItem === item" @mouseleave="profileLeave">
                  <div style="display: flex; align-items: center;">
						  <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="75" height="75" style="border-radius: 50%;"> 
						  <div>
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
						    <p class="modalName">{{ item.memberName }}</p>
						  </div>
					</div>
                    <hr>
                    <div class="col-7" style="display: flex; margin-left: 10px;">
                    	<div class="col-6">
                    		<span>게시물 <span style="font-weight: bold;">{{postCounts}}</span></span>
                    	</div>
                    	<div class="col-6">
                    		<span>팔로워 <span style="font-weight: bold;">{{followerCounts}}</span></span>
                    	</div>
                    	<div class="col-6">
							<span>팔로우 <span style="font-weight: bold;">{{followCounts}}</span></span>
                    	</div>
                    </div>
                    <div class="col-6">
                    	<div style="display:flex;">
                    	<template v-if="hoverPostList2.length === 0">
						  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 150px; text-align: center;">
							  <div style="width:500px; margin-left:160px;">
							    <i class="fa-solid fa-camera fa-2xl" style="font-size: 40px; margin-bottom:30px;"></i>
							    <h4 style="white-space: nowrap; margin-bottom: 5px;">아직 게시물이 없습니다</h4>
							    <p style="font-size: 12px; margin-top: 0;">{{item.memberNick}}님이 사진과 릴스를 공유하면 여기에 표시됩니다.</p>
							  </div>
							</div>
						</template>
											<!-- 비공개 계정 || 친구에게만 공개 && 팔로우 목록에 있다면 -->
						<template v-else-if="hoverSettingHide === 3 || (hoverSettingHide === 2 && hoverFollowerCheck == true)">
						  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 150px; text-align: center;">
							  <div style="width:500px; margin-left:160px;">
							    <img src="${pageContext.request.contextPath}/static/image/lock.png" width="60" height="60">
   								<h6 style="white-space: nowrap; margin-bottom: 5px;">비공개 계정입니다 <br>
   								사진 및 동영상을 보려면 팔로우하세요.</h6>
							  </div>
							</div>
						</template>
					   
					    <template v-else>
					      <div v-for="post in hoverPostList2" :key="post.id">
					        <!-- 게시물 정보 출력 -->
					        <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + post.attachmentNo" width="127" height="150" style="margin-right:3px;">
					      </div>
					    </template>
                    	  
                    	 </div>
                    </div>
                    <div class="col-9" style="display:flex; justify-content: space-between; margin-left:20px; margin-top:15px;">
                  
                  
          
                  	 <button class="float-end btn btn-primary" @click="follow(item.memberNo)" v-if="followCheckIf(item.memberNo)" :class="{'hide' : item.memberNo == ${memberNo}}">팔로우</button>
                  	 <button class="btn btn-primary">메시지 보내기</button>
          			 <button class="float-end btn btn-secondary" @click="myUnFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && ${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}">팔로잉</button>					  
					 <button class="float-end btn btn-secondary unfollow-button" @click="unFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && !${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}">팔로잉</button>
                   
                    </div>
          </div><!-- 팔로워 미리보기 끝 -->
						  <div style="display: flex; align-items: center;">
						   <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="60" height="60" @mouseover="profileHover(item)" style="border-radius:50%;">
						   		<div style="display: flex; flex-direction: column; justify-content: flex-start;">
  						 	<a class="modalNickName" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
  						 	<p class="modalName">{{item.memberName}}</p>
  						 		</div>
  						
						   <button class="float-end btn btn-primary" @click="follow(item.memberNo)" v-if="followCheckIf(item.memberNo)" :class="{'hide' : item.memberNo == ${memberNo}}" style="margin-left:auto;">팔로우</button>
						  <button class="float-end btn btn-secondary" @click="myUnFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && ${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}" style="margin-left:auto;">팔로잉</button>					  
						  <button class="float-end btn btn-secondary unfollow-button" @click="unFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && !${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}" style="margin-left:auto;">팔로잉</button>
						 
						</div>
						</div>
                     		
                       </div>           
                        <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">취소</button>
                </div>      
            </div>
        </div><!-- 팔로워 목록 끝 -->
        
          <div class="modal" tabindex="-1" role="dialog" id="followModal"
                            data-bs-backdrop="static"
                            ref="followModal" @click.self="followModalHide">
             <div class="modal-dialog" role="document">
    <div class="modal-content" style="max-width:400px; min-height:200px max-height:400px;">
      <div class="modal-header text-center" style="display:flex; justify-content: center;">
        <h5 class="modal-title" >팔로잉</h5>
      </div>
 		<div class="modal-header text-center" style="display:flex; justify-content: center;">
  <ul class="nav nav-tabs" style="width: 100%;">
    <li class="nav-item col-6">
       <a class="nav-link" :class="{'active': activeTab === 'peopleTab'}" @click="changeTab('peopleTab')" style="font-size:17px; padding:14px 0;">사람</a>
    </li>
    <li class="nav-item col-6">
      <a class="nav-link" :class="{'active': activeTab === 'hashtagsTab'}" @click="changeTab('hashtagsTab')" style="font-size:17px; padding:14px 0;">해시태그</a>
      </li>
  </ul>
</div>
      <div class="modal-body" style="overflow-y: scroll; max-height:300px;"  @scroll="handleScroll">
      		<div v-if="activeTab === 'peopleTab'">
      		
        <div v-for="item in myFollowList" :key="item.attachmentNo">
      		 	<div style="display: flex; align-items: center; max-width:400px; over-flow:scroll; max-height:100px;" @scroll="handleScroll" >
          			<img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="60" height="60" @mouseover="profileHover(item)" style="border-radius:50%;">
						   <div style="display: flex; flex-direction: column; justify-content: flex-start;">
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
          					<p class="modalName">{{item.memberName}}</p>
						  </div>
          <button class="float-end btn btn-primary" @click="follow(item.followFollower)" v-show="followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" style="margin-left:auto; ">팔로우</button>
          <button class="float-end btn btn-secondary unfollow-button" @click="unFollow(item.followFollower)" v-show="!followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" style="margin-left:auto;">팔로잉</button>
          </div>
            <div class="profile-preview" v-if="selectedItem === item" @mouseleave="profileLeave">
                  <!-- 프로필 미리보기 내용 -->
                   	<div style="display: flex; align-items: center;">
						  <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="75" height="75" style="border-radius: 50%;"> 
						  <div>
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
						    <p class="modalName">{{ item.memberName }}</p>
						  </div>
					</div>
                    <hr>
                    <div class="col-7" style="display: flex; margin-left: 10px;">
                    	<div class="col-6">
                    		<span>게시물 <span style="font-weight: bold;">{{postCounts}}</span></span>
                    	</div>
                    	<div class="col-6">
                    		<span>팔로워 <span style="font-weight: bold;">{{followerCounts}}</span></span>
                    	</div>
                    	<div class="col-6">
<!--                     		<span>팔로우 <span style="font-weight: bold;">{{getTotalFollowCount(item.memberNick)}}</span></span> -->
							<span>팔로우 <span style="font-weight: bold;">{{followCounts}}</span></span>
                    	</div>
                    </div>
                    <hr>
                    <div class="col-6">
                    	<div style="display:flex;">
                    	<template v-if="hoverPostList.length === 0">
						  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 150px; text-align: center;">
							  <div style="width:500px; margin-left:160px;">
							    <i class="fa-solid fa-camera fa-2xl" style="font-size: 40px; margin-bottom:30px;"></i>
							    <h4 style="white-space: nowrap; margin-bottom: 5px;">아직 게시물이 없습니다</h4>
							    <p style="font-size: 12px; margin-top: 0;">{{item.memberNick}}님이 사진과 릴스를 공유하면 여기에 표시됩니다.</p>
							  </div>
							</div>
						</template>
						
						<!-- 비공개 계정 || 친구에게만 공개 && 팔로우 목록에 있다면 -->
						<template v-else-if="hoverSettingHide === 3 || (hoverSettingHide === 2 && hoverFollowerCheck == true)">
						  <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; width: 100%; height: 150px; text-align: center;">
							  <div style="width:500px; margin-left:160px;">
							    <img src="${pageContext.request.contextPath}/static/image/lock.png" width="60" height="60">
   								<h6 style="white-space: nowrap; margin-bottom: 5px;">비공개 계정입니다 <br>
   								사진 및 동영상을 보려면 팔로우하세요.</h6>
							  </div>
							</div>
						</template>
						
						
					   
					    <template v-else>
					      <div v-for="post in hoverPostList" :key="post.id">
					        <!-- 게시물 정보 출력 -->
					        <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + post.attachmentNo" width="127" height="150" style="margin-right:3px;">
					      </div>
					    </template>
                    	  
                    	 </div>
                    </div>
                    <div class="col-9" style="display:flex; justify-content: space-between; margin-left:40px; margin-top:15px;">
                  	 <button class="btn btn-primary" @click="follow(item.followFollower)" v-if="followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" style="flex-grow:1;">팔로우</button>
                  	 <button class="btn btn-primary" v-if="!followCheckIf(item.followFollower)" style="width:50%;">메시지 보내기</button>
          			<button class="btn btn-secondary unfollow-button" @click="unFollow(item.followFollower)" v-if="!followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" style="width:50%; margin-left:20px;" >팔로잉</button>
                 </div>
                 
          </div> <!-- 팔로우 미리보기 끝 -->
          
          
          
			</div>
      		</div>
      		<div v-else-if="activeTab === 'hashtagsTab'">
      		  	<!-- 해시태그 목록 표시 -->
      		  	<div v-for="item in hashtagList" key="item.memberNo">
					<div style="display: flex; align-items: center; max-width:400px; over-flow:scroll; max-height:100px;" @scroll="handleScroll" >
          			<img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="60" height="60"style="border-radius:50%;">
						   <div style="display: flex; flex-direction: column; justify-content: flex-start;">
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/tag/' + item.tagName" style="margin-left:5px;">{{'#' + item.tagName }}</a>
          					<p class="modalName" style="margin-left:5px;">게시물 {{item.tagCount}}</p>
						  </div>
							  <button class="float-end btn btn-secondary" @click="tagFollow(item.tagName)" style="margin-left:auto;" v-show="tagFollowCheckIf(item.tagName)">팔로우</button>	
							  <button class="float-end btn btn-secondary" @click="tagUnFollow(item.tagName)" style="margin-left:auto;" v-show="!tagFollowCheckIf(item.tagName)">팔로잉</button>					  
      		  	</div>
      		</div>
      		
 
      </div>
     
    </div>
  </div>
</div> 
</div>
       <div class="modal" tabindex="-1" role="dialog" id="recommendFriendsAllListModal"
                            data-bs-backdrop="static"
                            ref="recommendFriendsAllListModal" @click.self="recommendFriendsAllListModalHide">
             <div class="modal-dialog" role="document">
    <div class="modal-content" style="max-width:400px; min-height:200px max-height:400px;">
      <div class="modal-header text-center" style="display:flex; justify-content: center;">
        <h5 class="modal-title" >비슷한 계정</h5>
      </div>
      <div class="modal-body" style="overflow-y: scroll; max-height:300px;"  @scroll="handleScroll">
        <div v-for="item in recommendFriendsList" :key="item.attachmentNo">
     
          	<div style="display: flex; align-items: center; max-width:400px; over-flow:scroll; max-height:100px;" @scroll="handleScroll" >
          			<img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="60" height="60"  style="border-radius:50%;">
						   <div style="display: flex; flex-direction: column; justify-content: flex-start;">
						    <a class="modalNickName" :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
          					<p class="modalName">{{item.memberName}}</p>
						  </div>
						  
          <button class="float-end btn btn-primary" @click="follow(item.memberNo)" v-if="followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" style="margin-left:auto;">팔로우</button>
			</div>
          
        </div>
      </div>
     
    </div>
  </div>
</div> 


<!-- 팔로우 모달 목록 끝 -->
        <!-- Modal 창 영역 끝 -->
        
        
      
      </div> <!-- vue 끝 -->
      
      


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/vue@next"></script>
      <script>
   Vue.createApp({
      data() {
         return {
        	 //▼▼▼▼▼▼▼▼▼▼▼▼▼무한 페이징▼▼▼▼▼▼▼▼▼▼▼▼▼
             percent:0,
             page : 1,
             //안전장치
             loading:false,
             finish:false,
             
        	 //▼▼▼▼▼▼▼▼▼▼▼▼▼팔로우 무한 페이징▼▼▼▼▼▼▼▼▼▼▼▼▼
             followPercent:0,
             followPage : 1,
             //안전장치
             followLoading:false,
             followFinish:false,
             
             //▼▼▼▼▼▼▼▼▼▼▼▼▼팔로워 무한 페이징▼▼▼▼▼▼▼▼▼▼▼▼▼
             followerPercent:0,
             followerPage : 1,
             //안전장치
             followerLoading:false,
             followFerinish:false,
             
             isOwner : false,
             showProfilePreview : false,
            //추가 메뉴 모달 및 신고 모달
            modal : null,
            addtionModal : null,
            reportMenuModal:null,
            blockModal : null,
            blockResultModal : null,
            myOptionModal : null,
            followerModal : null,
            followModal : null,  
            followerHoverModal : null,
            recommendFriendsAllListModal : null,
            selectedItem: null,
            reportContentList:[],
            followCheckList:[],
            myFollowerList: [],
            myFollowList: [],
            myBoardList : [],
            followCounts: null,
            followerCounts : null,
            postCounts : null,
            hoverPostList : [],
            hoverPostList2 : [],
            reportBoardNo:"",  
            memberNo : "${memberDto.memberNo}",
            memberNick : "${memberDto.memberNick}",
            attachmentNo : "${memberDto.attachmentNo}",
            member:{
               memberNo:"",
               memberName:"",
               memberEmail:"",
               memberLat:"",
               memberLon:"",
               memberPost:"",
               memberBasicAddr:"",
               memberDetailAddr:"",
               memberMsg:"",
               memberTel:"",
               memberGender:"",
               memberBirth:"",
               attachmentNo:"",
            },
            settingHide :null,
            hoverSettingHide : null,
            hoverFollowerCheck : false,
            hoverFollowCheck : false,
            totalFollowCnt: 0,
            totalFollowerCnt: 0,
            
          //상세보기 및 댓글
			detailView:false,
			detailIndex:"",
			replyList:[],
			replyParent:0,
			replyContent:"",
			placeholder:"댓글 입력..",
			
			//게시물 좋아요 기능 전용 변수
			boardLikeCount:[], // 좋아요 수를 저장할 변수
            isLiked : [], // 로그인 회원이 좋아요 체크 여부
            
			//게시물 댓글 좋아요 기능 전용 변수
			replyLikeCount : [], // 댓글 좋아요 수 저장 변수
			isReplyLiked : [], // 로그인 회원이 댓글 좋아요 체크 여부 
			recommendFriends : false,
			recommendFriendsList : [], // 친구 추천목록 리스트
			currentPage: 0,
			itemsPerPage : 4,
			followBtn : false,
			followerBtn : false,
			activeTab: 'peopleTab', // 초기 선택된 탭은 'peopleTab'입니다.
			hashtagList : [], // 해시태그 리스트
			hashtagFollowCheckList : [], // 해시태그 팔로우 체크 
			isFollowing : false, // 해시태그 팔로잉 여부
         };
      },
      computed: {
         profileUrl(){
            if(this.member.attachmentNo>0){
               return contextPath+"/rest/attachment/download/"+this.attachmentNo;
            }
            else{
               return "https://via.placeholder.com/100x100?text=profile";
            }
         },
         async getFollowCount() {
             return async (memberNick) => {
               if (!this.followCounts[memberNick]) {
                 const resp = await axios.get("totalFollowCount", {
                   params: {
                     memberNick: memberNick,
                   },
                 });
                 this.followCounts[memberNick] = resp.data;
               }
               return this.followCounts[memberNick];
             };
           },
           
           paginatedRecommendFriends() {
        	    const totalPages = Math.ceil(this.recommendFriendsList.length / this.itemsPerPage);
        	    const paginatedArray = [];

        	    for (let i = 0; i < totalPages; i++) {
        	      const startIndex = i * this.itemsPerPage;
        	      const endIndex = startIndex + this.itemsPerPage;
        	      const pageItems = this.recommendFriendsList.slice(startIndex, endIndex);
        	      paginatedArray.push(pageItems);
        	    }

        	    return paginatedArray;
        	  },
        	  displayedItems() {
        		    return this.paginatedRecommendFriends[this.currentPage];
        		  },
        	iconClass(){
        			return this.recommendFriends ? "fa-solid fa-user-plus" : "far fa-user";  
        		  },
        	  
         
         
         
      },
      methods: {
    	  changeTab(tab) {
    	      this.activeTab = tab; // 선택된 탭을 변경합니다.
    	    },
    	  
           showModal(){
                  if(this.modal == null) return;
                  this.modal.show();
              },
              hideModal(){
                  if(this.modal == null) return;
                  this.modal.hide();
              },
              
             showModal2(){
                  if(this.addtionModal == null) return;
                  this.addtionModal.show();
              },
              hideModal2(){
                  if(this.addtionModal == null) return;
                  this.addtionModal.hide();
              },
              blockModalShow(){
                  if(this.blockModal == null) return;
                  this.addtionModal.hide();
                   this.blockModal.show();      
              },
              blockModalHide(){
                 if(this.blockModal == null) return;
                  this.blockModal.hide();
              },
              blockResultModalShow(){
                 if(this.blockResultModal == null) return;
                 this.blockModal.hide();
                  this.blockResultModal.show(); 
              },
              blockResultModalHide(){
                 if(this.blockResultModal == null) return;
                  this.blockResultModal.hide(); 
              },
              myOptionModalShow(){
                 if(this.myOptionModal == null) return;
                  this.myOptionModal.show();  
              },
              myOptionModalHide(){
                 if(this.myOptionModal == null) return;
                  this.myOptionModal.hide();  
              },
              followerModalShow(){
            	  if(this.followerModal == null || this.totalFollowerCnt == 0 ) return;
                  this.followerModal.show();    
              },
              followerModalHide(){
                  if(this.followerModal == null) return;
                   this.followerModal.hide();  
               },
               followModalShow(){
             	  if(this.followModal == null || this.totalFollowCnt == 0 ) return;
                   this.followModal.show();    
               },
               followModalHide(){
                   if(this.followModal == null) return;
                    this.followModal.hide();  
                },
                followerHoverModalShow(){
                	if(this.followerHoverModal == null) return;
                	this.followerHoverModal.show();
                },
                recommendFriendsAllListModalShow(){
                	if(this.recommendFriendsAllListModal == null) return;
                	this.recommendFriendsAllListModal.show();
                },
                recommendFriendsAllListModalHide(){
                	if(this.recommendFriendsAllListModal == null) return;
                	this.recommendFriendsAllListModal.hide();
                },
              
              accountView(){
                 this.addtionModal.hide();
                 this.modal.show();
              },
             //멤버 정보 불러오기
           async loadMember(){
              const resp = await axios.get(contextPath+"/rest/member/"+memberNo);
              Object.assign(this.member, resp.data);
           },
              
             //프로필 사진 변경 누르면 실행
            openFileInput() {
              this.$refs.fileInput.click();
           },
           //파일이 추가되면 실행
         handleFileUpload(event) {
            const file = event.target.files[0];
            // 파일 업로드 로직 처리
            if (file) {
               let fd = new FormData();
               fd.append("attach", file);
               this.uploadProfile(fd);
            };
         },
         //파일 저장 비동기 처리
         async uploadProfile(formData){
            const resp = await axios.post(contextPath+"/rest/attachment/upload/profile", formData);
            this.member.attachmentNo = resp.data;
         },
         
         //팔로우
         async follow(followNo) {
        	  this.isLoading = true; 
        	 
         	const resp = await axios.post("${pageContext.request.contextPath}/rest/follow/"+followNo);
         	await this.followCheck();
         	
         
         	
         	this.totalFollowerCount();    
         	this.totalFollowCount();
         	this.followerListPaging();
         	this.followListPaging();
         	
         	
         	
         },
         
         //팔로워 되있는사람 -> 팔로우 삭제
      async unFollower(memberNo) {
		  try {
		    const response = await axios.post("/rest/follow/unFollow", null, {
		      params: {
		        followFollower: memberNo
		      }
		    });
		
		    if (response.data) {
		      // 언팔로우 성공 처리
		      console.log("언팔로우 성공");
		      this.totalFollowerCount();
		      this.totalFollowCount();
		      this.followerListPaging();
		      this.followListPaging();
		      const index = this.followCheckList.findIndex(item => item === memberNo);
		      if (index !== -1) {
		        this.followCheckList.splice(index, 1);
		      }
		      console.log("index : "+index);
		      console.log("list 후: "+this.followCheckList);
		      
		    } else {
		      // 언팔로우 실패 처리
		      console.log("언팔로우 실패");
		    }
		  } catch (error) {
		    // 요청 실패 처리
		    console.error("언팔로우 요청 실패", error);
		  }
		},
			// 팔로워 되있는 사람 -> 팔로우 삭제 (본인 프로필 일때)
		   async myUnFollower(memberNo) {
			  try {
			    const response = await axios.post("/rest/follow/myUnFollow", null, {
			      params: {
			        memberNo: memberNo
			      }
			    });
			
			    if (response.data) {
			      // 언팔로우 성공 처리
			      console.log("언팔로우 성공");
			      this.totalFollowerCount();
			      this.totalFollowCount();
			      this.followerListPaging();
			      this.followListPaging();
			     
			     
			           
			    } else {
			      // 언팔로우 실패 처리
			      console.log("언팔로우 실패");
			    }
			  } catch (error) {
			    // 요청 실패 처리
			    console.error("언팔로우 요청 실패", error);
			  }
			},
		
		
		
	     //팔로우 되있는사람 -> 팔로우 삭제
	 async unFollow(memberNo) {
			  try {
				  this.isLoading = true;
			    const response = await axios.post("/rest/follow/unFollow", null, {
			      params: {
			        followFollower: memberNo
			      }
			    });
			    if (response.data) {
			      // 언팔로우 성공 처리   
			     
			      // followCheckList 업데이트
			      const index = this.followCheckList.indexOf(memberNo);
			      if (index > -1) {
			    	  this.followCheckList.splice(index, 1);
			      }
			      

			      console.log("언팔로우 성공");
			      this.totalFollowCount();
			      this.totalFollowerCount();
			      this.followListPaging();
			      await this.$nextTick(); // 다음 UI 업데이트를 기다립니다.
				
			      
			      
			      console.log("followCheckList : "+this.followCheckList);
			    } else {
			      // 언팔로우 실패 처리
			      console.log("언팔로우 실패");
			    }
			  } catch (error) {
			    // 요청 실패 처리
			    console.error("언팔로우 요청 실패", error);
			  }
			},
						
		 
         // 팔로우 v-if 여부체크 함수
        	followCheckIf(memberNo){
         	
        		return !this.followCheckList.includes(memberNo);
         },
          
      	 //팔로우 여부 체크
         async followCheck() {
         	const resp = await axios.post("${pageContext.request.contextPath}/rest/follow/check");
    
         	const newData = memberNo;
         	
         	  this.followCheckList = []; // followCheckList 초기화
         	// this.followCheckList = resp.data;
         	this.followCheckList.push(...resp.data);
         	this.followCheckList.push(parseInt(newData));
 
         }, 
        
         
       
       
         // 팔로우 총 개수 
         async totalFollowCount() {
        	    const resp = await axios.get("totalFollowCount", {
        	        params: {
        	            memberNick: this.memberNick
        	        }
        	    });
        	    this.totalFollowCnt = resp.data;
        	},
        	
        	        	
        	 // 팔로워 총 개수 
            async totalFollowerCount() {
           	    const resp = await axios.get("totalFollowerCount", {
           	        params: {
           	            memberNick: this.memberNick
           	        }
           	    });
           	    this.totalFollowerCnt = resp.data;           	    
           	},
           	
           	// 호버시 팔로우 총 개수
           	async getTotalFollowCount(memberNick) {
           
           	      const resp = await axios.get("totalFollowCount", {
           	        params: {
           	          memberNick: memberNick
           	        }
           	      });
           	     return resp.data;	   
           	},
           	
         	// 호버시 팔로워 총 개수
           	async getTotalFollowerCount(memberNick) {
           
           	      const resp = await axios.get("totalFollowerCount", {
           	        params: {
           	          memberNick: memberNick
           	        }
           	      });
           	     return resp.data;	   
           	},
           	
           	// 호버시 게시물 총 개수
           		async getTotalPostCount(memberNick) {
           
           	      const resp = await axios.get("totalPostCount", {
           	        params: {
           	          memberNick: memberNick
           	        }
           	      });
           	     return resp.data;	   
           	},

           	
        	// 본인 팔로우 목록 불러오기 무한스크롤
        async followListPaging() {
		  if (this.followLoading === true) return; // 로딩중이면
		  if (this.followFinish === true) return; // 다 불러왔으면
		  this.followLoading = true;
		  
		  try {
		    const resp = await axios.get("/rest/member/followListPaging/" + this.followPage, {
		      params: {
		        memberNo: this.memberNo
		      }
		    });
		    
		    
		
		    const newData = resp.data;
		    for (const item of newData) {
		      const existingItem = this.myFollowList.find(followItem => followItem.followFollower === item.followFollower);
		      if (!existingItem) {
		        this.myFollowList.push(item);
		      }
		    }
		
		    this.followPage++;
		    console.log("res: ", resp.data.length);
		    console.log("팔로우체크 " + this.followCheckList); 
		
		    if (resp.data.length < 3) {
		      this.followFinish = true;
		    }
		    
		  // this.followCheck();
		  } catch (error) {
		    console.error("Error occurred during followListPaging: ", error);
		  }
		  
		  this.followLoading = false;
		},
		
		
		
		
	   	// 본인 팔로워 목록 불러오기 무한스크롤
       async followerListPaging() {
		  if (this.followerLoading === true) return; // 로딩중이면
		  if (this.followerFinish === true) return; // 다 불러왔으면
		  this.followerLoading = true;
		  
		  try {
		    const resp = await axios.get("/rest/member/followerListPaging/" + this.followerPage, {
		      params: {
		        memberNo: this.memberNo
		      }
		    });
		
		    const newData = resp.data;
		    for (const item of newData) {
		      const existingItem = this.myFollowerList.find(followerItem => followerItem.memberNo === item.memberNo);
		      if (!existingItem) {
		        this.myFollowerList.push(item);
		      }
		    }
		
		    this.followerPage++;
	
		
		    if (resp.data.length < 3) {
		      this.followerFinish = true;
		    }
		    
		  } catch (error) {
		    console.error("Error occurred during followerListPaging: ", error);
		  }
		  
		  this.followerLoading = false;
		},
		
           	
           	
           	// 마이페이지 게시물 목록 불러오기
           	async boardList(){
           	  if(this.loading == true) return; //로딩중이면
              if(this.finish == true) return; //다 불러왔으면
              this.loading = true;
              
           		const resp = await axios.get("/rest/member/page/"+this.page,{
           			params : {           
           				memberNo : this.memberNo
           			
           			},
           		});
           		
           	 for (const board of resp.data) {
             	this.isLiked.push(await this.likeChecked(board.boardWithNickDto.boardNo));
             	//console.log(this.isLiked);
             	this.boardLikeCount.push(board.boardWithNickDto.boardLike);
             	//this.followCheck(board.boardWithNickDto.memberNo);
             	//console.log(this.boardLikeCount);
             	//this.boardLikeCount.push(board.boardLike);
             	//this.boardLikeCount = boardList.boardLike;
               }
           		
           	  const newData = resp.data;
  		   /*  for (const item of newData) {
  		      const existingItem = this.myBoardList.find(boardItem => boardItem.boardNo === item.boardNo);
  		      if (!existingItem) {
  		        this.myBoardList.push(item);
  		      }
  		    } */
  		    
  		    this.myBoardList.push(...resp.data);
           		this.page++;
           		
           		if(resp.data < 5) this.finish = true;
           	
           		console.log(this.myBoardList);
           		
           		this.loading = false;
           		
           	},
           	
           	async boardList2(memberNo) {
           	  const resp = await axios.get("/rest/member/postList",{
           	    params: {
           	      memberNo: memberNo
           	    }
           	  });
				this.hoverPostList = [];
				//console.log("데이터 : "+resp.data);
           	  const newPosts = resp.data.slice(0, 3); // 최대 3개의 게시물만 추출

           	  this.hoverPostList.push(...newPosts);
           	},
           	
        	async boardList3(memberNo) {
             	  const resp = await axios.get("/rest/member/postList",{
             	    params: {
             	      memberNo: memberNo
             	    }
             	  });
  				this.hoverPostList2 = [];
  				//console.log("데이터 : "+resp.data);
             	  const newPosts = resp.data.slice(0, 3); // 최대 3개의 게시물만 추출

             	  this.hoverPostList2.push(...newPosts);
             	  
             	},
           	
           	checkOwnerShip(){ // 본인인지 여부 체크
           		this.isOwner = this.memberNo == ${memberNo};
           	},
           async profileHover(item) {           		
           	  this.selectedItem = item; // 선택한 항목의 정보 저장
           	  
           	  // settingHide 불러오기 위해서 선언
           	const resp = await axios.get("/rest/member/setting/"+item.memberNo);
           	  const settingHide = resp.data.settingHide;
           	 
           	  
           	  Promise.all([
           		 this.getTotalFollowCount(item.memberNick), // 팔로우 수 가져오기
              	 this.getTotalFollowerCount(item.memberNick), // 팔로워 수 가져오기
              	 this.getTotalPostCount(item.memberNick), // 게시물 수 가져오기 
              	 this.boardList2(item.followFollower), // 게시물 목록 가져오기
              	 this.boardList3(item.memberNo) // 게시물 목록 가져오기
             
           	  ])          	 
           	    .then(([followCounts,followerCounts,postCounts]) => {
           	      this.followCounts = followCounts; // 프로미스가 해결된 값 저장
           	      this.followerCounts = followerCounts; // 프로미스가 해결된 값 저장
           	      this.postCounts = postCounts; // 프로미스가 해결된 값 저장
           	      this.hoverSettingHide = settingHide;
           	      this.hoverFollowerCheck = this.followCheckIf(item.memberNo);
           	      this.hoverFollowCheck = this.followCheckIf(item.followFollower);
           	   		console.log("settingHide : "+this.hoverSettingHide);
           	   		console.log("hoverFollowerCheck : " + this.followCheckIf(item.memberNo));
           	   		console.log("hoverFollowCheck : " + this.followCheckIf(item.followFollower));
           	      //console.log("팔로우 수 : " +this.followCounts); // 수정된 값 출력
           	      //console.log("팔로워 수 : "+this.followerCounts); // 수정된 값 출력
           	      //console.log("게시물 수 : " +this.postCounts); // 수정된 값 출력
           	   	  //console.log("게시물 목록: ", this.hoverPostList); // 게시물 목록 출력
           	    })
           	    .catch(error => {
           	      console.error(error);
           	    });
           	},
           	
           	profileLeave(){
           		this.selectedItem = null;
           	},
           	
           	boardInsert(){
           	// /board/insert로 이동
           	    window.location.href = '/board/insert';
           	},
           	
           	
           	handleScroll() {
           	  const modalElement = this.$refs.followModal;
           	  const bodyElement = modalElement.querySelector('.modal-body');
           	  const contentHeight = bodyElement.scrollHeight;
           	  const currentScroll = bodyElement.scrollTop;
           	  const visibleHeight = bodyElement.clientHeight;
           	  const scrollPercentage = (currentScroll / (contentHeight - visibleHeight)) * 100;
           	  this.followPercent = Math.round(scrollPercentage);
	
           	  if (this.followPercent >= 80) {
           	    this.followListPaging();
           	  }
           	},
           	
          	handleScroll2() {
             	  const modalElement = this.$refs.followerModal;
             	  const bodyElement = modalElement.querySelector('.modal-body');
             	  const contentHeight = bodyElement.scrollHeight;
             	  const currentScroll = bodyElement.scrollTop;
             	  const visibleHeight = bodyElement.clientHeight;
             	  const scrollPercentage = (currentScroll / (contentHeight - visibleHeight)) * 100;
             	  this.followerPercent = Math.round(scrollPercentage);
	
             	  if (this.followerPercent >= 80) {
             	    this.followerListPaging();
             	  }
             	},
            async memberSetting(){
             	const resp = await axios.get("/rest/member/setting/" +this.memberNo);
             	this.settingHide = resp.data.settingHide;           	
             },
             
             //댓글 조회
             async replyLoad(index) {
             	this.replyList = [];
             	this.isReplyLiked = [];
             	this.replyLikeCount = [];
             	const resp = await axios.get("${pageContext.request.contextPath}/rest/reply/"+ this.myBoardList[index].boardWithNickDto.boardNo);
                 
             	for (const reply of resp.data) {
                 	this.isReplyLiked.push(await this.likeReplyChecked(reply.replyNo));
                 	this.replyLikeCount.push(reply.replyLike);
                   }
             	
             	this.replyList=[...resp.data];
             },
             
             //댓글 등록
             async replyInsert(index) {
             	  const boardNo = this.myBoardList[index].boardWithNickDto.boardNo;
             	  
             	  const requestData = {
             	    replyOrigin: boardNo,
             	    replyContent: this.replyContent,
             	    replyParent : this.replyParent
             	  };
             	  this.replyContent='';
             	  
             	  try {
             	    const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
             	    this.replyLoad(index);	    
             	  } 
             	  catch (error) {
             	    console.error(error);
             	  }
             },
             
             //댓글 삭제
             async replyDelete(index,index2) {
             	const resp = await axios.delete("${pageContext.request.contextPath}/rest/reply/"+ this.replyList[index].replyNo);
             	this.replyLoad(index2);
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
             
           	//대댓글 펼치기
             showReReply(replyNo,index){
           		const arrayIndex = [];
           	 	const tmp = index+1;
           	  	if(index!=this.replyList.length){
           		  	//console.log(replyNo);
               	  	while(true){
               		  	if(this.replyList[tmp]==null) break;
               		  	if(this.replyList[tmp].replyParent==replyNo){
     	         			  //console.log(tmp);
     	         			  arrayIndex.push(tmp);
     	         			  tmp++;
     	         		  }
               		  	else if(this.replyList[tmp].replyParent==-1||this.replyList[tmp].replyParent==0) break;
     	         	  }
     	         	  
               	  	if(arrayIndex.length >= 1){
     	             	  for(var i = 0; i<arrayIndex.length; i++){
     	             		  this.replyList[arrayIndex[i]].replyParent = -1;
     	             	  }
     	             	 //console.log("-1만들기");
     	             	 return;
     	         	  }
     	         	  
     	         	  while(true){
     	         		  if(this.replyList[tmp]==null) break;
     	         		  if(this.replyList[tmp].replyParent==-1){
     	         			  //console.log(tmp);
     	         			  arrayIndex.push(tmp);
     	         			  tmp++;
     	         		  }else if(this.replyList[tmp]==null||this.replyList[tmp].replyParent==0) break;
     	         	  }
     	         	  
     	         	  for(var i = 0; i<arrayIndex.length; i++){
     	         		  this.replyList[arrayIndex[i]].replyParent = replyNo;
     	         	  }
     	         	  //console.log("+만들기");
     	     	  }
     	     	  console.log(arrayIndex);
     	        },
              
              //대댓글 숨기기 보기 상태변경
              replyStatus(index){
     				if(index==this.replyList.length) return;
           	   		if(this.replyList[index+1]!=null&&this.replyList[index+1].replyParent>0){
     		      		   return "답글 보기";
     		      	}
           	   		else if(this.replyList[index+1]!=null&&this.replyList[index+1].replyParent==0){
     		      		   return "";
     		      	   }
           	   		else if(this.replyList[index+1]!=null&&this.replyList[index+1].replyParent<0){
     		      		   return "답글 숨기기";
     		      	   }
           	  
              },
             
             //상세보기 모달창 열기
             detailViewOn(index) {
             	this.detailView = true;
             	this.detailIndex = index;
             	this.replyLoad(index);
             },
             
             //상세보기 모달창 닫기
             closeDetail() {
             	this.detailView = false;
             	this.replyList = [];
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
             async likePost(boardNo, index) {
                 const resp = await axios.post("${pageContext.request.contextPath}/rest/board/like", {boardNo:boardNo});
                 if(resp.data.result){
                 	this.isLiked[index] = true;
                 }
                 else {
                 	this.isLiked[index] = false;
                 }
                 
                 this.boardLikeCount[index] = resp.data.count;
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
             		//return day + "일 전";
             	}
             		//return Math.floor(time) + "시간 전";
             	
             	
             },
             // 친구 추천 버튼
             recommend(){
            	 this.recommendFriends = !this.recommendFriends;
             },
             
             // 친구 추천목록 조회
             async recommendList(){
            	const resp = await axios.get("/rest/member/recommendFriendsList");
            	this.recommendFriendsList.push(...resp.data);
            	
            	// sessionStorage에 친구 추천목록 저장
            	sessionStorage.setItem("recommendFriendsList",JSON.stringify(this.recommendFriendsList));
            	console.log("친구 추천 목록 : " +this.recommendFriendsList.length);
             },
             
            deleteRecommendFriend(idToDelete){
            	
            	 // 추천 친구목록 가져오기
            	 const cachedRecommendFriendsList = sessionStorage.getItem("recommendFriendsList");
            	 const recommendFriendsList = JSON.parse(cachedRecommendFriendsList);
            	
            	 
            	 // 삭제할 데이터의 인덱스 찾기
            	 const indexToDelete = recommendFriendsList.findIndex(item => item.memberNo === idToDelete);
            	 console.log("indexToDelete" + indexToDelete);
            	// 인덱스를 사용하여 데이터 삭제
            	  if (indexToDelete !== -1) {
            	    recommendFriendsList.splice(indexToDelete, 1);
            	    
            	    // 수정된 목록을 다시 sessionStorage에 저장
            	    sessionStorage.setItem("recommendFriendsList", JSON.stringify(recommendFriendsList));
           	    	console.log(sessionStorage.getItem("recommendFriendsList"));
           	    	
           	     this.recommendFriendsList = recommendFriendsList;
            	  }
             },
             
             async hashtTagList() {
            	  try {
            	    const resp = await axios.get("/rest/member/hashtagList", {
            	      params: {
            	        memberNo: this.memberNo,
            	      },
            	    });
            	    
            	    this.hashtagList.push(...resp.data);
            	    this.hashtagFollowCheck();
            	   console.log("hash : "+this.hashtagList);
      	   
            	  } catch (error) {
            	    console.error(error);
            	  }
            	},
            	
            	async tagUnFollow(tagName) {
            		  try {
            		    const resp = await axios.post("/rest/follow/tagUnFollow/" + tagName);
            		    if (resp.data) {
            		      console.log("언팔로우 성공");

            		      // Remove unfollowed tagName from hashtagList
            		      const index = this.hashtagList.findIndex(item => item.tagName === tagName);
            		      if (index !== -1) {
            		        this.hashtagList.splice(index, 1);
            		      }

            		      console.log("hashtagList: " + this.hashtagList);
            		      this.hashtagFollowCheck();
            		    } else {
            		      console.log("언팔로우 실패");
            		    }
            		  } catch (error) {
            		    console.error(error);
            		  }
            		},

      			async tagFollow(tagName) {
      			  const resp = await axios.post("/rest/follow/tagFollow/" + tagName);
      			  if (resp.data) {
      				
      			    console.log("팔로우 성공");
      			    console.log("hashtagList: " + this.hashtagList);
      			    
      			    this.hashtagFollowCheck();

      			    // Add followed tagName to hashtagList
      			    
      			  } else {
      			    console.log("팔로우 실패");
      			  }
      			},
      			
      			// 태그 팔로우 v-if 여부체크 함수
      		tagFollowCheckIf(tagName) {
				  return !this.hashtagFollowCheckList.includes(tagName);
			},
      			
				
			async hashtagFollowCheck() {
				  try {
				    const resp = await axios.post("/rest/follow/hashTagCheck");
				    this.hashtagFollowCheckList = resp.data;
				    console.log("hashtagFollowCheckList : "+this.hashtagFollowCheckList);
				  } catch (error) {
				    console.error(error);
				  }
				}
      },
      		
      created() {
    	  // 데이터 불러오는 영역
    	  this.loadMember();
    	  this.totalFollowCount();
    	  this.totalFollowerCount();
    	  this.memberSetting();
    	  this.recommendList();
    	  this.hashtTagList();
    	  this.hashtagFollowCheck();
    	  Promise.all([this.followListPaging(), this.followerListPaging(), this.boardList()])
    	    .then(() => {
    	      this.followCheck();
    	    })
    	    .catch((error) => {
    	      console.error("Error occurred during initialization: ", error);
    	    });
    	},
      watch:{
    	// percent가 변하면 percent의 값을 읽어와서 80% 이상인지 판정
    	percent(){
    		if(this.percent >= 80){
    			this.boardList();
    		}
    	},
    	
    	
   	
      },
      mounted(){   
			this.checkOwnerShip();
            this.modal = new bootstrap.Modal(this.$refs.modal03);
            this.addtionModal = new bootstrap.Modal(this.$refs.addtionModal);
            this.blockModal = new bootstrap.Modal(this.$refs.blockModal);
            this.blockResultModal = new bootstrap.Modal(this.$refs.blockResultModal);
            this.myOptionModal = new bootstrap.Modal(this.$refs.myOptionModal);
            this.followerModal = new bootstrap.Modal(this.$refs.followerModal);
            this.followModal = new bootstrap.Modal(this.$refs.followModal);
            this.recommendFriendsAllListModal = new bootstrap.Modal(this.$refs.recommendFriendsAllListModal);
        
            window.addEventListener("scroll", _.throttle(()=>{
            
            const height = document.documentElement.scrollHeight - window.innerHeight;
			const current = window.scrollY;
			const percent = (current / height) * 100;
			

           		this.percent = Math.round(percent);
           		console.log(percent);
            },250));
            
          
      },
      
   }).mount("#app");
</script>
<%@ include file="../template/footer.jsp" %>