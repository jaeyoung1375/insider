<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.has-search .form-control {
	padding-left: 2.375rem;
}

.has-search .form-control-feedback {
	position: absolute;
	z-index: 2;
	display: block;
	width: 2.375rem;
	height: 2.375rem;
	line-height: 2.375rem;
	text-align: center;
	pointer-events: none;
	color: #aaa;
}
.search-list{
	position:absolute;
	padding-left: 3.3rem;
	z-index:100;
	width:500px;
	background-color:white;
}
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
.content {
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
.box:hover{
	background-color:rgba(34, 34, 34, 0.13);
}
.box:hover .like-comment{
	display:block;
}
/* 드롭다운 메뉴 */

</style>
<div class="container-fluid mt-4" id="app">
	<div class="row">
		<div class="offset-md-2 col-md-8">
		<!-- 검색창 -->
			<div class="text-center">
				<div class="row">
					<div class="col form-group has-search">
						<span class="fa-solid fa-search form-control-feedback"></span>
						<input type="text" class="form-control rounded" placeholder="검색" v-model="searchInput" @blur="hideSearchList" @click="showSearchList" >
					</div>
				</div>
			<!-- 추천 검색어 리스트 -->
				<ul class="dropdown-menu" :style="{ width: dropdownWidth }" aria-labelledby="dropdownMenu2" :class="{'show':recommandListShow}">
					<li v-for="(recommand, index) in recommandList" :key="index">
						<div class="dropdown-item">
							<div class="row" v-if="recommand.nick==null" @click="moveToTagDetail">
								<div class="col p-2 ms-2">
									# {{recommand.name}}
								</div>
							</div>
							<div class="row" v-else  @click="moveToMemberDetail">
								<div class="col-3">
									<img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+recommand.imageURL">
								</div>
								<div class="col-9">
									<div class="ms-2">{{recommand.nick}}</div>
									<div class="ms-2">{{recommand.name}}</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			
		<!-- 리스트 -->
			<div class="row">
				<div class="box m-2" v-for="(board, index) in boardList" :key="board.boardWithNickDto.boardNo" @dblclick="doubleClick(board.boardWithNickDto.boardNo, index)">
					<img class='content' v-if="board.boardAttachmentList.length>0" :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" >
					<img class='content' v-else src="${pageContext.request.contextPath}/static/image/noimage.png">
					<i class="fa-regular fa-copy pages" v-if="board.boardAttachmentList.length>1"></i>
					<div class="like-comment">
						<span><i class="fa-solid fa-heart"></i> {{board.boardWithNickDto.boardLike}}</span> 
						<span class="ms-3"><i class="fa-solid fa-comment"></i> {{board.boardWithNickDto.boardReply}}</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	Vue.createApp({
		data() {
			return {
				searchInput:"",
				recommandList:[],
				recommandListShow:false,
				boardList:[],
				page:1,
				percent:0,
				loading:false,
				finish:false,
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
			async recommandSearch(){
				if(!this.searchInput.length>0){
					return;
				}
				const resp = await axios.get(contextPath+"/rest/search/"+this.searchInput);
				this.recommandList=[...resp.data];
			},
			async loadList(){
				if(this.loading||this.finish) return;
				this.loading=true;
				const resp = await axios.get(contextPath+"/rest/board/list/"+this.page);
				this.boardList.push(...resp.data);
				this.page++;
				if(resp.data.length<10){//데이터가 10개 미만이면 불러오는걸 막음
					this.finish==true;
				}
				this.loading=false;
			},
			//더블클릭 시 좋아요
			async doubleClick(boardNo, index){
				const data = {boardNo:boardNo};
				const resp = await axios.post(contextPath+"/rest/board/like", data);
				this.boardList[index].boardWithNickDto.boardLike=resp.data.count;
			},
			hideSearchList(){
				this.recommandListShow=false;
			},
			showSearchList(){
				this.recommandListShow=true;
				this.dropdownWidth = `${inputWidth}px`;
			},
			async moveToTagDetail(){
				
			},
			async moveToMemberDetail(){
				
			},
		},
		created(){
			//데이터 불러오는 영역
			this.loadList();
		},
		watch:{
			//감시영역
			searchInput:_.throttle(function(){
				this.recommandSearch();
			}, 500),
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