<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.chart-arrow-left{
	position: absolute;
	z-index: 1;
	top: 50%;
	margin-left:0.5em;
	transform: translate(-50%, -50%);
	color:lightgray;
	cursor:pointer;
	font-size:2em;
}
.chart-arrow-right{
	position: absolute;
	top:50%;
	right: 0%;
	margin-right:0.5em;
	transform: translate(-50%, -50%);
	font-size:2em;
	cursor:pointer;
	color:lightgray;
}
.chart-disabled{
	display:none;
	cursor:default
}
.admin-menu-bar{
	position:absolute;
	right:100%;
	top:0;
	border-top:1px solid lightgray;
	border-left:1px solid lightgray;
	border-bottom:1px solid lightgray;
}
.admin-menu{
	border:1px solid rgba(0,0,0,0);
	cursor:default;
	padding:1.5em;
}
.admin-menu:hover{
	box-shadow: -3px 0 0 rgba(0, 0, 0, 0.1);
	background-color: rgba(0, 0, 0, 0.01);
}
.selected{
	box-shadow: -3px 0 0 rgba(0, 0, 0, 0.2);
}
.admin-menu-box{
	border:1px solid lightgray;
	padding:3em;
}
</style>
<div id="app">
	<div class="container-fluid mt-4" style="position:relative">
		<!------------------------------ 좌측 사이드 메뉴바 ---------------------------->
		<div style="width:20%">
			<div class="admin-menu-bar" style="width:inherit">
				<div class="admin-menu" @click="changeAdminMenu(1)" :class="{'selected':adminMenu==1}">
					<h5 class="m-0">회원 관리</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(2)" :class="{'selected':adminMenu==2}">
						<h5 class="m-0">신고 관리</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(3)" :class="{'selected':adminMenu==3}">
						<h5 class="m-0">회원 통계</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(4)" :class="{'selected':adminMenu==4}">
						<h5 class="m-0">게시물 통계</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(5)" :class="{'selected':adminMenu==5}">
						<h5 class="m-0">조회 통계</h5>
				</div>
			</div>
		</div>
		<div class="row admin-menu-box">
		<!--------------------------- 회원 관리 시작 --------------------------->
			<div class="col" v-show="adminMenu==1">
				<div class="row">
					<div class="col">
						<h2>회원관리</h2>
					</div>
				</div>
				<hr>
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
				<hr>
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
		<!--------------------------- 신고 관리 시작 --------------------------->
			<div class="col" v-show="adminMenu==2">
				<div class="row">
					<div class="col">
						<h1>신고관리</h1>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<h3 @click="showReportContentModal">신고 내용 관리</h3>
					</div>
				</div>
			<!-- 신고 리스트 -->
				<div class="row">
					<div class="col">
						<table class="table">
							<thead>
								<tr>
									<th>회원정보</th>
									<th>신고 위치</th>
									<th>신고개수</th>
									<th>처리여부</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(report, index) in reportList" :key="index">
									<td>{{report.memberName}}{{report.memberNick}}</td>
									<td>{{report.reportTable}}</td>
									<td>{{report.count}}</td>
									<td>{{report.reportCheck}}</td>
									<td>내용보기</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		<!--------------------------- 신고 관리 끝 --------------------------->
		<!--------------------------- 회원 통계 --------------------------->
			<div class="col" v-show="adminMenu==3">
				<div class="row">
					<div class="col">
						<h1>회원 통계</h1>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<h3>방문자 수 통계</h3>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<input type="radio" value="days" v-model="memberLoginSearch.col" :checked="memberLoginSearch.col=='days'" />일별
						<input type="radio" value="months" v-model="memberLoginSearch.col" :checked="memberLoginSearch.col=='months'" />월별
					</div>
					<div class="col">
						<select class="form-control" v-model="memberLoginSearch.order">
							<option value="all_parts.date_part DESC">날짜별 정렬</option>
							<option value="count desc">많은 순</option>
						</select>
					</div>
					<div class="col">
						<button type="button" class="btn btn-secondary" @click="getMemberLoginStats(true)">검색</button>
					</div>
				</div>
				<div class="row">
					<div class="col" style="position:relative">
						<div class="chart-arrow-left" :class="{'chart-disabled':!loginChartLeft}">
							<i class="fa-solid fa-chevron-left" @click="loginStatsPrev"></i>
						</div>
						<div class="chart-arrow-right" :class="{'chart-disabled':memberLoginSearch.page==1}">
							<i class="fa-solid fa-chevron-right" @click="loginStatsNext"></i>
						</div>
						<canvas ref="loginChart"></canvas>
					</div>
				</div>
				
				<!-- 가입자 수 퉁계 -->
				
				<div class="row">
					<div class="col">
						<h3>가입자 수 통계</h3>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<input type="radio" value="days" v-model="memberJoinSearch.col" :checked="memberJoinSearch.col=='days'" />일별
						<input type="radio" value="months" v-model="memberJoinSearch.col" :checked="memberJoinSearch.col=='months'" />월별
					</div>
					<div class="col">
						<select class="form-control" v-model="memberJoinSearch.order">
							<option value="all_parts.date_part DESC">날짜별 정렬</option>
							<option value="count desc">많은 순</option>
						</select>
					</div>
					<div class="col">
						<button type="button" class="btn btn-secondary" @click="getMemberJoinStats(true)">검색</button>
					</div>
				</div>
				<div class="row">
					<div class="col" style="position:relative">
						<div class="chart-arrow-left" :class="{'chart-disabled':!joinChartLeft}">
							<i class="fa-solid fa-chevron-left" @click="joinStatsPrev"></i>
						</div>
						<div class="chart-arrow-right" :class="{'chart-disabled':memberJoinSearch.page==1}">
							<i class="fa-solid fa-chevron-right" @click="joinStatsNext"></i>
						</div>
						<canvas ref="joinChart"></canvas>
					</div>
				</div>
				
				<!-- 누적 통계 -->
				
				<div class="row">
					<div class="col">
						<h3>누적 통계</h3>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<input type="radio" value="member_join" v-model="memberCumulativeSearch.stat" :checked="memberCumulativeSearch.stat=='member_join'" />가입자
						<input type="radio" value="member_login" v-model="memberCumulativeSearch.stat" :checked="memberCumulativeSearch.stat=='member_login'" />접속자
					</div>
					<div class="col">
						<button type="button" class="btn btn-secondary" @click="getMemberCumulativeStats()">검색</button>
					</div>
				</div>
				<div class="row">
					<div class="col" style="position:relative">
						<canvas ref="cumulativeChart"></canvas>
					</div>
				</div>
			</div>
		<!--------------------------- 게시물 통계 --------------------------->
			<div class="col" v-show="adminMenu==4">
				<div class="row">
					<div class="col">
						<h1>게시물 통계</h1>
					</div>
				</div>
				
				<!-- 게시물 수 통계 -->
				<div class="row">
					<div class="col">
						<h3>게시물 수 통계</h3>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<input type="radio" value="days" v-model="boardTimeSearch.col" :checked="boardTimeSearch.col=='days'" />일별
						<input type="radio" value="months" v-model="boardTimeSearch.col" :checked="boardTimeSearch.col=='months'" />월별
					</div>
					<div class="col">
						<select class="form-control" v-model="boardTimeSearch.order">
							<option value="all_parts.date_part DESC">날짜별 정렬</option>
							<option value="count desc">많은 순</option>
						</select>
					</div>
					<div class="col">
						<button type="button" class="btn btn-secondary" @click="getBoardTimeStats(true)">검색</button>
					</div>
				</div>
				<div class="row">
					<div class="col" style="position:relative">
						<div class="chart-arrow-left" :class="{'chart-disabled':!boardTimeChartLeft}">
							<i class="fa-solid fa-chevron-left" @click="boardTimeStatsPrev"></i>
						</div>
						<div class="chart-arrow-right" :class="{'chart-disabled':boardTimeSearch.page==1}">
							<i class="fa-solid fa-chevron-right" @click="boardTimeStatsNext"></i>
						</div>
						<canvas ref="boardTimeChart"></canvas>
					</div>
				</div>
				<!-- 게시물 태그 수 통계 -->
				<div class="row">
					<div class="col">
						<h3>태그 통계</h3>
					</div>
				</div>
				<div class="row">
					<div class="col-10">
						<div class="row">
							<div class="col">
								<span>기간설정 </span>
							</div>
							<div class="col-4">
								<input class="form-control" type="date" v-model="boardTagSearch.startDate">
							</div>
							<div class="col">
								<span> 부터 </span>
							</div>
							<div class="col-4">
								<input class="form-control" type="date" v-model="boardTagSearch.endDate">
							</div>
							<div class="col">
								<span> 까지</span>
							</div>
						</div>
					</div>
					<div class="col-2">
						<button type="button" class="btn btn-secondary" @click="getBoardTagStats(true)">검색</button>
					</div>
				</div>
				<div class="row">
					<div class="col" style="position:relative">
						<div class="chart-arrow-left" :class="{'chart-disabled':boardTagSearch.page==1}">
							<i class="fa-solid fa-chevron-left" @click="boardTagStatsPrev"></i>
						</div>
						<div class="chart-arrow-right" :class="{'chart-disabled':!boardTagChartRight}">
							<i class="fa-solid fa-chevron-right" @click="boardTagStatsNext"></i>
						</div>
						<canvas ref="boardTagChart"></canvas>
					</div>
				</div>
			</div>
		<!--------------------------- 조회 통계 --------------------------->
			<div class="col" v-show="adminMenu==5">
				<div class="row">
					<div class="col">
						<h1>조회 통계</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고 내용 관리 모달-------------------------- -->
	<div class="modal" tabindex="-1" role="dialog" id="reportContentModal" data-bs-backdrop="static" ref="reportContentModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">신고 내용 관리</h5>
					<button type="button" class="btn-close" @click="hideReportContentModal" aria-label="Close">
					<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row">
						<div class="col">
							<input class="form-control rounded" placeholder="신규 내용 추가" type="text" v-model="newReportContent">
						</div>
						<div class="col">
							<button class="btn btn-primary" @click="insertReportContent">등록</button>
						</div>
					</div>
					<div class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo">
						<div class="row" v-if="!reportContentListEdit[index]">
							<div class="col">
								<span>{{report.reportListContent}}</span>
							</div>
							<div class="col">
								<i class="fa-solid fa-pen-to-square" @click="reportContentListEdit[index]=true"></i>
								<i class="fa-solid fa-trash" @click="deleteReportContent(report.reportListNo)"></i>
							</div>
						</div>
						<div class="row" v-if="reportContentListEdit[index]">
							<div class="col">
								<input class="form-control" v-model="reportContentListSub[index].reportListContent">
							</div>
							<div class="col">
								<i class="fa-solid fa-xmark" @click="hideReportContentEdit(index)"></i>
								<i class="fa-solid fa-check" @click="updateReportContent(index, report.reportListNo)"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">확인</button>
					<button type="button" class="btn btn-secondary" @click="hideReportContentModal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고 내용 관리 모달 끝-------------------------- -->

	
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<!-- SockJS라이브러리 의존성 추가  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<!-- chartJS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	//chartJS 변수 선언
	let loginChart;
	let joinChart;
	let cumulativeChart;
	let boardTimeChart;
	let boardTagChart;
	Vue.createApp({
		data() {
			return {
				end:10,
				begin:1,
				adminMenu:1,
				memberList:[],
				memberSearchOption:{
					memberName:"", memberEmail:"", memberNick:"", searchLoginDays:"", memberAddress:"",	memberLevel:"",
					memberGender:"", memberMinReport:"", memberMaxReport:"", memberBeginBirth:"", memberEndBirth:"",memberMinFollow:"",
					memberMaxFollow:"",	orderListString:"",	page:1,
				},
				memberOrderList:["","",""],
				memberSearchPagination:{
					begin:"", end:"", totalPage:"",	startBlock:"", finishBlock:"", first:false, last:false, prev:false,
					next:false, nextPage:"", prevPage:"",
				},
				/*---------------------------신고 데이터 --------------------------- */
				reportContentModal:null,
				newReportContent:"",
				reportContentList:[],
				reportContentListSub:[],
				reportContentListEdit:[],
				reportList:[],
				reportSocket:null,
				/*---------------------------회원 통계 데이터 --------------------------- */
				memberLoginSearch:{
					stat:"member_login",
					col:"days",
					order:"all_parts.date_part DESC",
					page:1,
				},
				memberJoinSearch:{
					stat:"member_join",
					col:"days",
					order:"all_parts.date_part DESC",
					page:1,
				},
				memberCumulativeSearch:{
					stat:"member_join",
					col:"days",
					page:1,
				},
				memberLoginList:{
					col:[],
					count:[],
				},
				memberJoinList:{
					col:[],
					count:[],
				},
				memberCumulativeList:{
					col:[],
					count:[],
				},
				loginChartLeft:true,
				joinChartLeft:true,
				/*---------------------------게시물 통계 데이터 --------------------------- */
				boardTimeSearch:{
					col:"days",
					order:"all_parts.date_part DESC",
					page:1,
				},
				boardTagSearch:{
					startDate:"",
					endDate:"",
					page:1,
				},
				boardTimeList:{
					col:[],
					count:[],
				},
				boardTagList:{
					tagName:[],
					count:[],
				},
				boardTimeChartLeft:true,
				boardTagChartRight:true,
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
			/*------------------------------ 메뉴바 시작 ------------------------------*/
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
			/*------------------------------ 메뉴바 끝 ------------------------------*/
			/*------------------------------ 회원관리 시작 ------------------------------*/
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
			},
			/*------------------------------ 회원관리 끝 ------------------------------*/
			/*------------------------------ 신고관리 시작 ------------------------------*/
 			showReportContentModal(){
				if(this.reportContentModal==null) return;
				this.reportContentModal.show();
				this.loadReportContent();
			},
			hideReportContentModal(){
				if(this.reportContentModal==null) return;
				this.reportContentModal.hide();
			},
			async insertReportContent(){
				const resp = await axios.post(contextPath+"/rest/reportContent/", {reportListContent:this.newReportContent});
				this.newReportContent="";
				this.loadReportContent();
			},
			async loadReportContent(){
				const resp = await axios.get(contextPath+"/rest/reportContent/");
				this.reportContentList = [...resp.data];
				this.reportContentListSub = _.cloneDeep(this.reportContentList);
			},
			async deleteReportContent(no){
				const resp = await axios.delete(contextPath+"/rest/reportContent/"+no);
				this.loadReportContent();
			},
			async updateReportContent(index, no){
				const data = {
					reportListNo:no,
					reportListContent:this.reportContentListSub[index].reportListContent,
				};
				const resp = await axios.put(contextPath+"/rest/reportContent/", data);
				this.hideReportContentEdit(index);
				this.loadReportContent();
			},
			hideReportContentEdit(index){
				this.reportContentListEdit[index]=false;
				this.reportContentListSub[index].reportListContent = this.reportContentList[index].reportListContent; 
			},
			async loadReportList(){
				const resp = await axios.get(contextPath+"/rest/report/");
				this.reportList=[...resp.data];
			},
 			connectReportServer(){
				const url = contextPath+"/ws/admin/report";
				this.socket = new SockJS(url);
				
				this.socket.onopen = ()=>{
				};
				this.socket.onclose= ()=>{
				};
				this.socket.onerror= ()=>{
				};
				//메세지를 수신하면 수신된 메세지로 태그를 만들어서 추가
				this.socket.onmessage=(e)=>{
					const data = JSON.parse(e.data);
					console.log(data);
					this.reportList = [...data];
				};
			},
			/*------------------------------ 신고관리 끝 ------------------------------*/
			/*------------------------------ 멤버통계 시작 ------------------------------*/
			async getMemberLoginStats(buttonClick){
				if(buttonClick){
					this.memberLoginSearch.page=1;
				}
				const resp = await axios.post(contextPath+"/rest/member/stats/", this.memberLoginSearch)
				this.loginChartLeft=true;
				if(this.memberLoginSearch.col=='days'){
					if(resp.data.length<31){
						this.loginChartLeft=false;
					}
				}
				else{
					if(resp.data.length<12){
						this.loginChartLeft=false;
					}
				}
				this.memberLoginList.col = _.map(resp.data, 'col');
				this.memberLoginList.count = _.map(resp.data, 'count');
				if(this.memberLoginSearch.order=='all_parts.date_part DESC'){
					this.memberLoginList.col.reverse();
					this.memberLoginList.count.reverse();
				}
				//캔버스 사용 초기화
				if(loginChart!=null) {
					loginChart.destroy();
				}
				loginChart = this.$refs.loginChart;
				
				loginChart = new Chart(loginChart, {
					type: "bar",
					data: {
						labels: this.memberLoginList.col,
						datasets: [
							{
								label: "방문자 수(명)",
								data: this.memberLoginList.count,
								borderWidth: 1,
								backgroundColor: [
									"navy",
								],
								borderColor: [
									"navy",
								],
							},
						],
					},
					options: {
						scales: {
							y: {beginAtZero: true,},
						},
					},
				});
			},
			async getMemberJoinStats(buttonClick){
				if(buttonClick){
					this.memberJoinSearch.page=1;
				}
				const resp = await axios.post(contextPath+"/rest/member/stats/", this.memberJoinSearch);
				this.joinChartLeft=true;
				if(this.memberJoinSearch.col=='days'){
					if(resp.data.length<31){
						this.joinChartLeft=false;
					}
				}
				else{
					if(resp.data.length<12){
						this.joinChartLeft=false;
					}
				}
				this.memberJoinList.col = _.map(resp.data, 'col');
				this.memberJoinList.count = _.map(resp.data, 'count');
				if(this.memberJoinSearch.order=='all_parts.date_part DESC'){
					this.memberJoinList.col.reverse();
					this.memberJoinList.count.reverse();
				}
				//차트 초기화
				if(joinChart!=null) {
					joinChart.destroy();
				}
				joinChart = this.$refs.joinChart;
				
				joinChart = new Chart(joinChart, {
					type: "bar",
					data: {
						labels: this.memberJoinList.col,
						datasets: [
							{
								label: "가입자 수(명)",
								data: this.memberJoinList.count,
								borderWidth: 1,
								backgroundColor: [
									"navy",
								],
								borderColor: [
									"navy",
								],
							},
						],
					},
					options: {
						scales: {
							y: {beginAtZero: true,},
						},
					},
				});
			},
			async getMemberCumulativeStats(buttonClick){
				if(buttonClick){
					this.memberCumulativeSearch.page=1;
				}
				const resp = await axios.post(contextPath+"/rest/member/stats/cumulative/", this.memberCumulativeSearch);
				this.memberCumulativeList.col = _.map(resp.data, 'col');
				this.memberCumulativeList.count = _.map(resp.data, 'count');
				if(this.memberCumulativeList.col[0]==null){
					this.memberCumulativeList.col.splice(0, 1);
					this.memberCumulativeList.count.splice(0, 1);
				}
				//차트 초기화
				if(cumulativeChart!=null) {
					cumulativeChart.destroy();
				}
				cumulativeChart = this.$refs.cumulativeChart;
				
				cumulativeChart = new Chart(cumulativeChart, {
					type: "bar",
					data: {
						labels: this.memberCumulativeList.col.reverse(),
						datasets: [
							{
								label: "가입자 수(명)",
								data: this.memberCumulativeList.count.reverse(),
								borderWidth: 1,
								backgroundColor: [
									"navy",
								],
								borderColor: [
									"navy",
								],
							},
						],
					},
					options: {
						scales: {
							y: {beginAtZero: true,},
						},
					},
				});
			},
			//차트 좌우버튼 클릭시
			loginStatsPrev(){
				this.memberLoginSearch.page++;
				this.getMemberLoginStats();
			},
			loginStatsNext(){
				this.memberLoginSearch.page--;
				this.getMemberLoginStats();
			},
			joinStatsPrev(){
				this.memberJoinSearch.page++;
				this.getMemberJoinStats();
			},
			joinStatsNext(){
				this.memberJoinSearch.page--;
				this.getMemberJoinStats();
			},
		/*------------------------------ 멤버통계 끝 ------------------------------*/
		/*------------------------------ 게시물통계통계 시작 ------------------------------*/
			async getBoardTimeStats(buttonClick){
				if(buttonClick){
					this.boardTimeSearch.page=1;
				}
				const resp = await axios.post(contextPath+"/rest/board/stats/boardTime", this.boardTimeSearch)
				this.boardTimeChartLeft=true;
				if(this.boardTimeSearch.col=='days'){
					if(resp.data.length<31){
						this.boardTimeChartLeft=false;
					}
				}
				else{
					if(resp.data.length<12){
						this.boardTimeChartLeft=false;
					}
				}
				this.boardTimeList.col = _.map(resp.data, 'col');
				this.boardTimeList.count = _.map(resp.data, 'count');
				if(this.boardTimeSearch.order=='all_parts.date_part DESC'){
					this.boardTimeList.col.reverse();
					this.boardTimeList.count.reverse();
				}
				//캔버스 사용 초기화
				if(boardTimeChart!=null) {
					boardTimeChart.destroy();
				}
				boardTimeChart = this.$refs.boardTimeChart;
				
				boardTimeChart = new Chart(boardTimeChart, {
					type: "bar",
					data: {
						labels: this.boardTimeList.col,
						datasets: [
							{
								label: "생성 개수",
								data: this.boardTimeList.count,
								borderWidth: 1,
								backgroundColor: [
									"navy",
								],
								borderColor: [
									"navy",
								],
							},
						],
					},
					options: {
						scales: {
							y: {beginAtZero: true,},
						},
					},
				});
			},
			async getBoardTagStats(buttonClick){
				if(buttonClick){
					this.boardTagSearch.page=1;
				}
				const resp = await axios.post(contextPath+"/rest/board/stats/boardTag", this.boardTagSearch)
				this.boardTagChartRight=true;
				if(resp.data.length<15){
					this.boardTagChartRight=false;
				}
				this.boardTagList.tagName = _.map(resp.data, 'tagName');
				this.boardTagList.count = _.map(resp.data, 'count');
				//캔버스 사용 초기화
				if(boardTagChart!=null) {
					boardTagChart.destroy();
				}
				boardTagChart = this.$refs.boardTagChart;
				
				boardTagChart = new Chart(boardTagChart, {
					type: "bar",
					data: {
						labels: this.boardTagList.tagName,
						datasets: [
							{
								label: "생성 개수",
								data: this.boardTagList.count,
								borderWidth: 1,
								backgroundColor: [
									"navy",
								],
								borderColor: [
									"navy",
								],
							},
						],
					},
					options: {
						scales: {
							y: {beginAtZero: true,},
						},
					},
				});
			},
			//차트 좌우버튼 클릭시
			boardTimeStatsPrev(){
				this.boardTimeSearch.page++;
				this.getBoardTimeStats();
			},
			boardTimeStatsNext(){
				this.boardTimeSearch.page--;
				this.getBoardTimeStats();
			},
			boardTagStatsPrev(){
				this.boardTagSearch.page--;
				this.getBoardTagStats();
			},
			boardTagStatsNext(){
				this.boardTagSearch.page++;
				this.getBoardTagStats();
			},
		
		/*------------------------------ 게시물통계통계 끝 ------------------------------*/

		},
		created(){
			//데이터 불러오는 영역
			this.loadMemberList();
			this.loadReportList();
			this.connectReportServer();
			this.getMemberLoginStats();
			this.getMemberJoinStats();
			this.getMemberCumulativeStats();
			this.getBoardTimeStats();
			this.getBoardTagStats();
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
			//모달 선언
			this.reportContentModal = new bootstrap.Modal(this.$refs.reportContentModal);
		},
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>