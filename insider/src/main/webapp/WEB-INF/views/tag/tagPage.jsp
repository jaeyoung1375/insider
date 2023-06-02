<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.box {
	position: relative;
	width: 30.9%;
	font-size:1.2em;
}
.box::after {
	display: block;
	content: "";
	padding-bottom: 100%;
}
.content,.content-box {
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
	color:lightgray;
}
.like-comment{
	position: absolute;
	z-index: 1;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	color:white;
	cursor:default;
	display:none;
}
.box:hover .content-box{
	background-color:rgba(34, 34, 34, 0.13);
	z-index:5;
}
.box:hover .like-comment{
	display:block;
}
</style>
<div class="container-fluid mt-4" id="app">
	<div class="row">
		<div class="col-4 text-center">
			<img class="rounded-circle" :src="'${pageContext.request.contextPath}'+mainImage" width = "150" height="150">
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
	<div class="row d-flex justify-content-center">
		<div class="box m-2" v-for="(board, index) in boardList" :key="board.boardWithNickDto.boardNo" @dblclick="doubleClick(board.boardWithNickDto.boardNo, index)">
			<img class='content' v-if="board.boardAttachmentList.length>0" :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" >
			<img class='content' v-else src="${pageContext.request.contextPath}/static/image/noimage.png">
			<div class="content-box"></div>
			<i class="fa-regular fa-copy pages" v-if="board.boardAttachmentList.length>1"></i>
			<div class="like-comment">
				<span><i class="fa-solid fa-heart"></i> {{board.boardWithNickDto.boardLike}}</span> 
				<span class="ms-3"><i class="fa-solid fa-comment"></i> {{board.boardWithNickDto.boardReply}}</span>
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
		},
		created(){
			//데이터 불러오는 영역
			this.getTagNameFromURL();
			this.loadData();
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
			}, 250))
		}
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>