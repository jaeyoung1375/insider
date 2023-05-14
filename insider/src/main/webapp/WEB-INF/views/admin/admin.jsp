<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.selected{
	border:1px solid black
}
</style>
<div class="container-fluid mt-4" id="app">
	<div class="row">
	<!-- 좌측 사이드 메뉴바 -->
		<div class="col-md-4">
			<div class="row admin-menu" @click="changeAdminMenu(1)" :class="{'selected':adminMenu==1}">
				<div class="col">
					<h2>회원 관리</h2>
				</div>
			</div>
			<div class="row admin-menu" @click="changeAdminMenu(2)" :class="{'selected':adminMenu==2}">
				<div class="col">
					<h2>신고 관리</h2>
				</div>
			</div>
			<div class="row admin-menu" @click="changeAdminMenu(3)" :class="{'selected':adminMenu==3}">
				<div class="col">
					<h2>회원 통계</h2>
				</div>
			</div>
			<div class="row admin-menu" @click="changeAdminMenu(4)" :class="{'selected':adminMenu==4}">
				<div class="col">
					<h2>게시물 통계</h2>
				</div>
			</div>
			<div class="row admin-menu" @click="changeAdminMenu(5)" :class="{'selected':adminMenu==5}">
				<div class="col">
					<h2>조회 통계</h2>
				</div>
			</div>
		</div>
	<!--------------------------- 회원 관리 --------------------------->
		<div class="col-md-8" v-show="adminMenu==1">
			<div class="row">
				<div class="col">
					<h1>회원관리</h1>
				</div>
			</div>
		</div>
	<!--------------------------- 신고 관리 --------------------------->
		<div class="col-md-8" v-show="adminMenu==2">
			<div class="row">
				<div class="col">
					<h1>신고관리</h1>
				</div>
			</div>
		</div>
	<!--------------------------- 회원 통계 --------------------------->
		<div class="col-md-8" v-show="adminMenu==3">
			<div class="row">
				<div class="col">
					<h1>회원 통계</h1>
				</div>
			</div>
		</div>
	<!--------------------------- 게시물 통계 --------------------------->
		<div class="col-md-8" v-show="adminMenu==4">
			<div class="row">
				<div class="col">
					<h1>게시물 통계</h1>
				</div>
			</div>
		</div>
	<!--------------------------- 조회 통계 --------------------------->
		<div class="col-md-8" v-show="adminMenu==5">
			<div class="row">
				<div class="col">
					<h1>조회 통계</h1>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	Vue.createApp({
		data() {
			return {
				adminMenu:1,
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
			//쿼리값 page로 반환
			initializePageFromQuery() {
				const queryParams = new URLSearchParams(window.location.search);
				const adminMenu = queryParams.get('adminMenu');
				this.adminMenu = adminMenu
			},
			//쿼리 업데이트를 위한 page 데이터 변경 및 쿼리 변경 메서드
			changeAdminMenu(adminMenu){
				this.adminMenu=adminMenu;
				const queryParams = new URLSearchParams(window.location.search);
				queryParams.set('adminMenu', this.adminMenu);
				const newURL = `?`+queryParams.toString();
				//쿼리 히스토리 저장
				window.history.pushState({ query: queryParams.toString() }, '', newURL);
			},
		},
		created(){
			//데이터 불러오는 영역
		},
		watch:{
			//감시영역
		},
		mounted(){
			//쿼리 초기화 및 변화 감지
			this.initializePageFromQuery();
			//뒤로가기, 앞으로가기 누르면 이전 쿼리 반환
			window.addEventListener('popstate', this.initializePageFromQuery);
		},
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>