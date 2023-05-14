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
</style>
<div class="container-fluid mt-4" id="app">
	<div class="row">
		<div class="offset-md-2 col-md-8">
		<!-- 검색창 -->
			<div class="row text-center">
				<div class="col form-group has-search">
					<span class="fa-solid fa-search form-control-feedback"></span>
					<input type="text" class="form-control rounded" placeholder="검색" v-model="searchInput">
				</div>
			</div>
			<div class="row">
				<div class="row" v-for="(recommand, index) in recommandList" :key="index">
					{{recommand.name}}
				</div>
			</div>
			
		<!-- 리스트 -->
			<div class="row">
				<div class="col-4" v-for="(board, index) in boardList" :key="board.boardDto.boardNo">
					{{board.boardDto.boardContent}}
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
				console.log(this.recommandList)
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
			}
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