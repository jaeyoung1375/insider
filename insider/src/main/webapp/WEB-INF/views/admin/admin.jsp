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
	<!------------------------------ 좌측 사이드 메뉴바 ---------------------------->
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
	<!--------------------------- 회원 관리 시작 --------------------------->
		<div class="col-md-8" v-show="adminMenu==1">
			<div class="row">
				<div class="col">
					<h1>회원관리</h1>
				</div>
			</div>
		<!-- 검색창 시작 -->
			<div class="row">
				<div class="row">
					<div class="col-2">
						<span>이름</span>
					</div>
					<div class="col-4">
						<input class="form-control" v-model="memberSearchOption.memberName">
					</div>
					<div class="col-2">
						<span>닉네임</span>
					</div>
					<div class="col-4">
						<input class="form-control" v-model="memberSearchOption.memberNick">
					</div>
				</div>
				<div class="row">
					<div class="col-2">
						<span>이메일</span>
					</div>
					<div class="col-4">
						<input class="form-control" v-model="memberSearchOption.memberEmail">
					</div>
					<div class="col-2">
						<span>로그인 기록</span>
					</div>
					<div class="col-4">
						<select class="form-control" v-model="memberSearchOption.searchLoginDays">
							<option value="">선택</option>
							<option value="1">1일전</option>
							<option value="7">7일전</option>
							<option value="30">30일전</option>
							<option value="365">365일전</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-2">
						<span>주소</span>
					</div>
					<div class="col-4">
						<input class="form-control" v-model="memberSearchOption.memberAddress">
					</div>
					<div class="col-2">
						<span>성별</span>
					</div>
					<div class="col-4">
						<select class="form-control" v-model="memberSearchOption.memberGender">
							<option value="">선택</option>
							<option value="0">남성</option>
							<option value="1">여성</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-2">
						<span>팔로우</span>
					</div>
					<div class="col-4">
						<div class="row">
							<div class="col-5">
								<input class="form-control" v-model="memberSearchOption.memberMinFollow">
							</div>
							<div class="col-2">
								<span>~</span>
							</div>
							<div class="col-5">
								<input class="form-control" v-model="memberSearchOption.memberMaxFollow">
							</div>
						</div>
					</div>
					<div class="col-2">
						<span>신고</span>
					</div>
					<div class="col-4">
						<div class="row">
							<div class="col-5">
								<input class="form-control" v-model="memberSearchOption.memberMinReport">
							</div>
							<div class="col-2">
								<span>~</span>
							</div>
							<div class="col-5">
								<input class="form-control" v-model="memberSearchOption.memberMaxReport">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-2">
						<span>생일</span>
					</div>
					<div class="col-10">
						<div class="row">
							<div class="col-5">
								<input type="date" class="form-control" v-model="memberSearchOption.memberBeginBirth">
							</div>
							<div class="col-2">
								<span>~</span>
							</div>
							<div class="col-5">
								<input type="date" class="form-control" v-model="memberSearchOption.memberEndBirth">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<span>정렬 순서</span>
					</div>
					<div class="col">
						<select class="form-control" v-model="memberOrderList[0]">
							<option value="" selected>팔로워(선택)</option>
							<option value="member_follow asc">팔로워 적은순</option>
							<option value="member-follow desc">팔로워 많은순</option>
						</select>
					</div>
					<div class="col">
						<select class="form-control" v-model="memberOrderList[1]">
							<option value="" selected>신고수(선택)</option>
							<option value="member_report asc">신고수 적은순</option>
							<option value="member_report desc">신고수 많은순</option>
						</select>
					</div>
					<div class="col">
						<select class="form-control" v-model="memberOrderList[2]">
							<option value="" selected>로그인(선택)</option>
							<option value="member_login desc">최근 접속자</option>
							<option value="member_login asc">접속 기간 긴 순</option>
						</select>
					</div>
					<div class="col">
						<button type="button" class="btn btn-secondary" @click="resetMemberSearchOption">초기화</button>
						<button type="button" class="btn btn-primary" @click="getListWithSearchOption">검색</button>
					</div>
				</div>
			</div>
		<!-- 검색창 끝 -->
		<!-- 테이블 시작 -->
			<div class="row">
				<div class="col">
					<table class="table">
						<thead>
							<tr>
								<th>프로필</th>
								<th>이름</th>
								<th>닉네임</th>
								<th>이메일</th>
								<th>신고</th>
								<th>팔로우</th>
							</tr>
						</thead>
						<tbody>
							<tr v-for="(member, index) in memberList" :key="member.memberNo">
								<td><img src="">프로필</td>
								<td>{{member.memberName}}</td>
								<td>{{member.memberNick}}</td>
								<td>{{member.memberEmail}}</td>
								<td>{{member.memberReport}}</td>
								<td>{{member.memberFollow}}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		<!-- 테이블 끝 -->
		<!-- 페이지네이션 -->
			<div class="row mt-4" id="paging">
				<div class="col d-flex justify-content-center align-items-center">
					<ul class="pagination">
						<li class="page-item" @click="memberFirstPage" :class="{disabled:this.memberSearchPagination.first}">
							<span class="page-link"><i class="fa-solid fa-angles-left"></i></span>
						</li>
						<li class="page-item" @click="memberPrevPage" :class="{disabled:!this.memberSearchPagination.prev}">
							<span class="page-link"><i class="fa-solid fa-angle-left"></i></span>
						</li>
						<li class="page-item" v-for="index in (memberSearchPagination.finishBlock-memberSearchPagination.startBlock+1)" :key="index"
							 :class="{active:(index+memberSearchPagination.startBlock-1)==memberSearchOption.page}">
							<span class="page-link" @click="memberSearchOption.page=index+memberSearchPagination.startBlock-1">{{index+memberSearchPagination.startBlock-1}}</span>
						</li>
						<li class="page-item" @click="memberNextPage" :class="{disabled:!this.memberSearchPagination.next}">
							<span class="page-link"><i class="fa-solid fa-angle-right"></i></span>
						</li>
						<li class="page-item" @click="memberLastPage" :class="{disabled:this.memberSearchPagination.last}">
							<span class="page-link"><i class="fa-solid fa-angles-right"></i></span>
						</li>
					</ul>
				</div>
			</div>
		</div>
	<!--------------------------- 회원 관리 끝--------------------------->
		
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<script>
	Vue.createApp({
		data() {
			return {
				end:10,
				begin:1,
				adminMenu:1,
				memberList:[],
				memberSearchOption:{
					memberName:"",
					memberEmail:"",
					memberNick:"",
					searchLoginDays:"",
					memberAddress:"",
					memberLevel:"",
					memberGender:"",
					memberMinReport:"",
					memberMaxReport:"",
					memberBeginBirth:"",
					memberEndBirth:"",
					memberMinFollow:"",
					memberMaxFollow:"",
					orderListString:"",
					page:1,
				},
				memberOrderList:["","",""],
				memberSearchPagination:{
					begin:"",
					end:"",
					totalPage:"",
					startBlock:"",
					finishBlock:"",
					first:false,
					last:false,
					prev:false,
					next:false,
					nextPage:"",
					prevPage:"",
				}
				
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
			
			//회원 리스트 출력
			async loadMemberList(){
				const resp = await axios.get(contextPath+"/rest/member/list", {params:this.memberSearchOption});
				this.memberList=[...resp.data.memberList];
				this.memberSearchPagination=resp.data.paginationVO;
			},
			//회원 리스트 초기화 버튼 클릭시
			resetMemberSearchOption(){
				this.memberSearchOption.memberName="";
				this.memberSearchOption.memberEmail="";
				this.memberSearchOption.memberNick="";
				this.memberSearchOption.searchLoginDays="";
				this.memberSearchOption.memberAddress="";
				this.memberSearchOption.memberLevel="";
				this.memberSearchOption.memberGender="";
				this.memberSearchOption.memberMinReport="";
				this.memberSearchOption.memberMaxReport="";
				this.memberSearchOption.memberBeginBirth="";
				this.memberSearchOption.memberEndBirth="";
				this.memberSearchOption.memberMinFollow="";
				this.memberSearchOption.memberMaxFollow="";
				this.memberOrderList=["","",""];
			},
			//회원 검색 버튼 클릭시
			async getListWithSearchOption(){
				this.memberSearchOption.page=1;
				const resp = await axios.get(contextPath+"/rest/member/list", {params:this.memberSearchOption});
				this.memberList=[...resp.data.memberList];
				this.memberSearchPagination=resp.data.paginationVO;
			},
			//페이지네이션 처음, 이전, 다음 끝 버튼 누를 때
			memberFirstPage(){
				if(!this.memberSearchPagination.first) this.memberSearchOption.page=1;
			},
			memberPrevPage(){
				if(this.memberSearchPagination.prev) this.memberSearchOption.page=this.memberSearchPagination.prevPage;
			},
			memberNextPage(){
				if(this.memberSearchPagination.next) this.memberSearchOption.page=this.memberSearchPagination.nextPage;
			},
			memberLastPage(){
				if(!this.memberSearchPagination.last) this.memberSearchOption.page=this.memberSearchPagination.totalPage;
			},
			//orderList 쿼리파라미터 반환
			makeQueryForOrderList(){
				const orderListParams = this.memberOrderList.join(',');
				this.memberSearchOption.orderList=orderListParams;
			}
		},
		created(){
			//데이터 불러오는 영역
			this.loadMemberList();
		},
		watch:{
			//감시영역
			"memberSearchOption.page":function(newVal, oldVal){
				this.loadMemberList();
			},
			memberOrderList:{
				deep:true,
				handler(newVal, oldVal) {
					this.makeQueryForOrderList();
				}
			},
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