<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	p .card-text {
  		margin: 0 0 4px;
	}

    b {
        font-size: 15px;
    }

    h4{
    	height: 25px;
    	margin: 0px 0px 6px 0px;
    }
    
    h5 {
        margin: 0px 0px 4px;
        display: flex;
        flex-direction: row-reverse;
    }

    h6 {
        margin : 0px 0px 4px;
    }

    .profile {
        width: 50px;
        height: 50px;
        object-fit: cover;
        object-position: center;
        border-radius: 50%;
    }

    .head_feed {
        display: table;
        margin: 5px auto 5px auto;
        width: 80%;
        max-width: 650px;
        max-width: 650px;
    }

    .fix_test {
        position: fixed;
        width: 100%;
        max-width: 250px;
    }

    .carousel-inner img {
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
	
	.isFollow {
	display: none;
	}
	
	
	 .fullscreen{
            position:fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 5555;
            
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
	
	.childReply{
		padding-left: 35px;
	}
	.childShow{
		display: none;
	}
/* 차단 관련 css */
.report-content:hover{
	background-color:rgba(34, 34, 34, 0.05);
}
</style>
<div id="app">
	<div class="container" style="margin-top: 20px; max-width: 1000px">
        <div class="row" v-for="(board, index) in boardList" :key="board.boardNo">
            <!--●●●●●●●●●●●●●●피드공간●●●●●●●●●●●●●●●●●●●●●●-->
            <div class="col" style="max-width: 620px; margin: 0 auto 10px auto;">
                <!--피드001-->
                <div class="head_feed bg-white" style="border: 0.5px solid #b4b4b4; border-radius: 10px;">
                    <div class="d-flex flex-column">
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼ID▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div style="padding: 8px 8px 4px 8px;">
                            <div class="d-flex">

                                <div class="p-2"><a style="padding: 0 0 0 0" @click="moveToMemberPage(board.boardWithNickDto.memberNo, board.boardWithNickDto.memberNick)"><img class="profile rounded-circle" :src="profileUrl(index)" style="object-fit: cover;"></a></div>
                                <div class="p-2" style="margin-top: 8px;"><h4><a class="btn btn-none" style="padding: 0 0 0 0" @click="moveToMemberPage(board.boardWithNickDto.memberNo, board.boardWithNickDto.memberNick)"><b>{{board.boardWithNickDto.memberNick}}</b></a><b style="color: gray;">  · {{dateCount(board.boardWithNickDto.boardTimeAuto)}}</b></h4></div>

                                <div v-if="followCheckIfNew(index)" @click="follow(board.boardWithNickDto.memberNo)" class="p-2 me-5" style="margin-top: 8px;"><h4><b style="font-size: 15px; color:blue; cursor: pointer;">팔로우</b></h4></div>
                                 <div v-else class="p-2 me-5" style="margin-top: 8px;"><h4><b></b></h4></div> 
                            <!-- 메뉴 표시 아이콘으로 변경(VO로 변경 시 경로 수정 필요) -->

                                <div class=" p-2 flex-grow-1 me-2" style="margin-top: 14px;"><i class="fa-solid fa-ellipsis" style="display:flex; flex-direction: row-reverse; font-size:26px" @click="showAdditionalMenuModal(board.boardWithNickDto.boardNo, board.boardWithNickDto.memberNo, 'board')"></i></div>
                            </div>
                        </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲ID▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼사진▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div style="padding: 4px 8px 8px 8px;">
                            <div :id="'carouselExampleIndicators'+index" class="carousel slide">
                                
                                <div class="carousel-indicators">
                                  <button v-for="(attach, index2) in boardList[index].boardAttachmentList" :key="index2" type="button" :data-bs-target="'#carouselExampleIndicators'+index" :data-bs-slide-to="index2" :class="{'active':index2==0}" :aria-current="index2==0?true:false" :aria-label="'Slide '+(index2+1)"></button>
                                </div>
                               
                                <div class="carousel-inner">
                                  <div  v-for="(attach, index2) in boardList[index].boardAttachmentList" :key="index2" class="carousel-item" :class="{'active':index2==0}">
                                   	<img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+attach.attachmentNo" class="d-block" @dblclick="likePost(board.boardWithNickDto.boardNo,index)"> 
                                  </div>
                                </div>
                               
                                <button class="carousel-control-prev" type="button" :data-bs-target="'#carouselExampleIndicators' + index" data-bs-slide="prev">
                                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                  <span class="visually-hidden">Previous</span>
                                </button>
                                <button  class="carousel-control-next" type="button" :data-bs-target="'#carouselExampleIndicators' + index" data-bs-slide="next">
                                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                  <span class="visually-hidden">Next</span>
                                </button>
                              </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲사진▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼좋아요▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div class="p-1" style="height: 40px;">
                            <div class="d-flex">
                                <div class="p-2"><i :class="{'fa-heart': true, 'like':isLiked[index], 'fa-solid': isLiked[index], 'fa-regular': !isLiked[index]}" @click="likePost(board.boardWithNickDto.boardNo,index)" style="font-size: 32px;"></i></div>
                                <div class="p-2"><img src="${pageContext.request.contextPath}/static/image/dm.png"></div>
                                <div class="p-2"><img src="${pageContext.request.contextPath}/static/image/message_ico.png"></div>
                                <div class="p-2 flex-grow-1">
                                <h5><i class="fa-regular fa-bookmark"  @click="bookmarkInsert(board.boardWithNickDto.boardNo)" v-show="bookmarkChecked(board.boardWithNickDto.boardNo)" style="font-size:25px;"></i>
                                <i class="fa-solid fa-bookmark" @click="bookmarkInsert(board.boardWithNickDto.boardNo)" v-show="!bookmarkChecked(board.boardWithNickDto.boardNo)" style="font-size:25px;"></i></h5>
                                </div>
                            </div>
                        </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲좋아요▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼멘트▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div class="p-1">
                            <h4 class="mt-1"><b @click="showLikeListModal(board.boardWithNickDto.boardNo)" style="cursor: pointer;">좋아요 {{boardLikeCount[index]}}개</b></h4>
                            <h4><a class="btn btn-none" style="padding: 0 0 0 0" @click="moveToMemberPage(board.boardWithNickDto.memberNo, board.boardWithNickDto.memberNick)"><b>{{board.boardWithNickDto.memberNick}}</b></a></h4>
                            <p style="height: 20px;overflow: hidden; width: 400px;white-space: nowrap;text-overflow: ellipsis;margin-bottom:5px;">
                            	<span class="textHide">
                            		{{board.boardWithNickDto.boardContent}}
                            		<br v-if="boardList[index].boardTagList.length > 0"><br v-if="boardList[index].boardTagList.length > 0">
                            		<a @click="moveToTagPage(tag.tagName)" v-for="(tag, index3) in boardList[index].boardTagList" :key="index3" style="margin-right: 0.5em; color:blue; cursor: pointer;">\#{{tag.tagName}}</a>
                            	</span>
                            </p>                            
                            
                            <h6 style="cursor: pointer; color:gray; display:none;">더 보기</h6>
                        </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲멘트▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼댓글 모달창 열기▼▼▼▼▼▼▼▼▼▼▼▼▼-->
             			<div class="p-1">
             				<h6 @click="detailViewOn(index)" style="cursor: pointer; color:gray;">댓글 보기</h6>             
             			</div>           
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲댓글 모달창 열기▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼댓글입력창▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div class="p-1">
                            <div class="d-flex">
<!--                                 <div class="p-2"><img src="/static/image/emoticon.png"></div> -->
                                <div class="p-1"><input class="form-control" type="text" placeholder="댓글 달기..." v-model="replyContent" @input="replyContent = $event.target.value" @keyup.enter="replyInsert(index),detailViewOn(index)"
                                                        style="border: 2px solid white; width: 24em;"></div>
                                <div class="p-2 flex-grow-1"><h5 style="color: dodgerblue" @click="replyInsert(index),detailViewOn(index)">게시</h5></div>
                            </div>
                        </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲댓글입력창▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                    </div>
                </div>
            </div>
         </div>
     </div>
     
     <div v-if="newListFinish"  style="max-width: 620px;  margin: 10px auto 10px auto;">
     	<img src="${pageContext.request.contextPath}/static/image/check.png" class="justify-content-center align-items-center" style="width: 150px; height: 150px; margin-left: 230px; margin-bottom: 20px;">
     	<h3 class="justify-content-center text-center">모두 확인했습니다</h3>
     	<h6 class="justify-content-center text-center" style="color:gray; ">최근 3일 동안 올라온 게시물을 모두 확인했습니다.</h6>
     	<h6 class="justify-content-center text-center" @click="loadOldList()" style="color: blue; cursor: pointer;">이전 게시물 보기</h6>     	
     </div>
     
     
     
     
    
 
    
    </div>
    
<!-- ---------------------------------게시물 상세보기 모달-------------------------- -->

<div v-if="detailView" class="container-fluid fullscreen" @click="closeDetail">
	
	<div class="p-4 mt-2 ms-4 d-flex justify-content-end">
		<h2 class="btn btn-none" @click="closeDetail()" style="font-size: 30px; color:#FFFFFF;">X</h2>
	</div>
	<div class="row fullscreen-container" @click.stop >
		<div class="col-7 offset-1" style="padding-right: 0;padding-left: 0;">
			<div :id="'detailCarousel'+ detailIndex" class="carousel slide">
                <div class="carousel-indicators">
                  <button v-for="(attach, index2) in boardList[detailIndex].boardAttachmentList" :key="index2" type="button" :data-bs-target="'#detailCarousel'+ detailIndex" :data-bs-slide-to="index2" :class="{'active':index2==0}" :aria-current="index2==0?true:false" :aria-label="'Slide '+(index2+1)"></button>
                </div>
               
                <div class="carousel-inner">
                  <div  v-for="(attach, index2) in boardList[detailIndex].boardAttachmentList" :key="index2" class="carousel-item" :class="{'active':index2==0}">
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
	           		<img class="profile" :src="profileUrl(detailIndex)">
           			<a class="btn btn-none" style="padding: 0 0 0 0; margin-left: 0.5em;" :href="'${pageContext.request.contextPath}/member/'+boardList[detailIndex].boardWithNickDto.memberNick"><b>{{boardList[detailIndex].boardWithNickDto.memberNick}}</b></a>
           		</div>
				
				<div class="card-body card-scroll" ref="scrollContainer"  style="height:490px; padding-top: 0px; padding-left:0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<p class="card-text" style="margin-left: 0.5em;">{{boardList[detailIndex].boardWithNickDto.boardContent}}
					<br v-if="boardList[detailIndex].boardTagList.length > 0"><br v-if="boardList[detailIndex].boardTagList.length > 0">
                            	<a @click="moveToTagPage(tag.tagName)" v-for="(tag, index3) in boardList[detailIndex].boardTagList" :key="index3" style="margin-right: 0.5em; color: blue; cursor: pointer;">\#{{tag.tagName}}</a>
					</p>
					
					
					<div v-if="replyList.length > 0" v-for="(reply,index) in replyList" :key="index" class="card-text" :class="{'childReply':reply.replyParent!=0}" style="position: relative;">
						<a :href="'${pageContext.request.contextPath}/member/'+ replyList[index].memberNick" style="color:black;text-decoration:none; position:relative;">
							<img v-if="replyList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ replyList[index].attachmentNo" width="42" height="42" style="border-radius: 70%;position:absolute; margin-top:5px; margin-left: 4px">
							<img v-else src="https://via.placeholder.com/42x42?text=profile" style="border-radius: 70%;position:absolute; margin-top:5px; margin-left: 4px">
							
							<p style="padding-left: 3.5em; margin-bottom: 1px; font-size: 0.9em; font-weight: bold;">{{replyList[index].memberNick}}</p>
												
						</a>
						<p style="padding-left:3.5em;margin-bottom:1px;font-size:0.9em;">{{replyList[index].replyContent}}</p>
<!-- 						<p style="padding-left:4.0em;margin-bottom:1px;font-size:0.8em; color:gray;"> -->
						<div class="row">
							<div class="col-10">
								<p style="padding-left:4.0em;margin-bottom:3px;font-size:0.8em; color:gray;">{{dateCount(replyList[index].replyTimeAuto)}} &nbsp; 좋아요 {{replyLikeCount[index]}}개 &nbsp;
									<a style="cursor: pointer;" v-if="reply.replyParent==0" @click="reReply(replyList[index].replyNo)">답글 달기</a>  
									<i :class="{'fa-heart': true, 'like':isReplyLiked[index],'ms-2':true, 'fa-solid': isReplyLiked[index], 'fa-regular': !isReplyLiked[index]}" @click="likeReply(reply.replyNo,index)" style="font-size: 0.9em;"></i>
									&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
									<i v-if="replyList[index].replyMemberNo == loginMemberNo" @click="replyDelete(index,detailIndex)" class="fa-solid fa-xmark" style="color:red; cursor: pointer;"></i>
								</p>
							</div>
						<!-- 댓글 신고창 -->
							<div class="col-2 p-0 d-flex justify-content-center">
								<p class="d-flex align-items-center"><i class="fa-solid fa-ellipsis" style="display:flex; flex-direction: row-reverse;" @click="showAdditionalMenuModal(reply.replyNo, reply.replyMemberNo, 'reply')"></i></p>
							</div>
						</div>
						
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
					<!-- 북마크 오른쪽 정렬 수정 06/04 재영 -->
					<!-- <p class="card-text" style="margin: 0 0 4px 0;">
						
						<i :class="{'fa-heart': true, 'like':isLiked[detailIndex],'ms-2':true, 'fa-solid': isLiked[detailIndex], 'fa-regular': !isLiked[detailIndex]}" @click="likePost(boardList[detailIndex].boardWithNickDto.boardNo,detailIndex)" style="font-size: 27px;"></i>
						&nbsp;
						<i class="fa-regular fa-message mb-1" style="font-size: 25px;"></i>
						
					</p> -->
				<span class="card-text" style="margin: 0 0 4px 0;">
				  <div class="d-flex">
				    <i :class="{'fa-heart': true, 'like':isLiked[detailIndex], 'fa-solid': isLiked[detailIndex], 'fa-regular': !isLiked[detailIndex]}"
				       @click="likePost(boardList[detailIndex].boardWithNickDto.boardNo,detailIndex)" style="font-size: 27px;"></i>
				    &nbsp;
				    <i class="fa-regular fa-message mb-1" style="font-size: 25px;"></i>
				    <span class="ms-auto" style="margin-right:10px;">
				      <i class="fa-regular fa-bookmark" @click="bookmarkInsert(boardList[detailIndex].boardWithNickDto.boardNo)"
				         v-show="bookmarkChecked(boardList[detailIndex].boardWithNickDto.boardNo)" style="font-size: 25px;"></i>
				      <i class="fa-solid fa-bookmark" @click="bookmarkInsert(boardList[detailIndex].boardWithNickDto.boardNo)"
				         v-show="!bookmarkChecked(boardList[detailIndex].boardWithNickDto.boardNo)" style="font-size: 25px;"></i>
				    </span>
				  </div>
				</span>
					
					
					<p class="card-text" style="margin: 0 0 4px 0; cursor: pointer;" @click="showLikeListModal(boardList[detailIndex].boardWithNickDto.boardNo)"><b style="margin-left: 0.5em;">좋아요 {{boardLikeCount[detailIndex]}}개</b></p>
					<p class="card-text" style="margin: 0 0 0 0.5em">{{dateCount(boardList[detailIndex].boardWithNickDto.boardTimeAuto)}}</p>
					
				</div>
				
				<div class="input-group">
					<input ref="replyInput" type="text" class="form-control" :placeholder="placeholder" v-model="replyContent" style="border: none;" aria-label="Recipient's username" aria-describedby="button-addon2" @input="replyContent = $event.target.value" @keyup.enter="replyInsert(detailIndex)">
					<button class="btn" type="button" id="button-addon2" style="border-top-right-radius: 0!important;" @click="replyInsert(detailIndex)">작성</button>
				</div>
								        	
        	</div>
        </div>
	</div>
</div>
 
 
 
 
 
 

    
    
    
<!-- ---------------------------------추가 메뉴 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="additionalMenuModal" data-bs-backdrop="static" ref="additionalMenuModal" style="z-index:9999">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
				<div class="modal-body p-0">
					<div class="row p-3" @click="showReportMenuModal">
						<div class="col d-flex justify-content-center align-items-center" style="color:#dc3545; cursor:pointer">
							<h5 style="font-weight:bold; margin:0;">신고</h5>
						</div>
					</div>
					
					<hr class="m-0" v-if="reportBoardData[1] == loginMemberNo">
					<div class="row p-3" v-if="reportBoardData[1] == loginMemberNo" @click="updatePost(reportBoardData[0])">
						<div class="col d-flex justify-content-center align-items-center" style="cursor:pointer">
							<h5 style="margin:0;">수정</h5>
						</div>
					</div>
					
					<hr class="m-0" v-if="reportBoardData[1] == loginMemberNo" >
					<div class="row p-3" v-if="reportBoardData[1] == loginMemberNo" @click="deletePost(reportBoardData[0])">
						<div class="col d-flex justify-content-center align-items-center" style="cursor:pointer">
							<h5 style="margin:0;">삭제</h5>
						</div>
					</div>
					
					<!-- 메뉴 구분선 -->
					<hr class="m-0">
					<div class="row p-3" @click="hideAdditionalMenuModal">
						<div class="col d-flex justify-content-center align-items-center" style="cursor:pointer">
							<h5 style="margin:0;">취소</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- ---------------------------------신고 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="reportMenuModal" data-bs-backdrop="static" ref="reportMenuModal" style="z-index:9999">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content" >
				<div class="modal-header">
					<h5 class="modal-title" style="font-weight:bold; text-align:center">신고</h5>
					<button type="button" class="btn-close" @click="hideReportMenuModal" aria-label="Close">
					<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col d-flex p-3">
							<h5 style="margin:0;">이 게시물을 신고하는 이유</h5>
						</div>
					</div>
					<div class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo" style="border-top:var(--bs-modal-border-width) solid var(--bs-modal-border-color)">
						<div class="col d-flex p-3 report-content" @click="reportContent(report.reportListContent)" style="cursor:pointer">
							<h5 style="margin:0; margin-left:1em">{{report.reportListContent}}</h5>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" @click="hideReportMenuModal">취소</button>
				</div>
			</div>
		</div>
	</div>
<!-- ---------------------------------신고 후 차단 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="blockModal" data-bs-backdrop="static" ref="blockModal" style="z-index:9999">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
				<div class="modal-body">
					<div class="row mt-2 mb-2">
						<div class="col d-flex justify-content-center align-items-center">
							<i class="fa-regular fa-circle-check" style="color:#198754; font-size:10em"></i>
						</div>
					</div>
					<div class="row">
						<div class="col d-flex justify-content-center align-items-center">
							<h5 class="modal-title" style="font-weight:bold; text-align:center">알려주셔서 고맙습니다</h5>
						</div>
					</div>
					<div class="row">
						<div class="col d-flex justify-content-center align-items-center">
							<span>회원님의 소중한 의견은 Insider 커뮤니티를</span>
						</div>
					</div>
					<div class="row">
						<div class="col d-flex justify-content-center align-items-center">
							<span> 안전하게 유지하는 데 도움이 됩니다.</span>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col d-flex p-3 justify-content-center" @click="blockUser" style="color:#dc3545; cursor:pointer" v-if="reportBoardData[3]!=null && reportBoardData[3].length>0">
							<h5 style="margin:0;">{{reportBoardData[3]}}님 차단</h5>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" @click="hideBlockModal">닫기</button>
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

</div>
  소셜유저 : ${sessionScope.socialUser}		
  회원번호 : ${sessionScope.memberNo}		
  멤버토큰 : ${sessionScope.member}		
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script>
Vue.createApp({
    //데이터 설정 영역
    data(){
        return {
            //▼▼▼▼▼▼▼▼▼▼▼▼▼무한 페이징▼▼▼▼▼▼▼▼▼▼▼▼▼
            percent:0,
            //목록을 위한 데이터
            page:1,
            boardList:[],
            finish:false,
            
            newListFinish:false, //최근 3일 로드 끝
            oldListStart:false, // 3일 이후 로드 시작
            
            //안전장치
            loading:false,
            //▲▲▲▲▲▲▲▲▲▲▲▲▲무한 페이징▲▲▲▲▲▲▲▲▲▲▲▲▲
            
			loginMemberNo:"${sessionScope.memberNo}", // 로그인한 세션 값
			followCheckList:[], // 팔로우 체크 변수
			
			//게시물 좋아요 기능 전용 변수
			boardLikeCount:[], // 좋아요 수를 저장할 변수
            isLiked : [], // 로그인 회원이 좋아요 체크 여부
            likeList : [],
            likeListData : [],
            likeListModal : false,
            
			//게시물 댓글 좋아요 기능 전용 변수
			replyLikeCount : [], // 댓글 좋아요 수 저장 변수
			isReplyLiked : [], // 로그인 회원이 댓글 좋아요 체크 여부 
			
			/*----------------------신고----------------------*/
			//추가 메뉴 모달 및 신고 모달
			additionalMenuModal:null,
			reportMenuModal:null,
			blockModal:null,
			//신고 메뉴 리스트
			reportContentList:[],
			reportBoardData:[],
			/*----------------------신고----------------------*/
			
			//게시물 내용 더보기
			showMore:false,
			
			
			//상세보기 및 댓글
			detailView:false,
			detailIndex:"",
			replyList:[],
			replyParent:0,
			replyContent:"",
			placeholder:"댓글 입력..",
// 			boardModal:null,

			//북마크
			bookmarkCheck : [],
        };
    },
    //데이터 실시간 계산 영역
    computed:{
    	profileUrl(index){
    		 return index => {
    		      const board = this.boardList[index];
    		      if (board && board.boardWithNickDto && board.boardWithNickDto.attachmentNo > 0) {
    		        return contextPath + "/rest/attachment/download/" + board.boardWithNickDto.attachmentNo;
    		      }
    		      else {
    		        return "https://via.placeholder.com/100x100?text=profile";
    		      }
    		    };
    		  },
    	
    },
    //메소드
    methods:{
    	//전체 리스트 불러오기
        async loadNewList(){
            if(this.loading == true) return; //로딩중이면
            if(this.finish == true) return; //다 불러왔으면
            this.loading = true;
            const resp = await axios.get("${pageContext.request.contextPath}/rest/board/new/"+ this.page);
            //console.log(resp.data);
            //console.log(resp.data[0].boardLike);
            
            for (const board of resp.data) {
            	this.isLiked.push(await this.likeChecked(board.boardWithNickDto.boardNo));
            	//console.log(this.isLiked);
            	this.boardLikeCount.push(board.boardWithNickDto.boardLike);
            	//this.followCheck(board.boardWithNickDto.memberNo);
            	//console.log(this.boardLikeCount);
            	//this.boardLikeCount.push(board.boardLike);
            	//this.boardLikeCount = boardList.boardLike;
              }
            //this.boardListCount=[...resp.data.boardLike]
			
            //this.boardLikeCount.push(...resp.data.boardLike);
            this.boardList.push(...resp.data);
            this.page++;
            
            if(resp.data < 2) { //데이터가 2개 미만이면 더 읽을게 없다
            	this.finish = true; 
            	this.newListFinish = true;
        		this.page = 1;
            }

            this.loading = false;
        },
        
        async loadOldList(){
        	this.finish = false;
        	this.oldListStart = true;
            if(this.loading == true) return; //로딩중이면
            if(this.finish == true) return; //다 불러왔으면
            this.loading = true;
            const resp = await axios.get("${pageContext.request.contextPath}/rest/board/old/"+ this.page);
           
            
            for (const board of resp.data) {
            	this.isLiked.push(await this.likeChecked(board.boardWithNickDto.boardNo));
            	this.boardLikeCount.push(board.boardWithNickDto.boardLike);
              }

            this.boardList.push(...resp.data);
            this.page++;
            
            if(resp.data < 2) this.finish = true; //데이터가 2개 미만이면 더 읽을게 없다

            this.loading = false;
        },
        
        //게시물 수정
        updatePost(boardNo){
        	window.location.href = "${pageContext.request.contextPath}/board/edit?boardNo="+ boardNo;
        },
        
        //게시물 삭제
        deletePost(boardNo){
        	//window.location.href = "${pageContext.request.contextPath}/search";
        	const confirmed = confirm("게시물을 삭제하시겠습니까?");
        	if(confirmed){
        		window.location.href = "${pageContext.request.contextPath}/board/delete?boardNo=" + boardNo;
        	}
        	else{
        		return;
        	}
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
        
        //좋아요 리스트
        async likeListLoad(boardNo) {
        	//console.log(boardNo);
        	const resp = await axios.get("${pageContext.request.contextPath}/rest/board/like/list/" + boardNo);
        	//console.log(resp);
        	this.likeList = [...resp.data];
        	//console.log(this.likeList);
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
        
        //팔로우
        async follow(followNo) {
        	//const loginNo = sessionStorage.getItem('memberNo');
        	//console.log(followNo);
        	const resp = await axios.post("${pageContext.request.contextPath}/rest/follow/"+followNo);
        	//if(loginNo == this.boardList.boardWithNickDto.memberNo)
        	await this.followCheck();
        	//await this.loadList();
        	//this.followCheckIf(index) = false;
        	//console.log(this.followCheckIf(index));
        	//return resp.data;
        },
        
        /* //팔로우 여부 체크
        async followCheck(followNo) {
        	const resp = await axios.get("${pageContext.request.contextPath}/rest/follow/check/"+followNo);
        	this.followCheckList.push(resp.data);
        }, */
        
        // 팔로우 v-if 여부체크 함수
       	followCheckIfNew(index){
        	const board = this.boardList[index];
       		return !this.followCheckList.includes(board.boardWithNickDto.memberNo);
        },
        	
        
     	 //팔로우 여부 체크
        async followCheck() {
        	const resp = await axios.post("${pageContext.request.contextPath}/rest/follow/check");
        	//const newData = {followFollower : this.loginMemberNo};
        	const newData = memberNo;
        	//const newData=0;
        	//console.log(newData);
        	//console.log(newData);
        	//console.log(this.loginMemberNo)
        	this.followCheckList.push(...resp.data);
        	this.followCheckList.push(parseInt(newData));
        	
        	//console.log(this.followCheckList)
        	//console.log(this.boardList);
        	//console.log(this.boardList[0]);
        },
       
        //댓글 조회
        async replyLoad(index) {
        	this.replyList = [];
        	this.isReplyLiked = [];
        	this.replyLikeCount = [];
        	const resp = await axios.get("${pageContext.request.contextPath}/rest/reply/"+ this.boardList[index].boardWithNickDto.boardNo);
            
        	for (const reply of resp.data) {
            	this.isReplyLiked.push(await this.likeReplyChecked(reply.replyNo));
            	this.replyLikeCount.push(reply.replyLike);
              }
        	
        	this.replyList=[...resp.data];
        },
        
        //댓글 등록
        async replyInsert(index) {
        	  const boardNo = this.boardList[index].boardWithNickDto.boardNo;
        	  
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
        
//         //게시물 길이 확인
// 		boardTextCheck(index) {
//         	if(this.boardList[index].boardWithNickDto.boardContent.length > 30){
//         		return this.showMore = true;
//         	}
//         },        
        
//         //게시물 내용 더보기
//         toggleShowMore(index) {
//        	 this.showMore = !this.showMore;
//        	    if (this.showMore) {
//        	      this.showMoreText = "접기";
//        	    } else {
//        	      this.showMoreText = "더 보기";
//        	    }
       	  
//         },
        
        
        /*----------------------신고----------------------*/
        //신고 모달 show, hide
		showAdditionalMenuModal(boardNo, reportMemberNo, reportTable){
			if(this.additionalMenuModal==null) return;
			this.additionalMenuModal.show();
			this.reportBoardData=[boardNo, reportMemberNo, reportTable];
		},
		hideAdditionalMenuModal(){
			if(this.additionalMenuModal==null) return;
			this.additionalMenuModal.hide();
		},
		showReportMenuModal(){
			if(this.reportMenuModal==null) return;
			this.reportMenuModal.show();
			this.additionalMenuModal.hide();
			this.loadReportContent();
		},
		hideReportMenuModal(){
			if(this.reportMenuModal==null) return;
			this.reportMenuModal.hide();
		},
		showBlockModal(){
			if(this.blockModal==null) return;
			this.blockModal.show();
			this.reportMenuModal.hide();
		},
		hideBlockModal(){
			if(this.blockModal==null) return;
			this.blockModal.hide();
		},
		//신고 목록 불러오기
		async loadReportContent(){
			const resp = await axios.get(contextPath+"/rest/reportContent/");
			this.reportContentList = [...resp.data];
		},
		//신고
		async reportContent(reportContent){
			const data={
				reportContent:reportContent,
				reportTableNo:this.reportBoardData[0],
				reportTable:this.reportBoardData[2],
				reportMemberNo:this.reportBoardData[1],
			}
			const resp = await axios.post(contextPath+"/rest/report/", data)
			this.hideReportMenuModal();
			if(resp.data.length!=0){
				this.reportBoardData[3] = resp.data.memberNick;
			}
			this.showBlockModal();
		},
		//차단
		async blockUser(){
			const resp = await axios.put(contextPath+"/rest/block/"+this.reportBoardData[1]);
			if(resp.data){
				this.hideBlockModal();
			}
		},
		/*----------------------신고----------------------*/
		/*----------------------태그, 닉네임 클릭 시 검색기록 넣고 이동----------------------*/
		async moveToTagPage(tagName){
			const data={searchTagName:tagName, searchDelete:1};
			const resp = await axios.post(contextPath+"/rest/search/", data);
			window.location.href=contextPath+"/tag/"+tagName;
		},
		async moveToMemberPage(searchMemberNo, memberNick){
			const data={searchMemberNo:searchMemberNo, searchDelete:1};
			const resp = await axios.post(contextPath+"/rest/search/", data);
			window.location.href=contextPath+"/member/"+memberNick;
		},
		/*----------------------태그, 닉네임 클릭 시 검색기록 넣고 이동----------------------*/
		
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
		
		  console.log("북마크: " + this.bookmarkCheck.map(item => item.boardNo));
		},
		
		bookmarkChecked(boardNo){
			  return !this.bookmarkCheck.some(item => item.boardNo === boardNo);
			},
		
		async bookmarkList(){
			const resp = await axios.get("/rest/bookmark/selectOne");
			this.bookmarkCheck.push(...resp.data);
			console.log("북마크 리스트 : "+this.bookmarkCheck.map(item => item.boardNo));
		},
		
		/*---------북마크 종료 ----------------- */
		
    },
    watch: {
       //percent가 변하면 percent의 값을 읽어와서 80% 이상인지 판정
       percent(){
            if(this.percent >= 80 && !this.newListFinish) {
                this.loadNewList();
                console.log("로드new");
            }
            else if(this.oldListStart && this.percent >= 80){
               	this.loadOldList();            	
                console.log("로드old");
            }
       }
    },
    mounted(){
         window.addEventListener("scroll", _.throttle(()=>{
            const height = document.body.clientHeight - window.innerHeight;
            const current = window.scrollY
            const percent = (current / height) * 100
            //console.log("percent = " + Math.round(percent));

            //data의 percent를 계산된 값으로 갱신
            this.percent = Math.round(percent);
         },250));
        
         //추가메뉴, 신고 모달 선언
		this.additionalMenuModal = new bootstrap.Modal(this.$refs.additionalMenuModal);
		this.reportMenuModal = new bootstrap.Modal(this.$refs.reportMenuModal);
		this.blockModal = new bootstrap.Modal(this.$refs.blockModal);
		this.likeListModal = new bootstrap.Modal(this.$refs.likeListModal);
    },
    updated(){
    	$(".textHide").each(function(){
    		if($(this).width()>400||$(this).height()>21){
        		$(this).parent("p").next("h6").addClass("moreText");
    		}
    	});
    	$(".moreText").unbind("click");
    	$(".moreText").click(function(){
    		if($(this).prev("p").hasClass("moreContent")){
    			$(this).prev("p").removeClass("moreContent");
    			$(this).text("더 보기");
    		}else{
        		$(this).prev("p").addClass("moreContent");
    			$(this).text("접기");
    		}
    		
    	});
    },
    created(){
    	this.followCheck();
    	this.loadNewList();
    	this.bookmarkList();
    },
}).mount("#app");
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>