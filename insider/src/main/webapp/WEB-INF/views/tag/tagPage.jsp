<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
/* 게시물 네모박스 */
.box {
	position: relative;
	width: 32.3%;
	font-size:1.2em;
}
.box::after {
	display: block;
	content: "";
	padding-bottom: 100%;
}
.content-in-list,.content-box {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
}
.pages {
	position: absolute;
	top: 0;
	right: 0;
	z-index: 1;
	margin-top:0.5em;
	margin-right:0.5em;
	color:white;
}
.like-comment{
	position: absolute;
	z-index: 10;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color:white;
	cursor:default;
	display:none;
	min-width:100px;
	text-align:center;
}
.box:hover .content-box{
	background-color:rgba(34, 34, 34, 0.13);
	z-index:5;
}
.box:hover .like-comment{
	display:block;
}

.carousel-inner img {
        width: 470px;
        height: 480px;
        object-fit: cover;
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
	
	.profile {
        width: 50px;
        height: 50px;
        object-fit: cover;
        object-position: center;
        border-radius: 50%;
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
	
	.childReply{
		padding-left: 35px;
	}
	
</style>
<div class="container-fluid mt-4" id="app" style="width:70%; max-width:1300px; min-width:900px">
	<div class="row">
		<div class="col-4 text-center">
			<img class="rounded-circle profile-image-box" :src="'${pageContext.request.contextPath}'+mainImage" width = "150" height="150">
		</div>
		<div class="col-8">
			<div class="row">
				<div class="col">
					<h1>\#{{tagName}}</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					게시물
				</div>
			</div>
			<div class="row">
				<div class="col" style="font-weight:bold">
					{{tagData.count}} 개
				</div>
			</div>
			<div class="row mt-3">
				<div class="col-10" v-if="tagData.follow==0">
					<button class="btn btn-primary w-100" @click="tagFollow">팔로우</button>
				</div>
				<div class="col-10" v-else>
					<button class="btn btn-secondary w-100" @click="tagFollow">팔로잉</button>
				</div>
			</div>
		</div>
	</div>
	<hr>
	<!-- 게시물 목록 -->
	<div class="row">
		<div class="col d-flex justify-content-center">
			<div class="row d-flex justify-content-start" style="width:90%">
				<div class="box m-1" v-for="(board, index) in boardList" :key="board.boardWithNickDto.boardNo" @dblclick="doubleClick(board.boardWithNickDto.boardNo, index)"
					@click="detailViewOn(index)">
					<video class="content-in-list" :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" v-if="board.boardAttachmentList.length>0 && board.boardAttachmentList[0].video"
							style="object-fit:cover" :autoplay="memberSetting.videoAuto" muted controls :loop="memberSetting.videoAuto"></video>
					<img class='content-in-list' v-if="board.boardAttachmentList.length>0 && !board.boardAttachmentList[0].video"
							 :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" >
					<div class="content-box"></div>
					<i class="fa-regular fa-copy pages" v-if="board.boardAttachmentList.length>1"></i>
					<div class="like-comment">
						<span v-if="(memberSetting.watchLike && board.boardWithNickDto.boardLikeValid==0)||board.boardWithNickDto.memberNo==${sessionScope.memberNo}"><i class="fa-solid fa-heart"></i> {{board.boardWithNickDto.boardLike}}</span> 
						<span v-if="board.boardWithNickDto.boardReplyValid==0" class="ms-3"><i class="fa-solid fa-comment"></i> {{board.boardWithNickDto.boardReply}}</span>
					</div>
				</div>
			</div>
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
                  <button v-if="boardList[detailIndex].boardAttachmentList.length > 1" v-for="(attach, index2) in boardList[detailIndex].boardAttachmentList" :key="index2" type="button" :data-bs-target="'#detailCarousel'+ detailIndex" :data-bs-slide-to="index2" :class="{'active':index2==0}" :aria-current="index2==0?true:false" :aria-label="'Slide '+(index2+1)"></button>
                </div>
               
                <div class="carousel-inner">
                  <div  v-for="(attach, index2) in boardList[detailIndex].boardAttachmentList" :key="index2" class="carousel-item" :class="{'active':index2==0}">
                   	<video  style="width:700px; height:700px; object-fit:cover" class="d-block" :src="'${pageContext.request.contextPath}'+attach.imageURL" v-if="attach.video"
							:autoplay="memberSetting.videoAuto" muted controls :loop="memberSetting.videoAuto" 
							@dblclick="likePost(boardList[detailIndex].boardWithNickDto.boardNo,detailIndex)" ></video>
	                <img v-else :src="'${pageContext.request.contextPath}/rest/attachment/download/'+attach.attachmentNo" class="d-block" @dblclick="likePost(board.boardWithNickDto.boardNo,detailIndex)"
	                 style="width:700px; height:700px;" @dblclick="likePost(boardList[detailIndex].boardWithNickDto.boardNo,detailIndex)"> 
                  </div>
                </div>
               
                <button v-if="boardList[detailIndex].boardAttachmentList.length > 1" class="carousel-control-prev" type="button" :data-bs-target="'#detailCarousel' + detailIndex" data-bs-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button v-if="boardList[detailIndex].boardAttachmentList.length > 1" class="carousel-control-next" type="button" :data-bs-target="'#detailCarousel' + detailIndex" data-bs-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button>
                
           </div>
		</div>
           
        <div class="col-4" style="padding-left: 0;">
        	<div class="card bg-light" style="border-radius:0; max-height: 700px">
           		<div class="card-header">
           			<div class="row">
           				<div class='col-10'>
			           		<img class="profile" :src="profileUrl(detailIndex)">
		           			<a class="btn btn-none" style="padding: 0 0 0 0; margin-left: 0.5em;" :href="'${pageContext.request.contextPath}/member/'+boardList[detailIndex].boardWithNickDto.memberNick"><b>{{boardList[detailIndex].boardWithNickDto.memberNick}}</b></a>
           				</div>
           				<div class="col d-flex justify-content-center align-items-center">
           					<i class="fa-solid fa-ellipsis modal-click-btn-neutral" style="display:flex; flex-direction: row-reverse; font-size:1.2em" @click="showAdditionalMenuModal(boardList[detailIndex].boardWithNickDto.boardNo, boardList[detailIndex].boardWithNickDto.memberNo, 'board')"></i>
           				</div>
           			</div>
           		</div>
				
				<div class="card-body card-scroll" ref="scrollContainer"  style="height:490px; padding-top: 0px; padding-left:0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<p class="card-text" style="margin-left: 0.5em;">{{boardList[detailIndex].boardWithNickDto.boardContent}}
					<br v-if="boardList[detailIndex].boardTagList.length > 0"><br v-if="boardList[detailIndex].boardTagList.length > 0">
                            	<a @click="moveToTagPage(tag.tagName)" v-for="(tag, index3) in boardList[detailIndex].boardTagList" :key="index3" style="margin-right: 0.5em; color: blue; cursor: pointer;">\#{{tag.tagName}}</a>
					</p>
					
					
					<div v-if="replyList.length > 0" v-for="(reply,index) in replyList" :key="index" class="card-text" :class="{'childReply':reply.replyParent!=0}" style="position: relative;">
						<a :href="'${pageContext.request.contextPath}/member/'+ replyList[index].memberNick" style="color:black;text-decoration:none; position:relative;">
							<img v-if="replyList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ replyList[index].attachmentNo" width="45" height="45" style="border-radius: 70%;position:absolute; margin-top:9px; margin-left: 4px">
							<img v-else src="https://via.placeholder.com/45x45?text=profile" style="border-radius: 70%;position:absolute; margin-top:9px; margin-left: 4px">
							
						<p style="padding-left: 3.5em; margin-bottom: 1px; font-size: 0.9em; margin-left: 3.5px; font-weight: bold;">{{replyList[index].memberNick}}</p>
												
						</a>
						<p style="padding-left:3.5em;margin-bottom:1px;font-size:0.9em; margin-left: 3.5px;">{{replyList[index].replyContent}}</p>
						<div class="row" style="height: 25px">
							<div class="col-10">
								<p style="padding-left:4.0em;margin-bottom:3px;font-size:0.8em; color:gray;">{{dateCount(replyList[index].replyTimeAuto)}} &nbsp; 좋아요 {{replyLikeCount[index]}}개 &nbsp;
									<a style="cursor: pointer;" v-if="reply.replyParent==0" @click="reReply(replyList[index].replyNo)">답글 달기</a>  
									<i :class="{'fa-heart': true, 'like':isReplyLiked[index],'ms-2':true, 'fa-solid': isReplyLiked[index], 'fa-regular': !isReplyLiked[index]}" @click="likeReply(reply.replyNo,index)" style="font-size: 0.9em;"></i>
									
								</p>
							</div>
						<!-- 댓글 신고창 -->
							<div class="col-2 p-0 d-flex justify-content-center">
								<p class="d-flex align-items-center"><i class="fa-solid fa-ellipsis modal-click-btn-neutral" style="display:flex; flex-direction: row-reverse;" @click="showAdditionalMenuModal(reply.replyNo, reply.replyMemberNo, 'reply',index,detailIndex)"></i></p>
							</div>
						</div>
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
				  <div class="d-flex row">
					  <div class="col-10">
						<span class="card-text" style="margin: 0 4px 4px 0; padding-left: 0.5em">
						    <i :class="{'fa-heart': true, 'like':isLiked[detailIndex], 'fa-solid': isLiked[detailIndex], 'fa-regular': !isLiked[detailIndex]}"
						       @click="likePost(boardList[detailIndex].boardWithNickDto.boardNo,detailIndex)" style="font-size: 27px;"></i>
						</span>
						<span class="card-text" style="margin: 0 0 4px 0; padding-left: 0.5em;">
					    	<i class="fa-regular fa-message mb-1" style="font-size: 25px;"></i>
						</span>
					  </div>
					  <div class="col-1 p-0 flex-grow-1">
					    <span class="ms-4">
					      <i class="fa-regular fa-bookmark" @click="bookmarkInsert(boardList[detailIndex].boardWithNickDto.boardNo)"
					         v-show="bookmarkChecked(boardList[detailIndex].boardWithNickDto.boardNo)" style="font-size: 25px;"></i>
					      <i class="fa-solid fa-bookmark" @click="bookmarkInsert(boardList[detailIndex].boardWithNickDto.boardNo)"
					         v-show="!bookmarkChecked(boardList[detailIndex].boardWithNickDto.boardNo)" style="font-size: 25px;"></i>
					    </span>
					  </div>
				  </div>
					
					
					<p class="card-text" style="margin: 0 0 4px 0; cursor: pointer;" @click="showLikeListModal(boardList[detailIndex].boardWithNickDto.boardNo)"><b style="margin-left: 0.5em;">좋아요 {{boardLikeCount[detailIndex]}}개</b></p>
					<p class="card-text" style="margin: 0 0 0 0.5em">{{dateCount(boardList[detailIndex].boardWithNickDto.boardTimeAuto)}}</p>
					
				</div>
				
				<div class="input-group">
					<input ref="replyInput" type="text" class="form-control" @click="disabledReply(detailIndex)" :placeholder="placeholder"  v-model="replyContent" style="border: none;" aria-label="Recipient's username" aria-describedby="button-addon2" @input="replyContent = $event.target.value" @keyup.enter="replyInsert(detailIndex)">
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
					<div class="row p-3">
						<div class="col d-flex justify-content-start align-items-center">
							<h5 style="margin:0; cursor:default">더보기</h5>
						</div>
					</div>
					<hr class="m-0" v-if="reportBoardData[1] != ${sessionScope.memberNo}">
					<div class="row p-3" v-if="reportBoardData[1] != ${sessionScope.memberNo}" @click="showReportMenuModal">
						<div class="col d-flex justify-content-center align-items-center" style="color:#dc3545; cursor:pointer">
							<h5 style="font-weight:bold; margin:0;">신고</h5>
						</div>
					</div>
					
					<hr class="m-0" v-if="reportBoardData[1] == ${sessionScope.memberNo} && reportBoardData[2] == 'board'">
					<div class="row p-3" v-if="reportBoardData[1] == ${sessionScope.memberNo} && reportBoardData[2] == 'board'" @click="updatePost(reportBoardData[0])">
						<div class="col d-flex justify-content-center align-items-center" style="cursor:pointer">
							<h5 style="margin:0;">수정</h5>
						</div>
					</div>
					
					<hr class="m-0" v-if="reportBoardData[1] == ${sessionScope.memberNo}" >
					<div class="row p-3" v-if="reportBoardData[1] == ${sessionScope.memberNo}" @click="deleteTool">
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
						<div class="col d-flex p-2 report-content" @click="reportContent(report.reportListContent)" style="cursor:pointer">
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
	
</div>
<script>
	Vue.createApp({
		data() {
			return {
				page:1,
				percent:0,
				tagName:"",
				boardList:[],
				tagData:{},
				mainImage:"",
				
				//클릭, 더블클릭 이벤트 해결
				delay: 700,
				clicks: 0,
				timer: null,
				
				//게시물 좋아요 기능 전용 변수
				boardLikeCount:[], // 좋아요 수를 저장할 변수
	            isLiked : [], // 로그인 회원이 좋아요 체크 여부
	            likeList : [],
	            likeListData : [],
	            likeListModal : false,
				
				//상세보기 및 댓글
				detailView:false,
				detailIndex:"",
				replyList:[],
				replyParent:0,
				replyContent:"",
				placeholder:"댓글 입력..",
				//게시물 작성자 팔로우 리스트
				followList : [],
				followerList : [],
				loginMemberNo:"${sessionScope.memberNo}", // 로그인한 세션 값

				//게시물 댓글 좋아요 기능 전용 변수
				replyLikeCount : [], // 댓글 좋아요 수 저장 변수
				isReplyLiked : [], // 로그인 회원이 댓글 좋아요 체크 여부 

				//북마크
				bookmarkCheck : [],
				
				memberSetting:{
	    	        //좋아요 수 보기 여부
		            watchLike:false,
		            
		            //동영상 자동재생
		            videoAuto:false,
	            },
	            /*----------------------신고----------------------*/
				//추가 메뉴 모달 및 신고 모달
				additionalMenuModal:null,
				reportMenuModal:null,
				blockModal:null,
				//신고 메뉴 리스트
				reportContentList:[],
				reportBoardData:[],
				/*----------------------신고----------------------*/
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
			async loadList(){
				if(this.loading||this.finish) return;
				this.loading=true;
				const resp = await axios.get(contextPath+"/rest/tag/list/"+this.tagName+"?page="+this.page);
				for(const board of resp.data) {
	            	this.isLiked.push(await this.likeChecked(board.boardWithNickDto.boardNo));
	            	this.boardLikeCount.push(board.boardWithNickDto.boardLike);
				}
				this.boardList.push(...resp.data);
				this.mainImage=this.boardList[0].boardAttachmentList[0].imageURL
				this.page++;
				if(resp.data.length<10){//데이터가 10개 미만이면 불러오는걸 막음
					this.finish==true;
				}
				this.loading=false;
			},
			getTagNameFromURL(){
				const url = window.location.href;
				const lastSlashIndex = url.lastIndexOf('/');
				const encodedTag = url.substring(lastSlashIndex + 1);
				this.tagName = decodeURIComponent(encodedTag);
				this.loadList();
			},
			async loadData(){
				const resp = await axios.get(contextPath+"/rest/tag/"+this.tagName+"?page="+this.page);
				this.tagData=resp.data;
			},
			async tagFollow(){
				const resp = await axios.post(contextPath+"/rest/tag/follow/"+this.tagName);
				this.tagData.follow=resp.data;
			},
			//더블클릭 시 좋아요
			async doubleClick(boardNo, index){
				const data = {boardNo:boardNo};
				const resp = await axios.post(contextPath+"/rest/board/like", data);
				this.boardList[index].boardWithNickDto.boardLike=resp.data.count;
			},
			
			/* --------------------------상세보기-------------------------- */
			
			//회원 환경 설정 로드
	        async loadMemberSetting(){
				const resp = await axios.get(contextPath+"/rest/member/setting");
	            this.memberSetting.watchLike=resp.data.watchLike;
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
	        
	        async replyInsert(index) {
	        	  const boardNo = this.boardList[index].boardWithNickDto.boardNo;
	        	  const memberNo = this.boardList[index].boardWithNickDto.memberNo;
	        	  const loginNo = parseInt(this.loginMemberNo);
	        	  
	        	  //세팅값 불러오기
	        	  const response = await axios.get(contextPath+"/rest/member/setting/" + memberNo);
	        	  const set = response.data.settingAllowReply;
	        	  //console.log(set);
	        	  //console.log(memberNo, loginNo);       	  
	        	  
	        	  const requestData = {
	        	    replyOrigin: boardNo,
	        	    replyContent: this.replyContent,
	        	    replyParent : this.replyParent
	        	  };
	        	  this.replyContent='';
	        	  
	        	  //모든 사람 작성 가능한 경우
	        	  if(set == 0){
	        	    const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
	        	    this.replyLoad(index);	            		  
	        	  }
	        	  //내가 팔로우 하는 사람만 작성 가능한 경우
	        	  else if(set == 1){
	        		  //게시물 작성자 팔로우 로드
	        		  await this.loadFollow(memberNo);
	              	  if(loginNo == memberNo) this.followList.push(loginNo); 
	        		  
	              	  if(this.followList.includes(loginNo)){
	        			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
	              	      this.replyLoad(index);  
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
	        		  //console.log(this.followerList);
	        		  if(this.followerList.includes(loginNo)){
	        			  const response = await axios.post("${pageContext.request.contextPath}/rest/reply/", requestData);
	              	      this.replyLoad(index);
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
	              	      this.replyLoad(index);
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
	        
	        //댓글 사용 불가 알림
	         disabledReply(index) {
	        	 if(this.boardList[index].boardWithNickDto.boardReplyValid != 0){
	        		 alert("댓글 사용이 불가능합니다.");
	        	 }
	         },
	        
	       //상세보기 모달창 열기(더블클릭 이벤트 방지)
		   detailViewOn(index) {
				this.clicks++;
				if (this.clicks === 1) {
					this.timer = setTimeout( () => {
			        	this.detailView = true;
			        	this.detailIndex = index;
			        	this.replyLoad(index);
			        	document.body.style.overflow = "hidden";
						this.clicks = 0
					}, 200);
				} 
				else {
					clearTimeout(this.timer);
					this.clicks = 0;
				} 
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
	        
			/* --------------------------상세보기-------------------------- */
			/*----------------------신고----------------------*/
			 //신고 모달 show, hide
			showAdditionalMenuModal(boardNo, reportMemberNo, reportTable, index, detailIndex){
				if(this.additionalMenuModal==null) return;
				this.additionalMenuModal.show();
				this.reportBoardData=[boardNo, reportMemberNo, reportTable, index, detailIndex];
			},
			
			deleteTool(){
				if(this.reportBoardData[2] == 'board'){
					this.deletePost(this.reportBoardData[0]);
				}
				else {
					this.replyDelete(this.reportBoardData[3],this.reportBoardData[4]);
				}
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
	      //게시물 수정
	        updatePost(boardNo){
	        	window.location.href = "${pageContext.request.contextPath}/board/edit?boardNo="+ boardNo;
	        },
			/*----------------------신고----------------------*/
		},
		computed: {
			//계산영역
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
		created(){
			//데이터 불러오는 영역
			this.getTagNameFromURL();
			this.loadData();
			this.bookmarkList();
	    	this.loadMemberSetting();
		},
		watch:{
			//감시영역
			percent(){
				if(this.percent >= 80){
				this.loadList();
				}
			}	
		},
		mounted(){
			window.addEventListener("scroll", _.throttle(()=>{
				//문서 전체 높이 - 브라우저 높이
				const height = document.body.clientHeight - window.innerHeight;
				//현재 스크롤의 위치
				const current = window.scrollY;
				const percent = (current/height)*100;
				this.percent = Math.round(percent);
			}, 250));
			this.additionalMenuModal = new bootstrap.Modal(this.$refs.additionalMenuModal);
			this.reportMenuModal = new bootstrap.Modal(this.$refs.reportMenuModal);
			this.blockModal = new bootstrap.Modal(this.$refs.blockModal);
		}
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>