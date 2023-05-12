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
			
		<!-- 리스트 -->
			<div class="row">
				
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
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
			async recommandSearch(){
				const resp = await axios.get(contextPath+"/rest/search/"+this.searchInput);
				//this.reccomandList=[...resp.data];
			},
		},
		created(){
			//데이터 불러오는 영역
		},
		watch:{
			//감시영역
			searchInput:_.throttle(function(){
				this.recommandSearch();
			}, 1000)
		}
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>