<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	//const memberNo = "${sessionScope.memberNo}";
</script>
<style>
	P {
            display: flex;
            margin: 5px auto auto auto;
            max-width: 600px;
            width: 80%;
            border: 2px solid black;
            height: 1000px
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
        width: 70%;
        max-width: 600px;
        max-width: 600px;
    }

    .fix_test {
        position: fixed;
        width: 100%;
        max-width: 250px;
    }

    .carousel-inner img {
        width: 400px;
        height: 480px;
    }
    
    .like {
	color:red;
	cursor: pointer;
	}
	
	.fa-heart {
	cursor: pointer;
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
                        <div class="p-2">
                            <div class="d-flex">
                                <div class="p-1"><img class="profile" :src="profileUrl(index)"></div>
                                <div class="p-2" style="margin-top: 8px;"><h4><b style="font-size: 17px;">{{board.boardWithNickDto.memberNick}} · {{dateCount(board.boardWithNickDto.boardTimeAuto)}}</b></h4></div>
                            <!-- 메뉴 표시 아이콘으로 변경(VO로 변경 시 경로 수정 필요) -->

                                <div class="p-2 flex-grow-1 mt-3"><i class="fa-solid fa-ellipsis" style="display:flex; flex-direction: row-reverse; font-size:26px" @click="showAdditionalMenuModal(board.boardWithNickDto.boardNo)"></i></div>


                            </div>
                        </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲ID▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼사진▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div class="p-2">
                            <div :id="'carouselExampleIndicators'+index" class="carousel slide">
                                <div class="carousel-indicators">
                                  <button v-for="(attach, index2) in boardList[index].boardAttachmentList" :key="index2" type="button" :data-bs-target="'#carouselExampleIndicators'+index" :data-bs-slide-to="index2" :class="{'active':index2==0}" :aria-current="index2==0?true:false" :aria-label="'Slide '+(index2+1)"></button>
<!--                                   <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button> -->
<!--                                   <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button> -->
                                </div>
                                <div class="carousel-inner">
                                  <div  v-for="(attach, index2) in boardList[index].boardAttachmentList" :key="index2" class="carousel-item" :class="{'active':index2==0}">
<!--                                     <img src="/static/image/r.jpeg" class="d-block" @dblclick="likePost(board.boardNo,index)" alt="..."> -->
                                   	<img :src="'${pageContext.request.contextPath}/rest/attachment/download/'+attach.attachmentNo" class="d-block" @dblclick="likePost(board.boardWithNickDto.boardNo,index)"> 
                                  </div>
<!--                                   <div class="carousel-item"> -->
<!--                                     <img src="/static/image/h.jpg" class="d-block" alt="..."> -->
<!--                                   </div> -->
<!--                                   <div class="carousel-item"> -->
<!--                                     <img src="/static/image/m.jpg" class="d-block" alt="..."> -->
<!--                                   </div> -->
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
                            <h4><b>{{board.boardWithNickDto.memberNick}}</b></h4><h6>{{board.boardWithNickDto.boardContent}}</h6>
                        </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲멘트▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼댓글 모달창 열기▼▼▼▼▼▼▼▼▼▼▼▼▼-->
             			<div class="p-1">
             				<h6 @click="showBoardModal(board.boardNo)">댓글 더보기</h6>             
             			</div>           
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲댓글 모달창 열기▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                        <!--▼▼▼▼▼▼▼▼▼▼▼▼▼댓글입력창▼▼▼▼▼▼▼▼▼▼▼▼▼-->
                        <div class="p-1">
                            <div class="d-flex">
<!--                                 <div class="p-2"><img src="/static/image/emoticon.png"></div> -->
                                <div class="p-1"><input class="form-control" type="text" placeholder="댓글 달기..."
                                                        style="border: 2px solid white; width: 18em;"></div>
                                <div class="p-2 flex-grow-1"><h5 style="color: dodgerblue" href="#">게시</h5></div>
                            </div>
                        </div>
                        <!--▲▲▲▲▲▲▲▲▲▲▲▲▲댓글입력창▲▲▲▲▲▲▲▲▲▲▲▲▲-->
                    </div>
                </div>
            </div>
         </div>
     </div>
    
    
    </div>
    
<!-- ---------------------------------댓글 모달-------------------------- -->
 <div class="modal" tabindex="-1" role="dialog" id="modal03" 
                            data-bs-backdrop="static" ref="modal03">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">제목</h5>
                    </div>
                    <div class="modal-body">
                        <!-- 모달에서 표시할 실질적인 내용 구성 -->
                        <p>본문 내용</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="hideBoardModal">닫기</button>
                    </div>
                </div>
            </div>
         </div>   

    
    
<!-- ---------------------------------추가 메뉴 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="additionalMenuModal" data-bs-backdrop="static" ref="additionalMenuModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col" @click="showReportMenuModal">
							<h1>신고</h1>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="row" @click="hideAdditionalMenuModal">
						<div class="col">
							<h1>취소</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- ---------------------------------신고 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="reportMenuModal" data-bs-backdrop="static" ref="reportMenuModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">신고</h5>
					<button type="button" class="btn-close" @click="hideReportMenuModal" aria-label="Close">
					<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col">
							<h5>이 게시물을 신고하는 이유</h5>
						</div>
					</div>
					<div class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo">
						<div class="col" @click="reportContent(report.reportListContent)">
							<span>{{report.reportListContent}}</span>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" @click="hideReportMenuModal">취소</button>
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
            
			boardLikeCount:[], // 좋아요 수를 저장할 변수
            isLiked : [],
			/*----------------------신고----------------------*/
			//추가 메뉴 모달 및 신고 모달
			additionalMenuModal:null,
			reportMenuModal:null,
			//신고 메뉴 리스트
			reportContentList:[],
			reportBoardData:[],
			/*----------------------신고----------------------*/
			
			boardModal:null,
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

            const resp = await axios.get("${pageContext.request.contextPath}/rest/board/list/"+ this.page);
            //console.log(resp.data);
            //console.log(resp.data[0].boardLike);
            
            for (const board of resp.data) {
            	this.isLiked.push(await this.likeChecked(board.boardWithNickDto.boardNo));
            	//console.log(this.isLiked);
            	this.boardLikeCount.push(board.boardWithNickDto.boardLike);
            	//console.log(this.boardLikeCount);
            	//this.boardLikeCount.push(board.boardLike);
            	//this.boardLikeCount = boardList.boardLike;
              }
            //this.boardListCount=[...resp.data.boardLike]
			
            //this.boardLikeCount.push(...resp.data.boardLike);
            this.boardList.push(...resp.data);
            this.page++;
            
            if(resp.data < 2) this.finish = true; //데이터가 10개 미만이면 더 읽을게 없다

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
        	const duration = Math.floor((curTime - postTime) / (1000 * 60));
        	
        	
        	if(duration < 60){
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
        
       
        
        showBoardModal(boardNo) {
        	if(this.boardModal==null) return;
        	this.boardModal.show();
        },
        hideBoardModal() {
        	if(this.boardModal==null) return;
        	this.boardModal.hide();
        },
        
        /*----------------------신고----------------------*/
        //신고 모달 show, hide
		showAdditionalMenuModal(boardNo, memberNo){
			if(this.additionalMenuModal==null) return;
			this.additionalMenuModal.show();
			this.reportBoardData=[boardNo, memberNo];
		},
		hideAdditionalMenuModal(){
			if(this.additionalMenuModal==null) return;
			this.additionalMenuModal.hide();
		},
		showReportMenuModal(){
			if(this.additionalMenuModal==null) return;
			this.reportMenuModal.show();
			this.additionalMenuModal.hide();
			this.loadReportContent();
		},
		hideReportMenuModal(){
			if(this.additionalMenuModal==null) return;
			this.reportMenuModal.hide();
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
		}
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
		this.boardModal = new bootstrap.Modal(this.$refs.modal03);
    },
    created(){
        this.loadList();
        //this.likeChecked(boardNo);
    },
}).mount("#app");
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>