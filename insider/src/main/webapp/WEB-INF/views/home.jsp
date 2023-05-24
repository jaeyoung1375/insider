<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	//const memberNo = "${sessionScope.memberNo}";
</script>
<style>
	p .card-text {
  		margin: 0 0 4px;
	}

    b {
        font-size: 15px;
    }

    h4{
        margin: 0px 0px 4px 0px;
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

</style>
<div id="app">
	<div class="container" style="margin-top: 20px; max-width: 1000px">
        <div class="row" v-for="(board, index) in boardList" :key="board.boardNo">
            <!--●●●●●●●●●●●●●●피드공간●●●●●●●●●●●●●●●●●●●●●●-->
            <div class="col" style="max-width: 620px; margin: 0 auto;">
                <!--피드001-->
                <div class="head_feed bg-white" style="border: 0.5px solid #b4b4b4; border-radius: 10px;">
                    <div class="d-flex flex-column">
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼ID▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div style="padding: 8px 8px 4px 8px;">
                            <div class="d-flex">
                                <div class="p-2"><a style="padding: 0 0 0 0" :href="'${pageContext.request.contextPath}/member/'+board.boardWithNickDto.memberNick"><img class="profile" :src="profileUrl(index)"></a></div>
                                <div class="p-2" style="margin-top: 8px;"><h4><a class="btn btn-none" style="padding: 0 0 0 0" :href="'${pageContext.request.contextPath}/member/'+board.boardWithNickDto.memberNick"><b>{{board.boardWithNickDto.memberNick}}</b></a><b>  · {{dateCount(board.boardWithNickDto.boardTimeAuto)}}</b></h4></div>
                                <div v-if="followCheckIf(index)" @click="follow(board.boardWithNickDto.memberNo)" class="p-2 me-5" style="margin-top: 8px;"><h4><b style="font-size: 15px; color:blue; cursor: pointer;">팔로우</b></h4></div>
                                 <div v-else class="p-2 me-5" style="margin-top: 8px;"><h4><b></b></h4></div> 
                            <!-- 메뉴 표시 아이콘으로 변경(VO로 변경 시 경로 수정 필요) -->

                                <div class=" p-2 flex-grow-1 me-2" style="margin-top: 14px;"><i class="fa-solid fa-ellipsis" style="display:flex; flex-direction: row-reverse; font-size:26px" @click="showAdditionalMenuModal(board.boardWithNickDto.boardNo)"></i></div>
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
                            <div class="d-flex" href="index.html">
                                <div class="p-2"><i :class="{'fa-heart': true, 'like':isLiked[index], 'fa-solid': isLiked[index], 'fa-regular': !isLiked[index]}" @click="likePost(board.boardWithNickDto.boardNo,index)" style="font-size: 32px;"></i></div>
                                <div class="p-2"><img src="/static/image/dm.png"></div>
                                <div class="p-2"><img src="/static/image/message_ico.png"></div>
                                <div class="p-2 flex-grow-1"><h5><img src="/static/image/save_post.png"></h5></div>
                            </div>
                        </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲좋아요▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼멘트▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div class="p-1">
                            <h4 class="mt-2"><b>좋아요 {{boardLikeCount[index]}}개</b></h4>
                            <h4><a class="btn btn-none" style="padding: 0 0 0 0" :href="'${pageContext.request.contextPath}/member/'+board.boardWithNickDto.memberNick"><b>{{board.boardWithNickDto.memberNick}}</b></a></h4>
                            <p style="height: 20px;overflow: hidden;width: 200px;white-space: nowrap;text-overflow: ellipsis;margin-bottom:5px;">
                            	<span class="textHide">{{board.boardWithNickDto.boardContent}}
                            	<br v-if="boardList[index].boardTagList.length > 0"><br v-if="boardList[index].boardTagList.length > 0">
                            	<a href="#" v-for="(tag, index3) in boardList[index].boardTagList" :key="index3">\#{{tag.tagName}}</a>
                            	</span>
                            </p>                            
                            
                            <h6 style="cursor: pointer; color:gray;">더 보기</h6>
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
    
    
    </div>
    
<!-- ---------------------------------게시물 상세보기 모달-------------------------- -->

<div v-if="detailView" class="container-fluid fullscreen">
	<div class="row fullscreen-container">
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
				
				<div class="card-body card-scroll"  style="height:490px; padding-top: 0px; padding-left:0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<p class="card-text" style="margin-left: 0.5em;">{{boardList[detailIndex].boardWithNickDto.boardContent}}
					<br v-if="boardList[detailIndex].boardTagList.length > 0"><br v-if="boardList[detailIndex].boardTagList.length > 0">
                            	<a href="#" v-for="(tag, index3) in boardList[detailIndex].boardTagList" :key="index3">\#{{tag.tagName}}</a>
					</p>
					
					<div v-if="replyList.length > 0" v-for="(reply,index) in replyList" :key="index" class="card-text" style="position: relative;">
						<a :href="'${pageContext.request.contextPath}/member/'+ replyList[index].memberNick" style="color:black;text-decoration:none; position:relative;">
							<img v-if="replyList[index].attachmentNo > 0" :src="'${pageContext.request.contextPath}/rest/attachment/download/'+ replyList[index].attachmentNo" width="35" height="35" style="border-radius: 70%;position:absolute; margin-top:4px; margin-left: 4px">
							<img v-else src="https://via.placeholder.com/30x30?text=profile" style="border-radius: 70%;position:absolute;top:10%;">
							
							<p style="padding-left: 2.9em; margin-bottom: 1px; font-size: 0.9em; font-weight: bold;" >{{replyList[index].memberNick}}</p>							
						</a>
						<p style="padding-left:2.9em;margin-bottom:4px;font-size:0.9em;">{{replyList[index].replyContent}}</p>
					</div>
					
					<div v-else class="card-text" style="position: relative;">
						<p>첫 댓글을 작성해보세요</p>
					</div>
					
					
				</div>
				<hr style="margin-top: 0; margin-bottom: 0;">
				
				<div class="card-body"  style="height:110px; padding-top: 0px; padding-left: 0; padding-right: 0; padding-bottom: 0px!important; position: relative;">
					<h5 class="card-title"></h5>
					<p class="card-text" style="margin: 0 0 4px 0">
						<i :class="{'fa-heart': true, 'like':isLiked[detailIndex],'ms-2':true, 'fa-solid': isLiked[detailIndex], 'fa-regular': !isLiked[detailIndex]}" @click="likePost(boardList[detailIndex].boardWithNickDto.boardNo,detailIndex)" style="font-size: 27px;"></i>
						&nbsp;
						<i class="fa-regular fa-message mb-1" style="font-size: 25px; "></i>
					</p>
					<p class="card-text" style="margin: 0 0 4px 0"><b style="margin-left: 0.5em;">좋아요 {{boardLikeCount[detailIndex]}}개</b></p>
					<p class="card-text" style="margin: 0 0 0 0.5em">{{dateCount(boardList[detailIndex].boardWithNickDto.boardTimeAuto)}}</p>
					
				</div>
				
				<div class="input-group">
					<input type="text" class="form-control" placeholder="댓글 달기.." v-model="replyContent" style="border: none;" aria-label="Recipient's username" aria-describedby="button-addon2" @input="replyContent = $event.target.value" @keyup.enter="replyInsert(detailIndex)">
					<button class="btn" type="button" id="button-addon2" style="border-top-right-radius: 0!important;" @click="replyInsert(detailIndex)">작성</button>
				</div>
								        	
        	</div>
			<button @click="closeDetail()">닫기</button>
        </div>
	</div>
</div>
 
 
 
 
 
 

    
    
    
<!-- ---------------------------------추가 메뉴 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="additionalMenuModal" data-bs-backdrop="static" ref="additionalMenuModal">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
				<div class="modal-body p-0">
					<div class="row p-3" @click="showReportMenuModal">
						<div class="col d-flex justify-content-center align-items-center" style="color:#dc3545;">
							<h5 style="font-weight:bold; margin:0;">신고</h5>
						</div>
					</div>
					<!-- 메뉴 구분선 -->
					<hr class="m-0">
					<div class="row p-3" @click="hideAdditionalMenuModal">
						<div class="col d-flex justify-content-center align-items-center">
							<h5 style="margin:0;">취소</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- ---------------------------------신고 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="reportMenuModal" data-bs-backdrop="static" ref="reportMenuModal">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
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
						<div class="col d-flex p-3" @click="reportContent(report.reportListContent)">
							<h5 style="margin:0;">{{report.reportListContent}}</h5>
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
	<div class="modal" tabindex="-1" role="dialog" id="blockModal" data-bs-backdrop="static" ref="blockModal">
		<div class="modal-dialog d-flex justify-content-center align-items-center" role="document" style="height:80%">
			<div class="modal-content">
				<div class="modal-body">
					<div class="row mb-2">
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
					<div class="row">
						<div class="col d-flex p-3" @click="blockUser" style="color:#dc3545; cursor:pointer">
							<h5 style="margin:0;">{{reportBoardData[2]}}님 차단</h5>
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
            //안전장치
            loading:false,
            //▲▲▲▲▲▲▲▲▲▲▲▲▲무한 페이징▲▲▲▲▲▲▲▲▲▲▲▲▲
			loginMemberNo:"${sessionScope.memberNo}", // 로그인한 세션 값
			followCheckList:[],
			
			boardLikeCount:[], // 좋아요 수를 저장할 변수
            isLiked : [],
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
			showMoreText:"더 보기",
			
			//상세보기 및 댓글
			detailView:false,
			detailIndex:"",
			replyList:[],
			replyContent:"",
// 			boardModal:null,
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
        async loadList(){
            if(this.loading == true) return; //로딩중이면
            if(this.finish == true) return; //다 불러왔으면
            this.loading = true;

            const resp = await axios.get("${pageContext.request.contextPath}/rest/board/page/"+ this.page);
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
            
            if(resp.data < 2) this.finish = true; //데이터가 2개 미만이면 더 읽을게 없다

            this.loading = false;
        },
        
        //로그인한 회원이 좋아요 눌렀는지 확인
        async likeChecked(boardNo) {
        	const resp = await axios.post("${pageContext.request.contextPath}/rest/board/check", {boardNo:boardNo});
			
        	//console.log(resp.data);
        	return resp.data;
        },
        
        //좋아요
        async likePost(boardNo, index) {
            const resp = await axios.post("${pageContext.request.contextPath}/rest/board/like", {boardNo:boardNo});
            //console.log(resp.data.count);
            if(resp.data.result){
            	this.isLiked[index] = true;
            }
            else {
            	this.isLiked[index] = false;
            }
            
            
            this.boardLikeCount[index] = resp.data.count;
           // console.log(this.boardLikeCount);
        },
        
        //게시글 날짜 계산 함수
        dateCount(date) {
        	const curTime = new Date();
        	const postTime = new Date(date);
        	console.log(postTime);
        	const duration = Math.floor((curTime - postTime) / (1000 * 60));
        	console.log(duration);
        	
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
       	followCheckIf(index){
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
        	//const check = this.followCheckList.some(followFollower => followFollower === this.boardList[0].boardWithNickDto.memberNo)
        	//console.log(check);
        },
       
        //댓글 조회
        async replyLoad(index) {
        	const resp = await axios.get("${pageContext.request.contextPath}/rest/reply/"+ this.boardList[index].boardWithNickDto.boardNo);
        	console.log(resp);
        	console.log(resp.data);
        	this.replyList.push(...resp.data);
			console.log(this.replyList);
        		
        		//         	if(resp.data>0){
//         	}
        },
        
        //댓글 등록
        async replyInsert(index) {
        	  const boardNo = this.boardList[index].boardWithNickDto.boardNo;
        	  
        	  const requestData = {
        	    replyOrigin: boardNo,
        	    replyContent: this.replyContent
        	  };
        	  this.replyList = [];
        	  this.replyContent='';
				
        	  try {
        	    const response = await axios.post(`${pageContext.request.contextPath}/rest/reply/`, requestData);
        	    this.replyLoad(index);
        	  } 
        	  catch (error) {
        	    console.error(error);
        	  }
        },
        
        //댓글 삭제
        async replyDelete(index) {
        	const resp = await axios.delete("${pageContext.request.contextPath}/rest/reply/"+ this.replyList.replyNo)
        	this.replyLoad(index);
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
		showAdditionalMenuModal(boardNo, reportMemberNo){
			if(this.additionalMenuModal==null) return;
			this.additionalMenuModal.show();
			this.reportBoardData=[boardNo, reportMemberNo];
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
				reportTable:"board",
				reportMemberNo:this.reportBoardData[1],
			}
			const resp = await axios.post(contextPath+"/rest/report/", data)
			this.hideReportMenuModal();
			if(resp.data.length!=0){
				this.reportBoardData[2] = resp.data.memberNick;
				this.showBlockModal();
			}
		},
		//차단
		async blockUser(){
			const resp = await axios.put(contextPath+"/rest/block/"+this.reportBoardData[1]);
			if(resp.data){
				this.hideBlockModal();
			}
		},
		/*----------------------신고----------------------*/
    },
    watch: {
       //percent가 변하면 percent의 값을 읽어와서 80% 이상인지 판정
       percent(){
            if(this.percent >= 80) {
                this.loadList();
            }
       }
    },
    mounted(){

         window.addEventListener("scroll", _.throttle(()=>{
        	//console.log("스크롤 이벤트");
            //console.log(this);
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
		//this.boardModal = new bootstrap.Modal(this.$refs.modal03);
    },
    updated(){
    	console.log($(".textHide").width());
    	console.log($(".textHide").height());
    	$(".textHide").each(function(){
    		if($(this).width()>200||$(this).height()>21){
        		$(this).parent("p").next("h6").addClass("moreText");
    		}
    	});
    	$(".moreText").unbind("click");
    	$(".moreText").click(function(){
    		//console.log("실행횟수");
    		if($(this).prev("p").hasClass("moreContent")){
    			$(this).prev("p").removeClass("moreContent");
    		}else{
        		$(this).prev("p").addClass("moreContent");
    		}
    		
    	});
    },
    created(){
    	//this.loginMemberNo =  "${sessionScope.memberNo}";        
    	this.followCheck();
    	this.loadList();
        //this.likeChecked(boardNo);
    },
}).mount("#app");
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>