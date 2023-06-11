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
/* 게시물 네모박스 css */
.box {
	position: relative;
	width: 16.66667%;
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
	color:white;
}
.box:hover .content-box{
	background-color:rgba(34, 34, 34, 0.13);
	z-index:5;
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
/* 게시물 네모박스 css 끝 */

/* 모달이 사이즈가 커지면 스크롤이 생기고 헤더 고정 */
.modal-content-custom{
	margin:0;
	padding:0.4em;
	padding-right:0.7em;
	max-height:100%;
	overflow-y:hidden;
	overflow-x:hidden;
}
.modal-header-custom{
	padding:1.3em;
	position:sticky; 
	border-bottom:1px solid lightgray;
	top:0; 
	z-index:1; 
	background-color:white;
	border-top-left-radius: 0.5rem;
	border-top-right-radius: 0.5rem;
}
.modal-footer-custom{
	position:sticky; 
	bottom:0; 
	z-index:1; 
	background-color:white;
	border-bottom-left-radius: 0.5rem;
	border-bottom-right-radius: 0.5rem;
	padding:1em;
}

.modal-body-custom{
	padding:0.4em;
	position:sticky; 
	top:0;
	max-height:700px;
	z-index:1; 
	background-color:white;
	overflow-y: auto;
	-ms-overflow-style: none;
	position: relative;
	display:flex;
	justify-content:center;
}
.card-scroll{
	overflow-y: auto;
	-ms-overflow-style: none;
	position: relative;
} 
.fullscreen{
	position:fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 5000;
	background-color: rgba(0, 0, 0, 0.2);
}
.fullscreen > .fullscreen-container{
	background-color:white;
	position: absolute;
	left: 50%;
	top: 50%;
	width: 500px;
	max-height: 80%;
	transform: translate(-50%, -50%);
	border-radius: 0.5rem;
}
</style>
<div id="app">
	<div class="container-fluid mt-4" style="position:relative; width:60%; min-width:900px">
		<!------------------------------ 좌측 사이드 메뉴바 ---------------------------->
		<div style="width:20%; min-width:160px">
			<div class="admin-menu-bar" style="width:inherit; min-width:160px">
				<div class="admin-menu" @click="changeAdminMenu(1)" :class="{'selected':adminMenu==1}">
					<h5 class="m-0">회원 관리</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(2)" :class="{'selected':adminMenu==2}">
					<h5 class="m-0">게시물 관리</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(3)" :class="{'selected':adminMenu==3}">
						<h5 class="m-0">신고 관리</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(4)" :class="{'selected':adminMenu==4}">
						<h5 class="m-0">회원 통계</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(5)" :class="{'selected':adminMenu==5}">
						<h5 class="m-0">게시물 통계</h5>
				</div>
				<div class="admin-menu" @click="changeAdminMenu(6)" :class="{'selected':adminMenu==6}">
						<h5 class="m-0">검색 통계</h5>
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
				<div class="row mb-4">
					<div class="row">
						<div class="col-2 d-flex align-items-center">
							<span>이름</span>
						</div>
						<div class="col-4 p-0">
							<input class="form-control" v-model="memberSearchOption.memberName" @keyup.enter="getListWithSearchOption">
						</div>
						<div class="col-2 d-flex align-items-center">
							<span>닉네임</span>
						</div>
						<div class="col-4 p-0">
							<input class="form-control" v-model="memberSearchOption.memberNick" @keyup.enter="getListWithSearchOption">
						</div>
					</div>
					<div class="row">
						<div class="col-2 d-flex align-items-center">
							<span>이메일</span>
						</div>
						<div class="col-4 p-0">
							<input class="form-control" v-model="memberSearchOption.memberEmail" @keyup.enter="getListWithSearchOption">
						</div>
						<div class="col-2 d-flex align-items-center">
							<span>로그인 기록</span>
						</div>
						<div class="col-4 p-0">
							<select class="form-control" v-model="memberSearchOption.searchLoginDays" @keyup.enter="getListWithSearchOption">
								<option value="">선택</option>
								<option value="1">1일전</option>
								<option value="7">7일전</option>
								<option value="30">30일전</option>
								<option value="365">365일전</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-2 d-flex align-items-center">
							<span>주소</span>
						</div>
						<div class="col-4 p-0">
							<input class="form-control" v-model="memberSearchOption.memberAddress" @keyup.enter="getListWithSearchOption">
						</div>
						<div class="col-2 d-flex align-items-center">
							<span>성별</span>
						</div>
						<div class="col-4 p-0">
							<select class="form-control" v-model="memberSearchOption.memberGender" @keyup.enter="getListWithSearchOption">
								<option value="">선택</option>
								<option value="0">남성</option>
								<option value="1">여성</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-2 d-flex align-items-center">
							<span>팔로우</span>
						</div>
						<div class="col-4 p-0">
							<div class="row">
								<div class="col-5">
									<input class="form-control" v-model="memberSearchOption.memberMinFollow" @keyup.enter="getListWithSearchOption">
								</div>
								<div class="col-2 d-flex align-items-center justify-content-center">
									<span>~</span>
								</div>
								<div class="col-5">
									<input class="form-control" v-model="memberSearchOption.memberMaxFollow" @keyup.enter="getListWithSearchOption">
								</div>
							</div>
						</div>
						<div class="col-2 d-flex align-items-center">
							<span>신고</span>
						</div>
						<div class="col-4 p-0">
							<div class="row">
								<div class="col-5">
									<input class="form-control" v-model="memberSearchOption.memberMinReport" @keyup.enter="getListWithSearchOption">
								</div>
								<div class="col-2 d-flex align-items-center justify-content-center">
									<span>~</span>
								</div>
								<div class="col-5">
									<input class="form-control" v-model="memberSearchOption.memberMaxReport" @keyup.enter="getListWithSearchOption">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-2 d-flex align-items-center">
							<span>생일</span>
						</div>
						<div class="col-6 p-0">
							<div class="row">
								<div class="col-5">
									<input type="date" class="form-control" v-model="memberSearchOption.memberBeginBirth" @keyup.enter="getListWithSearchOption">
								</div>
								<div class="col-2 d-flex align-items-center justify-content-center">
									<span>~</span>
								</div>
								<div class="col-5">
									<input type="date" class="form-control" v-model="memberSearchOption.memberEndBirth" @keyup.enter="getListWithSearchOption">
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-6 d-flex align-items-center">
									<span>정지여부</span>
								</div>
								<div class="col-6 p-0">
									<select class="form-control" v-model="memberSearchOption.memberSuspensionStatus" @keyup.enter="getListWithSearchOption">
										<option value="">전체</option>
										<option value="0">정지</option>
										<option value="1">일반</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-2 d-flex align-items-center">
							<span>정렬 순서</span>
						</div>
						<div class="col p-0">
							<select class="form-control" v-model="memberOrderList[0]" @keyup.enter="getListWithSearchOption">
								<option value="" selected>팔로워(선택)</option>
								<option value="member_follow asc">팔로워 적은순</option>
								<option value="member_follow desc">팔로워 많은순</option>
							</select>
						</div>
						<div class="col p-0">
							<select class="form-control" v-model="memberOrderList[1]" @keyup.enter="getListWithSearchOption">
								<option value="" selected>신고수(선택)</option>
								<option value="member_report asc">신고수 적은순</option>
								<option value="member_report desc">신고수 많은순</option>
							</select>
						</div>
						<div class="col p-0">
							<select class="form-control" v-model="memberOrderList[2]" @keyup.enter="getListWithSearchOption">
								<option value="" selected>로그인(선택)</option>
								<option value="member_login desc">최근 접속자</option>
								<option value="member_login asc">접속 기간 긴 순</option>
							</select>
						</div>
						<div class="col p-0">
							<button type="button" class="col-6 btn btn-secondary" @click="resetMemberSearchOption">초기화</button>
							<button type="button" class="col-6 btn btn-primary" @click="getListWithSearchOption">검색</button>
						</div>
					</div>
				</div>
			<!-- 검색창 끝 -->
			<!-- 테이블 시작 -->
				<div class="row">
					<div class="col">
						<table class="table">
							<thead>
								<tr style="border-top:1px solid lightgray">
									<th style="vertical-align:middle; width:8%">프로필</th>
									<th style="vertical-align:middle; width:20%">이름</th>
									<th style="vertical-align:middle; width:20%">닉네임</th>
									<th style="vertical-align:middle; width:30%">이메일</th>
									<th style="vertical-align:middle; width:8.666666%; text-align:center">팔로우</th>
									<th style="vertical-align:middle; width:6.666666%; text-align:center">신고</th>
									<th style="vertical-align:middle; width:6.666666%">상태</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(member, index) in memberList" :key="member.memberNo">
									<td><img class="rounded-circle" :src="'${pageContext.request.contextPath}'+member.imageURL" width="50" height="50"></td>
									<td style="vertical-align:middle">{{member.memberName}}</td>
									<td style="vertical-align:middle" class="modal-click-btn-neutral" @click="moveToMemberDetail(member.memberNick)">{{member.memberNick}}</td>
									<td style="vertical-align:middle">{{member.memberEmail}}</td>
									<td style="vertical-align:middle; text-align:center">{{member.memberFollow}}</td>
									<td style="vertical-align:middle; text-align:center">{{member.memberReport}}</td>
									<td class="modal-click-btn-negative" style="vertical-align:middle" v-if="member.memberSuspensionStatus==0" @click="clickSuspensionModal(index, 0)">정지</td>
									<td class="modal-click-btn" style="vertical-align:middle" v-else @click="clickSuspensionModal(index, 1)">일반</td>
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
		<!--------------------------- 게시물 관리 시작 --------------------------->
			<div class="col" v-show="adminMenu==2">
				<div class="row">
					<div class="col">
						<h2>게시물 관리</h2>
					</div>
				</div>
				<hr>
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">게시물</h4>
					</div>
				</div>
				<hr>
			<!-- 검색창 -->
				<div class="row">
					<div class="col-2 d-flex align-items-center">
						<span>신고</span>
					</div>
					<div class="col-4 p-0">
						<div class="row">
							<div class="col-5">
								<input class="form-control" v-model="boardSearchOption.boardMinReport" @keyup.enter="getBoardListWithSearchOption">
							</div>
							<div class="col-2 d-flex align-items-center justify-content-center">
								<span>~</span>
							</div>
							<div class="col-5">
								<input class="form-control" v-model="boardSearchOption.boardMaxReport" @keyup.enter="getBoardListWithSearchOption">
							</div>
						</div>
					</div>
					<div class="col-2 d-flex align-items-center">
						<span>좋아요</span>
					</div>
					<div class="col-4 p-0">
						<div class="row">
							<div class="col-5">
								<input class="form-control" v-model="boardSearchOption.boardMinLike" @keyup.enter="getBoardListWithSearchOption">
							</div>
							<div class="col-2 d-flex align-items-center justify-content-center">
								<span>~</span>
							</div>
							<div class="col-5">
								<input class="form-control" v-model="boardSearchOption.boardMaxLike" @keyup.enter="getBoardListWithSearchOption">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-2 d-flex align-items-center">
						<span>게시일</span>
					</div>
					<div class="col-6 p-0">
						<div class="row">
							<div class="col-5">
								<input type="date" class="form-control" v-model="boardSearchOption.boardTimeBegin" @keyup.enter="getBoardListWithSearchOption">
							</div>
							<div class="col-2 d-flex align-items-center justify-content-center">
								<span>~</span>
							</div>
							<div class="col-5">
								<input type="date" class="form-control" v-model="boardSearchOption.boardTimeEnd" @keyup.enter="getBoardListWithSearchOption">
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="row">
							<div class="col-6 d-flex align-items-center">
								<span>숨김여부</span>
							</div>
							<div class="col-6 p-0">
								<select class="form-control" v-model="boardSearchOption.boardHide">
									<option value="">전체</option>
									<option value="0">공개</option>
									<option value="1">숨김</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-2 d-flex align-items-center">
						<span>내용</span>
					</div>
					<div class="col-8 p-0">
						<input type="text" class="form-control" v-model="boardSearchOption.boardContent" @keyup.enter="getBoardListWithSearchOption">
					</div>
					<div class="col-2 d-flex align-items-center justify-content-center">
						<span class="modal-click-btn" @click="clickForbiddenModal">금지어 관리</span>
					</div>
				</div>
				<div class="row">
					<div class="col-2 d-flex align-items-center">
						<span>태그</span>
					</div>
					<div class="col-10 p-0">
						<input type="text" class="form-control" v-model="boardSearchOption.tag" placeholder="#태그" @keyup.enter="getBoardListWithSearchOption">
					</div>
				</div>
				<div class="row">
					<div class="col-2 d-flex align-items-center">
						<span>정렬 순서</span>
					</div>
					<div class="col p-0">
						<select class="form-control" v-model="boardOrderList[2]">
							<option value="" selected>작성(선택)</option>
							<option value="board_no desc">최근 작성순</option>
							<option value="board_no asc">오래된순</option>
						</select>
					</div>
					<div class="col p-0">
						<select class="form-control" v-model="boardOrderList[1]">
							<option value="" selected>신고수(선택)</option>
							<option value="board_report asc">신고수 적은순</option>
							<option value="board_report desc">신고수 많은순</option>
						</select>
					</div>
					<div class="col p-0">
						<select class="form-control" v-model="boardOrderList[0]">
							<option value="" selected>좋아요(선택)</option>
							<option value="board_like desc">좋아요 많은순</option>
							<option value="board_like asc">좋아요 적은순</option>
						</select>
					</div>
					<div class="col-3 p-0">
						<button type="button" class="col-6 btn btn-secondary" @click="resetBoardSearchOption">초기화</button>
						<button type="button" class="col-6 btn btn-primary" @click="getBoardListWithSearchOption">검색</button>
					</div>
				</div>
					<hr>
			<!-- 검색창 끝 -->
			<!-- 게시물 출력 -->
				<div class="row d-flex justify-content-center">
					<div class="box" v-for="(board, index) in boardList" :key="board.boardWithNickDto.boardNo" @click="clickBoardViewModal(index)">
						<video class="content" :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" v-if="board.boardAttachmentList.length>0 && board.boardAttachmentList[0].video"
							style="object-fit:cover" autoplay loop muted controls></video>
						<img class='content' v-if="board.boardAttachmentList.length>0 && !board.boardAttachmentList[0].video" :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" >
						<div class="content-box"></div>
						<i class="fa-regular fa-copy pages" v-if="board.boardAttachmentList.length>1"></i>
					</div>
				</div>
			<!-- 페이지네이션 -->
				<div class="row mt-4" id="paging">
					<div class="col d-flex justify-content-center align-items-center">
						<ul class="pagination">
							<li class="page-item" @click="boardFirstPage" :class="{disabled:this.boardSearchPagination.first}">
								<span class="page-link"><i class="fa-solid fa-angles-left"></i></span>
							</li>
							<li class="page-item" @click="boardPrevPage" :class="{disabled:!this.boardSearchPagination.prev}">
								<span class="page-link"><i class="fa-solid fa-angle-left"></i></span>
							</li>
							<li class="page-item" v-for="index in (boardSearchPagination.finishBlock-boardSearchPagination.startBlock+1)" :key="index"
								 :class="{active:(index+boardSearchPagination.startBlock-1)==boardSearchOption.page}">
								<span class="page-link" @click="boardSearchOption.page=index+boardSearchPagination.startBlock-1">{{index+boardSearchPagination.startBlock-1}}</span>
							</li>
							<li class="page-item" @click="boardNextPage" :class="{disabled:!this.boardSearchPagination.next}">
								<span class="page-link"><i class="fa-solid fa-angle-right"></i></span>
							</li>
							<li class="page-item" @click="boardLastPage" :class="{disabled:this.boardSearchPagination.last}">
								<span class="page-link"><i class="fa-solid fa-angles-right"></i></span>
							</li>
						</ul>
					</div>
				</div>
			<!-- 게시물 태그 시작 -->
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">게시물 태그</h4>
					</div>
				</div>
				<hr>
			<!-- 태그 검색창 -->
				<div class="row">
					<div class="col-2 d-flex align-items-center">
						<span>팔로우</span>
					</div>
					<div class="col-4 p-0">
						<div class="row">
							<div class="col-5">
								<input class="form-control" v-model="boardSearchOption.tagMinFollow" @keyup.enter="getTagListWithSearchOption">
							</div>
							<div class="col-2 d-flex align-items-center justify-content-center">
								<span>~</span>
							</div>
							<div class="col-5">
								<input class="form-control" v-model="boardSearchOption.tagMaxFollow" @keyup.enter="getTagListWithSearchOption">
							</div>
						</div>
					</div>
					<div class="col-2 d-flex align-items-center">
						<span>태그수</span>
					</div>
					<div class="col-4 p-0">
						<div class="row">
							<div class="col-5">
								<input class="form-control" v-model="boardSearchOption.tagMinCount" @keyup.enter="getTagListWithSearchOption">
							</div>
							<div class="col-2 d-flex align-items-center justify-content-center">
								<span>~</span>
							</div>
							<div class="col-5">
								<input class="form-control" v-model="boardSearchOption.tagMaxCount" @keyup.enter="getTagListWithSearchOption">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-2 d-flex align-items-center">
						<span>사용가능여부</span>
					</div>
					<div class="col p-0">
						<select class="form-control" v-model="boardSearchOption.tagAvailable">
							<option value="">전체</option>
							<option value="1">사용가능</option>
							<option value="0">사용불가</option>
						</select>
					</div>
					<div class="col d-flex align-items-center">
						<span>정렬 순서</span>
					</div>
					<div class="col-2 p-0">
						<select class="form-control" v-model="tagOrderList[1]">
							<option value="" selected>태그수(선택)</option>
							<option value="count desc">태그 많은순</option>
							<option value="count asc">태그 적은순</option>
						</select>
					</div>
					<div class="col-2 p-0">
						<select class="form-control" v-model="tagOrderList[0]">
							<option value="" selected>팔로우(선택)</option>
							<option value="tag_follow desc">팔로우 많은순</option>
							<option value="tag_follow asc">팔로우 적은순</option>
						</select>
					</div>
					<div class="col-3 p-0">
						<button type="button" class="col-6 btn btn-secondary" @click="resetTagSearchOption">초기화</button>
						<button type="button" class="col-6 btn btn-primary" @click="getTagListWithSearchOption">검색</button>
					</div>
				</div>
			<!-- 태그 리스트 -->
				<div class="row mt-4">
					<div class="col-6 p-0">
						<table class="table">
							<thead>
								<tr>
									<th style="width:40%; text-align:center">이름</th>
									<th style="width:20%; text-align:center">팔로우</th>
									<th style="width:20%; text-align:center">태그수</th>
									<th style="width:20%; text-align:center">관리</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(tag, index) in tagFirstHalfList">
									<td style="text-align:center"><a class="modal-click-btn-neutral" :href="'${pageContext.request.contextPath}/tag/'+tag.tagName">{{tag.tagName}}</a></td>
									<td style="text-align:center">{{tag.tagFollow}}</td>
									<td style="text-align:center">{{tag.count}}</td>
									<td style="text-align:center; cursor:pointer" v-if="tag.tagAvailable==1" @click="changeTagAvailable(tag.tagName, index)">사용가능</td>
									<td style="text-align:center; cursor:pointer" v-else @click="changeTagAvailable(tag.tagName, index)">사용불가</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-6 p-0">
						<table class="table">
							<thead>
								<tr>
									<th style="width:40%; text-align:center">이름</th>
									<th style="width:20%; text-align:center">팔로우</th>
									<th style="width:20%; text-align:center">태그수</th>
									<th style="width:20%; text-align:center">관리</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(tag, index) in tagSecondHalfList">
									<td style="text-align:center"><a class="modal-click-btn-neutral" :href="'${pageContext.request.contextPath}/tag/'+tag.tagName">{{tag.tagName}}</a></td>
									<td style="text-align:center">{{tag.tagFollow}}</td>
									<td style="text-align:center">{{tag.count}}</td>
									<td style="text-align:center; cursor:pointer" v-if="tag.tagAvailable==1" @click="changeTagAvailable(tag.tagName, index+Math.ceil(tagList.length/2))">사용가능</td>
									<td style="text-align:center; cursor:pointer" v-else @click="changeTagAvailable(tag.tagName, index+Math.ceil(tagList.length/2))">사용불가</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			<!-- 페이지네이션 -->
				<div class="row mt-4" id="paging">
					<div class="col d-flex justify-content-center align-items-center">
						<ul class="pagination">
							<li class="page-item" @click="tagFirstPage" :class="{disabled:this.tagSearchPagination.first}">
								<span class="page-link"><i class="fa-solid fa-angles-left"></i></span>
							</li>
							<li class="page-item" @click="tagPrevPage" :class="{disabled:!this.tagSearchPagination.prev}">
								<span class="page-link"><i class="fa-solid fa-angle-left"></i></span>
							</li>
							<li class="page-item" v-for="index in (tagSearchPagination.finishBlock-tagSearchPagination.startBlock+1)" :key="index"
								 :class="{active:(index+tagSearchPagination.startBlock-1)==boardSearchOption.tagPage}">
								<span class="page-link" @click="boardSearchOption.tagPage=index+tagSearchPagination.startBlock-1">{{index+tagSearchPagination.startBlock-1}}</span>
							</li>
							<li class="page-item" @click="tagNextPage" :class="{disabled:!this.tagSearchPagination.next}">
								<span class="page-link"><i class="fa-solid fa-angle-right"></i></span>
							</li>
							<li class="page-item" @click="tagLastPage" :class="{disabled:this.tagSearchPagination.last}">
								<span class="page-link"><i class="fa-solid fa-angles-right"></i></span>
							</li>
						</ul>
					</div>
				</div>
			</div>
		<!--------------------------- 기시물 관리 끝 --------------------------->
		<!--------------------------- 신고 관리 시작 --------------------------->
			<div class="col" v-show="adminMenu==3">
				<div class="row">
					<div class="col">
						<h2>신고관리</h2>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col">
						<h3 @click="clickReportContentModal" class="modal-click-btn">신고 내용 관리</h3>
					</div>
				</div>
				<hr>
			<!-- 검색 리스트 -->
				<div class="row">
					<div class="row">
						<div class="col-2 d-flex align-items-center">
							<span>이름</span>
						</div>
						<div class="col-4 p-0">
							<input class="form-control" v-model="reportSearchOption.memberName" @keyup.enter="getReportListWithSearchOption">
						</div>
						<div class="col-2 d-flex align-items-center">
							<span>닉네임</span>
						</div>
						<div class="col-4 p-0">
							<input class="form-control" v-model="reportSearchOption.memberNick" @keyup.enter="getReportListWithSearchOption">
						</div>
					</div>
					<div class="row">
						<div class="col-2 d-flex align-items-center">
							<span>전체 신고개수</span>
						</div>
						<div class="col-4 p-0">
							<div class="row">
								<div class="col-5">
									<input class="form-control" v-model="reportSearchOption.reportMinCount" @keyup.enter="getReportListWithSearchOption">
								</div>
								<div class="col-2 d-flex align-items-center justify-content-center">
									<span>~</span>
								</div>
								<div class="col-5">
									<input class="form-control" v-model="reportSearchOption.reportMaxCount" @keyup.enter="getReportListWithSearchOption">
								</div>
							</div>
						</div>
						<div class="col-2 d-flex align-items-center">
							<span>관리 신고개수</span>
						</div>
						<div class="col-4 p-0">
							<div class="row">
								<div class="col-5">
									<input class="form-control" v-model="reportSearchOption.reportMinManagedCount" @keyup.enter="getReportListWithSearchOption">
								</div>
								<div class="col-2 d-flex align-items-center justify-content-center">
									<span>~</span>
								</div>
								<div class="col-5">
									<input class="form-control" v-model="reportSearchOption.reportMaxManagedCount" @keyup.enter="getReportListWithSearchOption">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-2 p-0">
							<select class="form-control" v-model="reportSearchOption.suspension">
								<option value="">정지관리(선택)</option>
								<option value="">전체</option>
								<option value="0">정지</option>
								<option value="1">일반</option>
							</select>
						</div>
						<div class="col-2 p-0">
							<select class="form-control" v-model="reportSearchOption.reportTable">
								<option value="">신고 위치(선택)</option>
								<option value="board">게시물</option>
								<option value="member">회원</option>
								<option value="reply">댓글</option>
								<option value="dm">메세지</option>
							</select>
						</div>
						<div class="col-2 p-0">
							<select class="form-control" v-model="reportSearchOption.reportResult">
								<option value="">처리 여부(전체)</option>
								<option value="0">미처리</option>
								<option value="1">검토완료</option>
								<option value="2">삭제</option>
							</select>
						</div>
						<div class="col-2 p-0">
							<select class="form-control" v-model="reportSearchOption.order">
								<option value="">정렬순서(선택)</option>
								<option value="count desc">신고 많은순</option>
								<option value="count asc">신고 적은순</option>
							</select>
						</div>
						<div class="col p-0">
							<button type="button" class="col-6 btn btn-secondary" @click="resetReportSearchOption">초기화</button>
							<button type="button" class="col-6 btn btn-primary" @click="getReportListWithSearchOption">검색</button>
						</div>
					</div>
				</div>
			<!-- 신고 리스트 -->
				<div class="row mt-4">
					<div class="col">
						<table class="table">
							<thead>
								<tr>
									<th style="vertical-align:middle; text-align:left">회원정보</th>
									<th style="vertical-align:middle; text-align:center">정지관리</th>
									<th style="vertical-align:middle; text-align:center">신고 위치</th>
									<th style="vertical-align:middle; text-align:center">신고(누적)</th>
									<th style="vertical-align:middle; text-align:center">처리여부</th>
									<th style="vertical-align:middle; width:15%">&nbsp&nbsp&nbsp비고</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(report, index) in reportList" :key="index">
									<td style="cursor:pointer" @click="moveToMemberDetail(report.memberNick)">
										<div class="row">
											<div class="col-3">
												<img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+report.imageURL">
											</div>
											<div class="col-9">
												<div class="ms-2" style="font-weight:bold; font-size:1.2em">{{report.memberNick}}</div>
												<div class="ms-2">{{report.memberName}}</div>
											</div>
										</div>
									</td>
									<td class="modal-click-btn-negative" style="vertical-align:middle; text-align:center" v-if="report.memberSuspensionStatus==0" @click="clickReportSuspensionModal(index, 0)">정지</td>
									<td class="modal-click-btn" style="vertical-align:middle; text-align:center" v-else @click="clickReportSuspensionModal(index, 1)">일반</td>
									<td style="vertical-align:middle; text-align:center" v-if="report.reportTable=='board'">게시물</td>
									<td style="vertical-align:middle; text-align:center" v-if="report.reportTable=='member'">회원</td>
									<td style="vertical-align:middle; text-align:center" v-if="report.reportTable=='reply'">댓글</td>
									<td style="vertical-align:middle; text-align:center">{{report.managedCount}}
										<span v-if="report.reportResult==1">({{report.count}})</span>
										<i class="fa-solid fa-angles-up ms-2" style="color:blue" v-if="reportDifference[index].count"></i>
									</td>
									<td style="vertical-align:middle; text-align:center" v-if="report.reportResult==0">미처리</td>
									<td style="vertical-align:middle; text-align:center" v-if="report.reportResult==1">검토완료</td>
									<td style="vertical-align:middle; text-align:center" v-if="report.reportResult==2">삭제</td>
									<td style="vertical-align:middle;">
										<span class="modal-click-btn" @click="clickReportDetailModal(index)" v-if="report.reportResult!=2">내용보기</span>
										<span v-if="report.reportResult==2">삭제된내용</span>
										<i class="fa-solid fa-sort-up ms-2" style="color:blue" v-if="reportDifference[index].index>0"></i>
										<i class="fa-solid fa-sort-down ms-2" style="color:red" v-if="reportDifference[index].index<0"></i>
										<span class="ms-2" v-if="reportDifference[index].index==16">new</span>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			<!-- 리스트 끝 -->
			<!-- 페이지네이션 -->
				<div class="row mt-4" id="paging">
					<div class="col d-flex justify-content-center align-items-center">
						<ul class="pagination">
							<li class="page-item" @click="reportFirstPage" :class="{disabled:this.reportSearchPagination.first}">
								<span class="page-link"><i class="fa-solid fa-angles-left"></i></span>
							</li>
							<li class="page-item" @click="reportPrevPage" :class="{disabled:!this.reportSearchPagination.prev}">
								<span class="page-link"><i class="fa-solid fa-angle-left"></i></span>
							</li>
							<li class="page-item" v-for="index in (reportSearchPagination.finishBlock-reportSearchPagination.startBlock+1)" :key="index"
								 :class="{active:(index+reportSearchPagination.startBlock-1)==reportSearchOption.page}">
								<span class="page-link" @click="reportSearchOption.page=index+reportSearchPagination.startBlock-1">{{index+reportSearchPagination.startBlock-1}}</span>
							</li>
							<li class="page-item" @click="reportNextPage" :class="{disabled:!this.reportSearchPagination.next}">
								<span class="page-link"><i class="fa-solid fa-angle-right"></i></span>
							</li>
							<li class="page-item" @click="reportLastPage" :class="{disabled:this.reportSearchPagination.last}">
								<span class="page-link"><i class="fa-solid fa-angles-right"></i></span>
							</li>
						</ul>
					</div>
				</div>
			</div>
		<!--------------------------- 신고 관리 끝 --------------------------->
		<!--------------------------- 회원 통계 --------------------------->
			<div class="col" v-show="adminMenu==4">
				<div class="row">
					<div class="col">
						<h2>회원 통계</h2>
					</div>
				</div>
				<hr>
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">방문자 수 통계</h4>
					</div>
				</div>
				<div class="row">
					<div class="col-6"></div>
					<div class="col-2 d-flex align-items-center">
						<input type="radio" value="days" v-model="memberLoginSearch.col" :checked="memberLoginSearch.col=='days'" />
						<span class="ms-1">일별</span>
						<input class="ms-2" type="radio" value="months" v-model="memberLoginSearch.col" :checked="memberLoginSearch.col=='months'" />
						<span class="ms-1">월별</span>
					</div>
					<div class="col-3 p-0">
						<select class="form-control" v-model="memberLoginSearch.order">
							<option value="all_parts.date_part DESC">날짜별 정렬</option>
							<option value="count desc">많은 순</option>
						</select>
					</div>
					<div class="col-1 p-0">
						<button type="button" class="btn btn-secondary w-100" @click="getMemberLoginStats(true)">검색</button>
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
				<hr>
				<!-- 가입자 수 퉁계 -->
				
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">가입자 수 통계</h4>
					</div>
				</div>
				<div class="row">
					<div class="col-6"></div>
					<div class="col-2 d-flex align-items-center">
						<input type="radio" value="days" v-model="memberJoinSearch.col" :checked="memberJoinSearch.col=='days'" />
						<span class="ms-1">일별</span>
						<input class="ms-2" type="radio" value="months" v-model="memberJoinSearch.col" :checked="memberJoinSearch.col=='months'" />
						<span class="ms-1">월별</span>
					</div>
					<div class="col-3 p-0">
						<select class="form-control" v-model="memberJoinSearch.order">
							<option value="all_parts.date_part DESC">날짜별 정렬</option>
							<option value="count desc">많은 순</option>
						</select>
					</div>
					<div class="col-1 p-0">
						<button type="button" class="btn btn-secondary w-100" @click="getMemberJoinStats(true)">검색</button>
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
				<hr>
				<!-- 누적 통계 -->
				
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">누적 통계</h4>
					</div>
				</div>
				<div class="row">
					<div class="col-8"></div>
					<div class="col-3 d-flex align-items-center justify-content-center">
						<input type="radio" value="member_join" v-model="memberCumulativeSearch.stat" :checked="memberCumulativeSearch.stat=='member_join'" />
						<span class="ms-1">가입자</span>
						<input class="ms-2" type="radio" value="member_login" v-model="memberCumulativeSearch.stat" :checked="memberCumulativeSearch.stat=='member_login'" />
						<span class="ms-1">접속자</span>
					</div>
					<div class="col-1 p-0">
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
			<div class="col" v-show="adminMenu==5">
				<div class="row">
					<div class="col">
						<h2>게시물 통계</h2>
					</div>
				</div>
				<hr>
				<!-- 게시물 수 통계 -->
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">게시물 수 통계</h4>
					</div>
				</div>
				<div class="row">
					<div class="col-6"></div>
					<div class="col-2 d-flex align-items-center">
						<input type="radio" value="days" v-model="boardTimeSearch.col" :checked="boardTimeSearch.col=='days'" />
						<span class="ms-1">일별</span>
						<input class="ms-2" type="radio" value="months" v-model="boardTimeSearch.col" :checked="boardTimeSearch.col=='months'" />
						<span class="ms-1">월별</span>
					</div>
					<div class="col-3 p-0">
						<select class="form-control" v-model="boardTimeSearch.order">
							<option value="all_parts.date_part DESC">날짜별 정렬</option>
							<option value="count desc">많은 순</option>
						</select>
					</div>
					<div class="col-1 p-0">
						<button type="button" class="btn btn-secondary w-100" @click="getBoardTimeStats(true)">검색</button>
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
				<hr>
				<!-- 게시물 태그 수 통계 -->
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">태그 통계</h4>
					</div>
				</div>
				<div class="row">
					<div class="col-11">
						<div class="row">
							<div class="col-2 d-flex align-items-center justify-content-center">
								<span>기간설정 </span>
							</div>
							<div class="col-4">
								<input class="form-control" type="date" v-model="boardTagSearch.startDate" @keyup.enter="getBoardTagStats(true)">
							</div>
							<div class="col-1 d-flex align-items-center justify-content-center">
								<span> 부터 </span>
							</div>
							<div class="col-4">
								<input class="form-control" type="date" v-model="boardTagSearch.endDate" @keyup.enter="getBoardTagStats(true)">
							</div>
							<div class="col-1 d-flex align-items-center">
								<span> 까지</span>
							</div>
						</div>
					</div>
					<div class="col-1 p-0">
						<button type="button" class="btn btn-secondary w-100" @click="getBoardTagStats(true)">검색</button>
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
		<!--------------------------- 검색 통계 --------------------------->
			<div class="col" v-show="adminMenu==6">
				<div class="row">
					<div class="col">
						<h2>검색 통계</h2>
					</div>
				</div>
				<hr>
				<!-- 검색조건 -->
				<div class="row">
					<div class="col-2 d-flex align-items-center justify-content-center">
						<span>성별</span>
					</div>						
					<div class="col-2 p-0">
						<select class="form-control" v-model="searchStatsSearch.memberGender">
							<option value="">전체(선택)</option>
							<option value="0">여성</option>
							<option value="1">남성</option>
						</select>
					</div>
					<div class="col-2 d-flex align-items-center justify-content-center">
						<span>생일 </span>
					</div>
					<div class="col-6 p-0 m-0">
						<div class="row p-0 m-0">
							<div class="col-5 p-0">
								<input class="form-control" type="date" v-model="searchStatsSearch.memberBeginBirth" @keyup.enter="getSearchTagStats(true)">
							</div>
							<div class="col-2 d-flex align-items-center justify-content-center">
								<span> ~ </span>
							</div>
							<div class="col-5 p-0">
								<input class="form-control" type="date" v-model="searchStatsSearch.memberEndBirth" @keyup.enter="getSearchTagStats(true)">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-11">
						<div class="row">
							<div class="col-2 d-flex align-items-center justify-content-center">
								<span>기간설정 </span>
							</div>
							<div class="col-4">
								<input class="form-control" type="date" v-model="searchStatsSearch.searchBeginDate" @keyup.enter="getSearchTagStats(true)">
							</div>
							<div class="col-1 d-flex align-items-center justify-content-center">
								<span> 부터 </span>
							</div>
							<div class="col-4">
								<input class="form-control" type="date" v-model="searchStatsSearch.searchEndDate" @keyup.enter="getSearchTagStats(true)">
							</div>
							<div class="col-1 d-flex align-items-center">
								<span> 까지</span>
							</div>
						</div>
					</div>
					<div class="col-1 p-0">
						<button type="button" class="btn btn-secondary w-100" @click="getSearchTagStats(true)">검색</button>
					</div>
				</div>
				<!-- 검색 닉네임 통계 -->
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">검색 닉네임 통계</h4>
					</div>
				</div>
				<div class="row">
					<div class="col" style="position:relative">
						<div class="chart-arrow-left" :class="{'chart-disabled':searchStatsSearch.nickPage==1}">
							<i class="fa-solid fa-chevron-left" @click="searchNickStatsPrev"></i>
						</div>
						<div class="chart-arrow-right" :class="{'chart-disabled':!searchNickChartRight}">
							<i class="fa-solid fa-chevron-right" @click="searchNickStatsNext"></i>
						</div>
						<canvas ref="searchNickChart"></canvas>
					</div>
				</div>
				<hr>
				<!-- 검색 태그 수 통계 -->
				<div class="row mt-4">
					<div class="col">
						<h4 class="m-0">검색 태그 통계</h4>
					</div>
				</div>
				<div class="row">
					<div class="col" style="position:relative">
						<div class="chart-arrow-left" :class="{'chart-disabled':searchStatsSearch.tagPage==1}">
							<i class="fa-solid fa-chevron-left" @click="searchTagStatsPrev"></i>
						</div>
						<div class="chart-arrow-right" :class="{'chart-disabled':!searchTagChartRight}">
							<i class="fa-solid fa-chevron-right" @click="searchTagStatsNext"></i>
						</div>
						<canvas ref="searchTagChart"></canvas>
					</div>
				</div>
			</div>
		<!--------------------------- 검색 통계 끝 --------------------------->
		</div>
	</div>
	<!-- ---------------------------------신고 내용 관리 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="reportContentModal">
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">신고 내용 관리</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideReportContentModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row mb-3">
						<div class="col-10 m-0 p-0">
							<input class="form-control rounded" placeholder="신규 내용 추가" type="text" v-model="newReportContent" @keyup.enter="insertReportContent">
						</div>
						<div class="col p-0 m-0">
							<button class="btn btn-primary w-100" @click="insertReportContent">등록</button>
						</div>
					</div>
					<div class="row justify-content-center" v-for="(report, index) in reportContentList" :key="report.reportListNo">
						<div class="row" v-if="!reportContentListEdit[index]">
							<div class="col-10 p-2">
								<h5 class="m-0">{{report.reportListContent}}</h5>
							</div>
							<div class="col d-flex align-items-center">
								<i class="fa-solid fa-pen-to-square modal-click-btn-neutral" @click="reportContentListEdit[index]=true" style="font-size:1.2em"></i>
								<i class="fa-solid fa-trash ms-2 modal-click-btn-negative" @click="deleteReportContent(report.reportListNo)" style="font-size:1.2em"></i>
							</div>
						</div>
						<div class="row d-flex justify-content-center p-0" v-if="reportContentListEdit[index]">
							<div class="col-10">
								<input class="form-control" v-model="reportContentListSub[index].reportListContent" @keyup.enter="updateReportContent(index, report.reportListNo)">
							</div>
							<div class="col d-flex align-items-center p-1">
								<i class="fa-solid fa-xmark modal-click-btn-negative" @click="hideReportContentEdit(index)" style="font-size:1.2em"></i>
								<i class="fa-solid fa-check ms-3 modal-click-btn-green" @click="updateReportContent(index, report.reportListNo)" style="font-size:1.2em"></i>
							</div>
						</div>
					</div>
				</div>
				<div class="row modal-footer-custom">
					<button type="button" class="btn btn-secondary" @click="hideReportContentModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고 내용 관리 모달 끝-------------------------- -->
	<!-- ---------------------------------정지 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="suspensionModal">
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">회원 정지</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideSuspensionModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom">
					<div class="row mb-3" v-if="suspensionIndex[0]>=0">
						<div class="row" style="cursor:pointer" @click="moveToMemberDetail(memberList[suspensionIndex[0]].memberNick)">
							<div class="col-3 d-flex justify-content-end align-items-center">
								<img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+memberList[suspensionIndex[0]].imageURL">
							</div>
							<div class="col-9">
								<div class="ms-2" style="font-weight:bold; font-size:1.2em">{{memberList[suspensionIndex[0]].memberNick}}</div>
								<div class="ms-2">{{memberList[suspensionIndex[0]].memberName}}</div>
							</div>
						</div>
					</div>
				    <!-- 이미 정지당한 사람 페이지 -->
					<div class="row" v-if="suspensionIndex[1]==0">
						<div class="row mb-4">
							<div class="col">
								<div class="row">
									<div class="row">
										<div class="offset-1 col-3" style="text-align:right">
										정지 횟수 :
										</div>
										<div class="col-8 p-0">
										{{memberList[suspensionIndex[0]].memberSuspensionTimes}}
										</div>
									</div>
								</div>
								<div class="row">
									<div class="row">
										<div class="offset-1 col-3" style="text-align:right">
										정지 사유 :
										</div>
										<div class="col-8 p-0">
										{{memberList[suspensionIndex[0]].memberSuspensionContent}}
										</div>
									</div>
								</div>
								<div class="row">
									<div class="row">
										<div class="offset-1 col-3" style="text-align:right">
										기간 :
										</div>
										<div class="col-8 p-0">
										{{memberList[suspensionIndex[0]].memberSuspensionDays}}
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<h5>정지내역 수정</h5>
							</div>
						</div>						
						<div class="row">
							<div class="col">
								<select class="form-control rounded" v-model="suspensionContent[0]">
									<option value="" selected>기한(선택)</option>
									<option value="1">1일</option>
									<option value="7">7일</option>
									<option value="30">30일</option>
									<option value="365">1년</option>
									<option value="99999">영구</option>
								</select>
								<select class="form-control rounded" v-model="suspensionContent[1]">
									<option value="" selected>내용(선택)</option>
									<option class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo">{{report.reportListContent}}</option>
								</select>						
							</div>
						</div>
					</div>
					<!-- 일반 사람 페이지 -->
					<div class="row" v-if="suspensionIndex[1]==1">
						<div class="row mb-4">
							<div class="col" v-if="memberList[suspensionIndex[0]].memberSuspensionTimes>0">
								<div class="row">
									<div class="offset-1 col-3" style="text-align:right">
									정지 횟수 :
									</div>
									<div class="col-8 p-0">
									{{memberList[suspensionIndex[0]].memberSuspensionTimes}}
									</div>
								</div>
							</div>
							<div class="col" v-else>
								<div class="row">
									<div class="offset-1 col-3" style="text-align:right">
									정지 횟수 :
									</div>
									<div class="col-8 p-0">
									0
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<h5>정지내역 입력</h5>
							</div>
						</div>	
						<div class="row">
							<div class="col">
								<select class="form-control rounded" v-model="suspensionContent[0]">
									<option value="" selected>기한(선택)</option>
									<option value="1">1일</option>
									<option value="7">7일</option>
									<option value="30">30일</option>
									<option value="365">1년</option>
									<option value="99999">영구</option>
								</select>
								<select class="form-control rounded" v-model="suspensionContent[1]">
									<option value="" selected>내용(선택)</option>
									<option class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo">{{report.reportListContent}}</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row modal-footer-custom">
					<div class="row" v-if="suspensionIndex[1]==0">
						<div class="offset-3 col-3 p-0">
							<button type="button" class="btn btn-primary w-100" @click="insertSuspension()" :class="{'disabled':suspensionContent[0]=='' || suspensionContent[1]==''}">수정</button>
						</div>
						<div class="col-3 p-0">
							<button type="button" class="btn btn-primary w-100" @click="deleteSuspension()">해제</button>
						</div>
						<div class="col-3 p-0">
							<button type="button" class="btn btn-secondary w-100" @click="hideSuspensionModal">취소</button>
						</div>
					</div>
					<div class="row" v-else>
						<div class="offset-6 col-3 p-0">
							<button type="button" class="btn btn-primary w-100" @click="insertSuspension()" :class="{'disabled':suspensionContent[0]=='' || suspensionContent[1]==''}">정지</button>
						</div>
						<div class="col-3 p-0">
							<button type="button" class="btn btn-secondary w-100" @click="hideSuspensionModal">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------정지 모달 끝-------------------------- -->
	<!-- ---------------------------------신고창에서 보는 정지 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="reportSuspensionModal">
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">회원 정지</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideReportSuspensionModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom">
					<div class="row mb-3" v-if="reportSuspensionIndex[0]>=0">
						<div class="row" style="cursor:pointer" @click="moveToMemberDetail(reportList[reportSuspensionIndex[0]].memberNick)">
							<div class="col-3 d-flex justify-content-end align-items-center">
								<img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+reportList[reportSuspensionIndex[0]].imageURL">
							</div>
							<div class="col-9">
								<div class="ms-2" style="font-weight:bold; font-size:1.2em">{{reportList[reportSuspensionIndex[0]].memberNick}}</div>
								<div class="ms-2">{{reportList[reportSuspensionIndex[0]].memberName}}</div>
							</div>
						</div>
					</div>
				    <!-- 이미 정지당한 사람 페이지 -->
					<div class="row" v-if="reportSuspensionIndex[1]==0">
						<div class="row mb-4">
							<div class="col">
								<div class="row">
									<div class="row">
										<div class="offset-1 col-3" style="text-align:right">
										정지 횟수 :
										</div>
										<div class="col-8 p-0">
										{{reportList[reportSuspensionIndex[0]].memberSuspensionTimes}}
										</div>
									</div>
								</div>
								<div class="row">
									<div class="row">
										<div class="offset-1 col-3" style="text-align:right">
										정지 사유 :
										</div>
										<div class="col-8 p-0">
										{{reportList[reportSuspensionIndex[0]].memberSuspensionContent}}
										</div>
									</div>
								</div>
								<div class="row">
									<div class="row">
										<div class="offset-1 col-3" style="text-align:right">
										기간 :
										</div>
										<div class="col-8 p-0">
										{{reportList[reportSuspensionIndex[0]].memberSuspensionDays}}
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<h5>정지내역 수정</h5>
							</div>
						</div>						
						<div class="row">
							<div class="col">
								<select class="form-control rounded" v-model="reportSuspensionContent[0]">
									<option value="" selected>기한(선택)</option>
									<option value="1">1일</option>
									<option value="7">7일</option>
									<option value="30">30일</option>
									<option value="365">1년</option>
									<option value="99999">영구</option>
								</select>
								<select class="form-control rounded" v-model="reportSuspensionContent[1]">
									<option value="" selected>내용(선택)</option>
									<option class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo">{{report.reportListContent}}</option>
								</select>						
							</div>
						</div>
					</div>
					<!-- 일반 사람 페이지 -->
					<div class="row" v-if="reportSuspensionIndex[1]==1">
						<div class="row mb-4">
							<div class="col" v-if="reportList[reportSuspensionIndex[0]].memberSuspensionTimes>0">
								<div class="row">
									<div class="offset-1 col-3" style="text-align:right">
									정지 횟수 :
									</div>
									<div class="col-8 p-0">
									{{reportList[reportSuspensionIndex[0]].memberSuspensionTimes}}
									</div>
								</div>
							</div>
							<div class="col" v-else>
								<div class="row">
									<div class="offset-1 col-3" style="text-align:right">
									정지 횟수 :
									</div>
									<div class="col-8 p-0">
									0
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<h5>정지내역 입력</h5>
							</div>
						</div>	
						<div class="row">
							<div class="col">
								<select class="form-control rounded" v-model="reportSuspensionContent[0]">
									<option value="" selected>기한(선택)</option>
									<option value="1">1일</option>
									<option value="7">7일</option>
									<option value="30">30일</option>
									<option value="365">1년</option>
									<option value="99999">영구</option>
								</select>
								<select class="form-control rounded" v-model="reportSuspensionContent[1]">
									<option value="" selected>내용(선택)</option>
									<option class="row" v-for="(report, index) in reportContentList" :key="report.reportListNo">{{report.reportListContent}}</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row modal-footer-custom">
					<div class="row" v-if="reportSuspensionIndex[1]==0">
						<div class="offset-3 col-3 p-0">
							<button type="button" class="btn btn-primary w-100" @click="insertReportSuspension()" :class="{'disabled':reportSuspensionContent[0]=='' || reportSuspensionContent[1]==''}">수정</button>
						</div>
						<div class="col-3 p-0">
							<button type="button" class="btn btn-primary w-100" @click="deleteReportSuspension()">해제</button>
						</div>
						<div class="col-3 p-0">
							<button type="button" class="btn btn-secondary w-100" @click="hideReportSuspensionModal">취소</button>
						</div>
					</div>
					<div class="row" v-else>
						<div class="offset-6 col-3 p-0">
							<button type="button" class="btn btn-primary w-100" @click="insertReportSuspension()" :class="{'disabled':reportSuspensionContent[0]=='' || reportSuspensionContent[1]==''}">정지</button>
						</div>
						<div class="col-3 p-0">
							<button type="button" class="btn btn-secondary w-100" @click="hideReportSuspensionModal">취소</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고창에서 보는 정지 모달 끝-------------------------- -->
	<!-- ---------------------------------신고 세부 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="reportDetailModal">
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">신고 내용 관리</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideReportDetailModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom">
				    <!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div class="row" style="cursor:pointer" @click="moveToMemberDetail(reportDetailData.memberNick)">
						<div class="col-3 d-flex justify-content-end align-items-center">
							<img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+reportDetailData.imageURL">
						</div>
						<div class="col-9">
							<div class="ms-2" style="font-weight:bold; font-size:1.2em">{{reportDetailData.memberNick}}</div>
							<div class="ms-2">{{reportDetailData.memberName}}</div>
						</div>
					</div>
					<div class="row p-3">
						<div class="col">
							<table class="table">
								<thead>
									<tr class="p-2">
										<th style="padding-left:2.5em"> 신고항목</th>
										<th style="text-align:center">신고수</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="(report, index) in reportDetailCountList">
										<td style="padding-left:1.5em"> {{report.reportContent}}</td>
										<td style="text-align:center"> {{report.count}}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col p-0">
							<h5 class="ps-0">신고 상세</h5>
						</div>
					</div>
			<!----------- 게시물 신고내용일 경우 출력 --------->
					<div class="row p-2" v-if="reportDetailData.reportTable=='board'">
						<div class="col">
							<div class="row">
								<div class="col-12" v-for="(image, index) in reportDetailContent.boardAttachmentList" style="position:relative">
									<video class="w-100" :src="'${pageContext.request.contextPath}'+image.imageURL" v-if="image.video"
											muted controls></video>
									<img v-else style="height:auto; display:block" class="w-100" :src="'${pageContext.request.contextPath}'+image.imageURL">
								</div>
							</div>
							<div class="row mt-2">
								<div class="col-2 text-center">
									내용
								</div>
								<div class="col">
									{{reportDetailContent.boardWithNickDto.boardContent}}
								</div>
							</div>
							<div class="row">
								<div class="col-2 text-center">
									태그
								</div>
								<div class="col">
									<span v-for="(tag,index) in reportDetailContent.boardTagList" :key="index" style="cursor:pointer" @click="moveToTagDetail(tag.tagName)">\#{{tag.tagName}}&nbsp</span>
								</div>
							</div>
						</div>
					</div>
			<!----------- 게시물 신고내용일 경우 출력 --------->
			<!----------- 댓글 신고내용일 경우 출력 --------->
					<div class="row p-2" v-if="reportDetailData.reportTable=='reply'">
						<div class="col">
							<div class="row mb-2">
								<div class="col" style="font-weight:bold">
									댓글 내용
								</div>
							</div>
							<div class="row">
								<div class="col ps-4">
									{{reportDetailContent[reportDetailContentIndex].replyContent}}
								</div>
							</div>
							<div class="row mb-2 mt-3">
								<div class="col" style="font-weight:bold">
									전체 댓글 내용
								</div>
							</div>
							<div class="row mb-2" v-for="(reply, index) in reportDetailContent" :key="index">
								<div class="col-1" v-if="reply.replyParent!=0">
								</div>
								<div class="col">
									<div class="row">
										<div class="col ps-3">	
											{{reply.memberNick}}
											<i class="ms-2" style="color:#d9534f; font-weight:bold" v-if="reply.memberNick==reportDetailData.memberNick">(신고대상자)</i>
										</div>
									</div>
									<div class="row">
										<div class="col ps-4">
											: {{reply.replyContent}}
											<i class="ms-2" style="color:#d9534f; font-weight:bold" v-if="index==reportDetailContentIndex">(신고내용)</i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			<!----------- 댓글 신고내용일 경우 출력 --------->
			<!----------- 회원 신고내용일 경우 출력 --------->
					<div class="row p-2" v-if="reportDetailData.reportTable=='member'">
						<div class="col">
							<div class="row">
								<div class="col modal-click-btn">
									<h5 @click="clickReportedBoardModal">
										이 유저의 신고받은 게시물 보기 ({{reportDetailContent.boardList.length}}건)
									</h5>
								</div>
							</div>
							<div class="row">
								<div class="col modal-click-btn">
									<h5 @click="clickReportedReplyModal">
										이 유저의 신고받은 댓글 보기 ({{reportDetailContent.replyList.length}}건)
									</h5>
								</div>
							</div>
						</div>
					</div>
			<!----------- 회원 신고내용일 경우 출력 --------->
				</div>
				<div class="row modal-footer-custom">
					<div class="offset-3 col-3 p-0">
						<button class="btn btn-success w-100" type="button" @click="reportManage(1)">확인처리</button>
					</div>
					<div class="col-3 p-0">
						<button class="btn btn-danger w-100" type="button" @click="reportManage(2)">삭제처리</button>
					</div>
					<div class="col-3 p-0">
						<button type="button" class="btn btn-secondary w-100" @click="hideReportDetailModal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고 세부 모달 끝-------------------------- -->
	<!-- ---------------------------------게시물 미리보기 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="boardViewModal" style="z-index:3000">
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">게시물 미리보기</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideBoardViewModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom">
					<div class="row"  style="cursor:pointer" @click="moveToMemberDetail(boardViewContent.boardWithNickDto.memberNick)">
						<div class="col-3 d-flex justify-content-end align-items-center">
							<img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+boardViewContent.boardWithNickDto.imageURL">
						</div>
						<div class="col-9 d-flex align-items-center">
							<div class="" style="font-weight:bold; font-size:1.2em">{{boardViewContent.boardWithNickDto.memberNick}}</div>
						</div>
					</div>
					<div class="row p-2">
						<div class="col">
							<div class="row">
								<div class="col-12" v-for="(image, index) in boardViewContent.boardAttachmentList" style="position:relative">
									<video class="w-100" :src="'${pageContext.request.contextPath}'+image.imageURL" v-if="image.video"
											muted controls></video>
									<img v-else style="height:auto; display:block" class="w-100" :src="'${pageContext.request.contextPath}'+image.imageURL">
								</div>
							</div>
							<div class="row mt-2">
								<div class="col-2 text-center">
									내용
								</div>
								<div class="col">
									{{boardViewContent.boardWithNickDto.boardContent}}
								</div>
							</div>
							<div class="row">
								<div class="col-2 text-center">
									태그
								</div>
								<div class="col">
									<span v-for="(tag,index) in boardViewContent.boardTagList" :key="index"  style="cursor:pointer" @click="moveToTagDetail(tag.tagName)">\#{{tag.tagName}}&nbsp</span>
								</div>
							</div>
							<div class="row mt-3">
								<div class="col">
									<button class="btn btn-danger w-100" type="button" @click="boardDelete(boardViewContent.boardWithNickDto.boardNo)">게시물 삭제</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row modal-footer-custom">
					<button type="button" class="btn btn-secondary" @click="hideBoardViewModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------게시물 미리보기 모달 끝-------------------------- -->
	<!-- ---------------------------------금지어 관리 모달-------------------------- -->
	<div v-if="forbiddenModal" class="fullscreen container-fluid">
		<div class="row fullscreen-container">
			<div class="row p-3 m-0">
				<div class="col-10">
					<h5 class="modal-title">금지어 관리</h5>
				</div>
				<div class="col-2 d-flex justify-content-center align-items-center">
					<button type="button" class="btn-close" @click="hideForbiddenModal">
					<span aria-hidden="true"></span>
					</button>
				</div>
			</div>
			<hr>
			<div class="row m-0 p-0 mb-2">
				<div class="col-3 d-flex align-items-center justify-content-center">
					<div class="row">
						<div class="col">
							<div class="row m-0 p-0">
								<div class="col d-flex justify-content-center align-items-center" @click="moveScroll('a')" style="cursor:pointer; padding:0.4em">
									a-z
								</div>
							</div> 
							<div class="row m-0 p-0">
								<div class="col d-flex justify-content-center align-items-center" @click="moveScroll('ㄱ')" style="cursor:pointer; padding:0.4em">
									ㄱ-ㅎ
								</div>
							</div> 
							<div class="row m-0 p-0" v-for="(word, index) in dictionary" :key="index">
								<div class="col d-flex justify-content-center align-items-center" @click="moveScroll(word)" style="cursor:pointer; padding:0.4em">
									{{word}}
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-9 p-0">
					<div class="card bg-light" style="border:0px solid white">
						<div class="card-body card-scroll" ref="scrollContainer" style="height:600px; background-color:white;">
							<div class="row" v-for="(forbidden, index) in forbiddenList" :key="index" ref="scrollItems">
								<div class="offset-2 col-6 d-flex align-items-center p-2">
									{{forbidden}}
								</div>
								<div class="col-1 d-flex align-items-center justify-content-center p-2">
									<i class="fa-solid fa-xmark modal-click-btn-negative" @click="deleteForbiddenWord(forbidden)"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<hr class="mt-2">
			<div class="row m-0 p-0 mt-2 mb-3 ">
				<div class="col">
					<div class="row">
						<div class="col">
							<input class="form-control" placeholder="금지어 입력" type="text" v-model="forbiddenWord" @input="forbiddenWord=$event.target.value" @keyup.enter="addForbiddenWord">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col d-flex justify-content-end">
							<button type="button" class="btn btn-primary m-0 w-25" @click="addForbiddenWord">입력</button>
							<button type="button" class="btn btn-secondary m-0 w-25" @click="hideForbiddenModal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------금지어 관리 모달 끝-------------------------- -->
	<!-- ---------------------------------신고받은 게시물 미리보기 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="reportedBoardModal" style="z-index:2000">
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">신고받은 게시물 리스트</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideReportedBoardModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom" v-if="reportDetailData.reportTable=='member'">
					<div class="row d-flex justify-content-center">
						<div class="box w-25" v-for="(board, index) in reportDetailContent.boardList" :key="board.boardWithNickDto.boardNo" @click="clickReportedBoardDetailModal(index)">
							<video class="content" :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" v-if="board.boardAttachmentList.length>0 && board.boardAttachmentList[0].video"
									style="object-fit:cover" muted controls></video>
							<img class='content' v-if="board.boardAttachmentList.length>0 && !board.boardAttachmentList[0].video" :src="'${pageContext.request.contextPath}'+board.boardAttachmentList[0].imageURL" >
							<div class="content-box"></div>
							<i class="fa-regular fa-copy pages" v-if="board.boardAttachmentList.length>1"></i>
						</div>
					</div>
					<div class="row" v-if="reportDetailContent.boardList.length==0">
						<div class="col d-flex justify-content-center align-items-center">
							<h4>신고받은 게시물 없음</h4>
						</div>
					</div>
				</div>
				<div class="row modal-footer-custom">
					<button type="button" class="btn btn-secondary" @click="hideReportedBoardModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고받은 게시물 미리보기 모달 끝-------------------------- -->
	<!-- ---------------------------------신고받은 댓글 미리보기 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="reportedReplyModal" >
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">신고받은 댓글 리스트</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideReportedReplyModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom" v-if="reportDetailData.reportTable=='member'">
					<div class="row mb-2" v-for="(reply, index) in reportDetailContent.replyList" :key="index">
						<div class="row">
							<div class="col-6 p-2 ps-3">
								{{reply.replyContent}}({{reply.replyReport}}건)
							</div>
							<div class="col-3 p-2" d-flex justify-content-end>
								{{reply.boardTime}}
							</div>
							<div class="col-3 p-2 modal-click-btn d-flex justify-content-end" @click="clickReportedReplyDetailModal(reply.replyNo, index)">
								댓글전체
							</div>
						</div>
					</div>
					<div class="row" v-if="reportDetailContent.replyList.length==0">
						<div class="col d-flex justify-content-center align-items-center">
							<h4>신고받은 댓글 없음</h4>
						</div>
					</div>
				</div>
				<div class="row modal-footer-custom">
					<button type="button" class="btn btn-secondary" @click="hideReportedReplyModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고받은 댓글 미리보기 모달 끝-------------------------- -->
	<!-- ---------------------------------신고받은 댓글 정보보기 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="reportedReplyDetailModal">
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">댓글 정보보기</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideReportedReplyDetailModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom" v-if="reportedReplyDetailList.length>0">
					<div class="row p-2">
						<div class="col">
							<div class="row mb-2">
								<div class="col" style="font-weight:bold">
									댓글 내용
								</div>
							</div>
							<div class="row">
								<div class="col ps-4">
									{{reportedReplyDetailList[reportedReplyDetailIndex].replyContent}}
								</div>
							</div>
							<div class="row mb-2 mt-3">
								<div class="col" style="font-weight:bold">
									전체 댓글 내용
								</div>
							</div>
							<div class="row mb-2" v-for="(reply, index) in reportedReplyDetailList" :key="index">
								<div class="col-1" v-if="reply.replyParent!=0">
								</div>
								<div class="col">
									<div class="row">
										<div class="col ps-3">	
											{{reply.memberNick}}
											<i class="ms-2" style="color:#d9534f; font-weight:bold" v-if="reply.memberNick==reportDetailData.memberNick">(신고대상자)</i>
										</div>
									</div>
									<div class="row">
										<div class="col ps-4">
											: {{reply.replyContent}}
											<i class="ms-2" style="color:#d9534f; font-weight:bold" v-if="index==reportedReplyDetailIndex">(신고내용)</i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row modal-footer-custom">
					<button type="button" class="btn btn-secondary" @click="hideReportedReplyDetailModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고받은 댓글 정보보기 모달 끝-------------------------- -->
	<!-- ---------------------------------신고받은 게시물 미리보기 상세보기 모달-------------------------- -->
	<div class="fullscreen container-fluid" tabindex="-1" v-if="reportedBoardDetailModal" style="z-index:3000">
		<div class="row fullscreen-container">
			<div class="modal-content-custom">
				<div class="row modal-header-custom">
					<div class="col-10">
						<h5 class="modal-title">게시물 미리보기</h5>
					</div>
					<div class="col-2 d-flex justify-content-end align-items-center">
						<button type="button" class="btn-close" @click="hideReportedBoardDetailModal" aria-label="Close">
						<span aria-hidden="true"></span>
						</button>
					</div>
				</div>
				<div class="row modal-body-custom">
					<div class="row"  style="cursor:pointer" @click="moveToMemberDetail(boardViewContent.boardWithNickDto.memberNick)">
						<div class="col-3 d-flex justify-content-end align-items-center">
							<img class="rounded-circle" width="50" height="50" :src="'${pageContext.request.contextPath}'+boardViewContent.boardWithNickDto.imageURL">
						</div>
						<div class="col-9 d-flex align-items-center">
							<div class="ms-2" style="font-weight:bold; font-size:1.2em">{{boardViewContent.boardWithNickDto.memberNick}}</div>
						</div>
					</div>
					<div class="row p-2">
						<div class="col">
							<div class="row">
								<div class="col-12" v-for="(image, index) in boardViewContent.boardAttachmentList" style="position:relative">
									<video class="w-100" :src="'${pageContext.request.contextPath}'+image.imageURL" v-if="image.video"
											muted controls></video>
									<img v-else style="height:auto; display:block" class="w-100" :src="'${pageContext.request.contextPath}'+image.imageURL">
								</div>
							</div>
							<div class="row mt-2">
								<div class="col-2 text-center">
									내용
								</div>
								<div class="col">
									{{boardViewContent.boardWithNickDto.boardContent}}
								</div>
							</div>
							<div class="row">
								<div class="col-2 text-center">
									태그
								</div>
								<div class="col">
									<span v-for="(tag,index) in boardViewContent.boardTagList" :key="index">\#{{tag.tagName}}&nbsp</span>
								</div>
							</div>
							<div class="row mt-3">
								<div class="col">
									<button class="btn btn-danger w-100" type="button" @click="boardDelete(boardViewContent.boardWithNickDto.boardNo)">게시물 삭제</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row modal-footer-custom">
					<button type="button" class="btn btn-secondary" @click="hideReportedBoardDetailModal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- ---------------------------------신고받은 게시물 미리보기 모달 끝-------------------------- -->
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
	let searchTagChart;
	let searchNickChart;
	Vue.createApp({
		data() {
			return {
				end:10,
				begin:1,
				adminMenu:1,
				modal:"",
				memberList:[],
				memberSearchOption:{
					memberName:"", memberEmail:"", memberNick:"", searchLoginDays:"", memberAddress:"",	memberLevel:"",
					memberGender:"", memberMinReport:"", memberMaxReport:"", memberBeginBirth:"", memberEndBirth:"",memberMinFollow:"",
					memberMaxFollow:"",	orderListString:"", memberSuspensionStatus:"", page:1,
				},
				memberOrderList:["","",""],
				memberSearchPagination:{
					begin:"", end:"", totalPage:"",	startBlock:"", finishBlock:"", first:false, last:false, prev:false,
					next:false, nextPage:"", prevPage:"",
				},
				/* --------------------------------게시물 데이터-------------------------------- */
				boardList:[],
				tagList:[],
				boardSearchOption:{
					memberNick:"", boardTimeBegin:"", boardTimeEnd:"", boardMinReport:"", boardMaxReport:"",
					boardMinLike:"", boardMaxLike:"", boardHide:"",	orderListString:"", page:1,
					tagPage:1, tagOrderListString:"", tagMinFollow:"", tagMaxFollow:"", tagAvailable:"", tagMinCount:"", tagMaxCount:"",
					boardContent:"", boardContentProhibit:"", tag:""
				},
				boardOrderList:["","",""],
				tagOrderList:["",""],
				boardSearchPagination:{
					begin:"", end:"", totalPage:"",	startBlock:"", finishBlock:"", first:false, last:false, prev:false,
					next:false, nextPage:"", prevPage:"",
				},
				tagSearchPagination:{
					begin:"", end:"", totalPage:"",	startBlock:"", finishBlock:"", first:false, last:false, prev:false,
					next:false, nextPage:"", prevPage:"",
				},
				boardViewModal:false,
				boardViewModalIndex:"",
				boardViewNo:"",
				boardViewContent:{},
				forbiddenModal:false,
				forbiddenList:[],
				forbiddenWord:"",
				forbiddenListCopy:[],
				dictionary:['가','나','다','라','마','바','사','아','자','차','카','타','파','하'],
				/*---------------------------신고 데이터 --------------------------- */
				reportContentModal:false,
				newReportContent:"",
				reportContentList:[],
				reportContentListSub:[],
				reportContentListEdit:[],
				reportList:[],
				reportListBefore:[],
				reportSocket:null,
				reportSearchOption:{
					page:1, reportTable:"", reportMinCount:"", reportMaxCount:"", memberNick:"", memberName:"", reportResult:"", order:"",
					memberNo:memberNo, reportMinManagedCount:"", reportMaxManagedCount:"",suspension:"",
				},
				reportSearchPagination:{
					begin:"", end:"", totalPage:"",	startBlock:"", finishBlock:"", first:false, last:false, prev:false,
					next:false, nextPage:"", prevPage:"",
				},
				reportDifference:[],
				reportDetailModal:false,
				/* 리포트 현황 클릭할 경우 리스트에서 반환받는 단일 객체 */
				reportDetailData:{},
				/* detailData로부터 상세보기를 보기 위해 필요한 정보를 반환받는 객체 */
				reportDetailContent:{},
				/* 리포트 현황 반환 배열 */
				reportDetailCountList:[],
				/* 리포트 내용보기 중 댓글 신고보기 시 자기거 기록하는 인덱스 */
				reportDetailContentIndex:"",
				/* 리포트 내용보기 항목 인덱스 */
				reportDetailIndex:"",
				reportedBoardModal:false,
				reportedReplyModal:false,
				reportedReplyDetailModal:false,
				reportedBoardDetailModal:false,
				reportedReplyDetailList:[],
				//회원에서 댓글신고에서 게시글 댓글내용 들어갔을 대 자기꺼 기록하는 인덱스
				reportedReplyDetailIndex:"",
				//showModal 시 반환받는 데이터
				reportedReplyDetailModalReportNo:"",
				reportedReplyDetailModalIndex:"",
				reportedBoardDetailModalIndex:"",
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
				/*---------------------------검색 통계 데이터 --------------------------- */
				searchStatsSearch:{
					tagPage:1,
					nickPage:1,
					memberGender:"",
					memberBeginBirth:"",
					memberEndBirth:"",
					searchBeginDate:"",
					searchEndDate:"",
				},
				searchTagList:{
					name:[],
					count:[],
				},
				searchNickList:{
					name:[],
					count:[],
				},
				searchTagChartRight:true,
				searchNickChartRight:true,
				/*---------------------------정지 데이터 --------------------------- */
				suspensionModal:false,
				suspensionIndex:[],
				suspensionContent:["",""],
				suspensionModalIndex:"",
				suspensionModalStatus:"",
				suspensionModalIndex:"",
				suspensionModalStatus:"",
				reportSuspensionModalIndex:"",
				reportSuspensionModalStatus:"",
				reportSuspensionModal:false,
				reportSuspensionIndex:[],
				reportSuspensionContent:["",""],
			};
		},
		computed: {
			//계산영역
			tagFirstHalfList(){
				return this.tagList.slice(0, Math.ceil(this.tagList.length/2));
			},
			tagSecondHalfList(){
				return this.tagList.slice(Math.ceil(this.tagList.length/2));
			},
		},
		methods: {
			//메소드영역
			/*------------------------------ 메뉴바 시작 ------------------------------*/
			//쿼리값 page로 반환
			initializePageFromQuery() {
				const queryParams = new URLSearchParams(window.location.search);
				const adminMenu = queryParams.get('adminMenu');
				const modal = queryParams.get('modal');
				if(this.adminMenu!=adminMenu){
					this.adminMenu = adminMenu;
				}
				if(this.modal!=modal){
					this.modal=modal;
				}
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
			changeModal(modal, noHistory){
				if(this.modal==modal) return;
				this.modal=modal;
				const queryParams = new URLSearchParams(window.location.search);
				//queryParams.set('adminMenu', this.adminMenu);
				queryParams.set('modal', this.modal);
				const newURL = `?`+queryParams.toString();
				//쿼리 히스토리 저장
				if(!noHistory){					
					window.history.pushState({ query: queryParams.toString() }, '', newURL);
				}
			},
			hideAllModal(){
				if(this.boardViewModal){
					this.hideBoardViewModal();
				}
				if(this.forbiddenModal){
					this.hideForbiddenModal();
				}
				if(this.reportContentModal){
					this.hideReportContentModal();
				}
				if(this.reportedBoardModal){
					this.hideReportedBoardModal();
				}
				if(this.reportedReplyModal){
					this.hideReportedReplyModal();
				}
				if(this.reportedReplyDetailModal){
					this.reportedReplyDetailModal=false;
					document.body.style.overflow = "unset";
				}
				if(this.reportedBoardDetailModal){
					this.reportedBoardDetailModal=false;
					document.body.style.overflow = "unset";
				}
				if(this.suspensionModal){
					this.hideSuspensionModal();
				}
				if(this.reportSuspensionModal){
					this.hideReportSuspensionModal();
				}
				if(this.reportDetailModal){
					this.hideReportDetailModal();
				}
			},
			/*------------------------------ 메뉴바 끝 ------------------------------*/
			moveToMemberDetail(searchMemberNick){
				window.location.href=contextPath+"/member/"+searchMemberNick;
			},
			moveToTagDetail(searchTagName){
				window.location.href=contextPath+"/tag/"+searchTagName;
			},
			/*------------------------------ 회원관리 시작 ------------------------------*/
			//회원 리스트 출력
			async loadMemberList(){
				const resp = await axios.get(contextPath+"/rest/admin/member/list", {params:this.memberSearchOption});
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
				this.memberSearchOption.orderListString="";
				this.memberSearchOption.memberSuspensionStatus="";
			},
			//회원 검색 버튼 클릭시
			async getListWithSearchOption(){
				this.memberSearchOption.page=1;
				const resp = await axios.get(contextPath+"/rest/admin/member/list", {params:this.memberSearchOption});
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
				this.memberSearchOption.orderListString=orderListParams;
			},
			/*------------------------------ 회원관리 끝 ------------------------------*/
			/*------------------------------ 게시물관리 시작 ------------------------------*/
			async loadBoardList(){
				const resp = await axios.get(contextPath+"/rest/admin/board/list", {params:this.boardSearchOption});
				this.boardList=[...resp.data.boardList];
				this.boardSearchPagination=resp.data.paginationVO;
			},
			//페이지네이션 처음, 이전, 다음 끝 버튼 누를 때
			boardFirstPage(){
				if(!this.boardSearchPagination.first) this.boardSearchOption.page=1;
			},
			boardPrevPage(){
				if(this.boardSearchPagination.prev) this.boardSearchOption.page=this.boardSearchPagination.prevPage;
			},
			boardNextPage(){
				if(this.boardSearchPagination.next) this.boardSearchOption.page=this.boardSearchPagination.nextPage;
			},
			boardLastPage(){
				if(!this.boardSearchPagination.last) this.boardSearchOption.page=this.boardSearchPagination.totalPage;
			},
			makeQueryForBoardOrderList(){
				const orderListParams = this.boardOrderList.join(',');
				this.boardSearchOption.orderListString=orderListParams;
			},
			//회원 리스트 초기화 버튼 클릭시
			resetBoardSearchOption(){
				this.boardSearchOption.memberNick="";
				this.boardSearchOption.boardTimeBegin="";
				this.boardSearchOption.boardTimeEnd="";
				this.boardSearchOption.boardMinReport="";
				this.boardSearchOption.boardMaxReport="";
				this.boardSearchOption.boardMinLike="";
				this.boardSearchOption.boardMaxLike="";
				this.boardSearchOption.boardHide="";
				this.boardOrderList=["","",""];
				this.boardSearchOption.orderListString="";
				this.boardSearchOption.boardContent="";
				this.boardSearchOption.boardContentProhibit="";
				this.boardSearchOption.tag="";
			},
			//회원 검색 버튼 클릭시
			async getBoardListWithSearchOption(){
				this.boardSearchOption.page=1;
				const resp = await axios.get(contextPath+"/rest/admin/board/list", {params:this.boardSearchOption});
				this.boardList=[...resp.data.boardList];
				this.boardSearchPagination=resp.data.paginationVO;
			},
			/*--- 태그리스트 ---*/
			async loadTagList(){
				const resp = await axios.get(contextPath+"/rest/admin/tag/list", {params:this.boardSearchOption});
				this.tagList=[...resp.data.tagList];
				this.tagSearchPagination=resp.data.paginationVO;
			},
			//페이지네이션 처음, 이전, 다음 끝 버튼 누를 때
			tagFirstPage(){
				if(!this.tagSearchPagination.first) this.boardSearchOption.tagPage=1;
			},
			tagPrevPage(){
				if(this.tagSearchPagination.prev) this.boardSearchOption.tagPage=this.tagSearchPagination.prevPage;
			},
			tagNextPage(){
				if(this.tagSearchPagination.next) this.boardSearchOption.tagPage=this.tagSearchPagination.nextPage;
			},
			tagLastPage(){
				if(!this.tagSearchPagination.last) this.boardSearchOption.tagPage=this.tagSearchPagination.totalPage;
			},
			makeQueryForTagOrderList(){
				const orderListParams = this.tagOrderList.join(',');
				this.boardSearchOption.tagOrderListString=orderListParams;
			},
			//회원 리스트 초기화 버튼 클릭시
			resetTagSearchOption(){
				this.boardSearchOption.tagMinFollow="";
				this.boardSearchOption.tagMaxFollow="";
				this.boardSearchOption.tagAvailable="";
				this.boardSearchOption.tagMinCount="";
				this.boardSearchOption.tagMaxCount="";
				this.tagOrderList=["",""];
				this.boardSearchOption.tagOrderListString="";
			},
			//회원 검색 버튼 클릭시
			async getTagListWithSearchOption(){
				this.boardSearchOption.tagPage=1;
				const resp = await axios.get(contextPath+"/rest/admin/tag/list", {params:this.boardSearchOption});
				this.tagList=[...resp.data.tagList];
				this.tagSearchPagination=resp.data.paginationVO;
			},
			async changeTagAvailable(tagName, index){
				const data={tagName:tagName}
				const resp = await axios.put(contextPath+"/rest/tag/", data)
				this.tagList[index].tagAvailable=resp.data;
			},
			clickBoardViewModal(index){
				this.boardViewModalIndex=index;
				this.changeModal('boardViewModal');
				this.showBoardViewModal();
			},
 			showBoardViewModal(){
				this.boardViewNo=this.boardList[this.boardViewModalIndex].boardWithNickDto.boardNo;
				this.boardViewContent=this.boardList[this.boardViewModalIndex];
				this.boardViewModal=true;
				document.body.style.overflow = "hidden";
			},
			hideBoardViewModal(){
		        document.body.style.overflow = "unset";
				this.boardViewModal=false;
				this.changeModal("");
			},
			/* 금지어 메서드 */
			clickForbiddenModal(){
				this.changeModal('forbiddenModal');
				this.showForbiddenModal();
			},
 			showForbiddenModal(){
				this.forbiddenModal=true;
				this.loadForbiddenList();
	        	document.body.style.overflow = "hidden";
			},
			hideForbiddenModal(){
				this.forbiddenModal=false;
	        	document.body.style.overflow = "unset";
	        	this.changeModal("");
			},
			async loadForbiddenList(){
				const resp = await axios.get("/rest/admin/forbidden");
				this.forbiddenList = [...resp.data];
			},
			async searchForbiddenList(){
				const resp = await axios.get("/rest/admin/forbidden?forbiddenWord="+this.forbiddenWord);
				this.forbiddenList=[...resp.data];
			},
			async addForbiddenWord(){
				const resp = await axios.post("/rest/admin/forbidden", {forbiddenWord:this.forbiddenWord});
				this.forbiddenWord="";
				this.loadForbiddenList();
			},
			async deleteForbiddenWord(forbiddenWord){
				const resp = await axios.delete("/rest/admin/forbidden?forbiddenWord="+forbiddenWord);
				this.loadForbiddenList();
			},
			moveScroll(word){
				this.forbiddenListCopy = _.cloneDeep(this.forbiddenList);
				this.forbiddenListCopy.push(word);
				this.forbiddenListCopy.sort();
				const index = this.forbiddenListCopy.indexOf(word);
				const scrollItems = this.$refs.scrollItems;
				if (index>=0) {
					scrollItems[index].scrollIntoView();
				}
			},
			/*------------------------------ 게시물관리 끝 ------------------------------*/
			/*------------------------------ 신고관리 시작 ------------------------------*/
			clickReportContentModal(){
				this.changeModal('reportContentModal');
			},
 			showReportContentModal(){
				this.reportContentModal=true;
				this.loadReportContent();
				document.body.style.overflow = "hidden";
			},
			hideReportContentModal(){
				this.reportContentModal=false;
				document.body.style.overflow = "unset";
				this.changeModal("");
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
					reportListContentAfter:this.reportContentListSub[index].reportListContent,
					reportListContentBefore:this.reportContentList[index].reportListContent,
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
				const resp = await axios.get(contextPath+"/rest/report/", {params:this.reportSearchOption});
				this.reportListBefore=[...resp.data.reportList];
				this.reportSearchPagination=resp.data.paginationVO;
				this.reportList=_.cloneDeep(this.reportListBefore);
			},
 			connectReportServer(){
				const url = contextPath+"/ws/admin/report";
				this.socket = new SockJS(url);
				
				this.socket.onopen = ()=>{
					const joinData = {memberNo:memberNo, data:1}
					this.socket.send(JSON.stringify(joinData))
				};
				this.socket.onclose= ()=>{
					console.log("연결종료")
				};
				this.socket.onerror= ()=>{
					console.log("연결종료")
				};
				//메세지를 수신하면 수신된 메세지로 태그를 만들어서 추가
				this.socket.onmessage=(e)=>{
					const data = JSON.parse(e.data);
					if(data.data==1){
						this.socket.send(JSON.stringify(this.reportSearchOption));
					}
					else{
						this.reportListBefore = _.cloneDeep(this.reportList);
						
						this.reportList = [...data.reportList];
						this.reportPagination=[data.paginationVO];
					}
				};
			},
			//신고 검색 버튼 클릭시
			async getReportListWithSearchOption(){
				this.reportSearchOption.page=1;
				const resp = await axios.get(contextPath+"/rest/report/", {params:this.reportSearchOption});
				this.reportListBefore=[...resp.data.reportList];
				this.reportSearchPagination=resp.data.paginationVO;
				this.reportList=_.cloneDeep(this.reportListBefore);
			},
			//페이지네이션 처음, 이전, 다음 끝 버튼 누를 때
			reportFirstPage(){
				if(!this.reportSearchPagination.first) this.reportSearchOption.page=1;
			},
			reportPrevPage(){
				if(this.reportSearchPagination.prev) this.reportSearchOption.page=this.reportSearchPagination.prevPage;
			},
			reportNextPage(){
				if(this.reportSearchPagination.next) this.reportSearchOption.page=this.reportSearchPagination.nextPage;
			},
			reportLastPage(){
				if(!this.reportSearchPagination.last) this.reportSearchOption.page=this.reportSearchPagination.totalPage;
			},
			//리포트 리스트 초기화 버튼 클릭시
			resetReportSearchOption(){
				this.reportSearchOption.memberName="";
				this.reportSearchOption.memberNick="";
				this.reportSearchOption.reportTable="";
				this.reportSearchOption.suspension="";
				this.reportSearchOption.reportMinCount="";
				this.reportSearchOption.reportMaxCount="";
				this.reportSearchOption.reportMinManagedCount="";
				this.reportSearchOption.reportMaxManagedCount="";
				this.reportSearchOption.reportResult="";
				this.reportSearchOption.order="";
			},
			//리포트리스트, 비포 객체 배열 비교 함수
			compareReport (obj1, obj2){
				return obj1.reportTableNo==obj2.reportTableNo && obj1.reportTable==obj2.reportTable && obj1.reportMemberNo==obj2.reportMemberNo;
			},
			/*------------------------------ 신고관리 끝 ------------------------------*/
			/*------------------------------ 멤버통계 시작 ------------------------------*/
			async getMemberLoginStats(buttonClick){
				if(buttonClick){
					this.memberLoginSearch.page=1;
				}
				const resp = await axios.post(contextPath+"/rest/admin/stats/member", this.memberLoginSearch)
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
				const resp = await axios.post(contextPath+"/rest/admin/stats/member/", this.memberJoinSearch);
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
				const resp = await axios.post(contextPath+"/rest/admin/stats/cumulative/", this.memberCumulativeSearch);
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
				const resp = await axios.post(contextPath+"/rest/admin/stats/boardTime", this.boardTimeSearch)
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
				const resp = await axios.post(contextPath+"/rest/admin/stats/boardTag", this.boardTagSearch)
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
								label: "개수",
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
		/*------------------------------ 게시물통계 끝 ------------------------------*/
		/*------------------------------ 검색통계 시작 ------------------------------*/
			async getSearchNickStats(buttonClick){
				if(buttonClick){
					this.searchStatsSearch.nickPage=1;
				}
				const resp = await axios.post(contextPath+"/rest/admin/stats/searchNick", this.searchStatsSearch)
				this.searchNickChartRight=true;
				if(resp.data.length<15){
					this.searchNickChartRight=false;
				}
				this.searchNickList.name = _.map(resp.data, 'name');
				this.searchNickList.count = _.map(resp.data, 'count');
				//캔버스 사용 초기화
				if(searchNickChart!=null) {
					searchNickChart.destroy();
				}
				searchNickChart = this.$refs.searchNickChart;
				
				searchNickChart = new Chart(searchNickChart, {
					type: "bar",
					data: {
						labels: this.searchNickList.name,
						datasets: [
							{
								label: "건",
								data: this.searchNickList.count,
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
			async getSearchTagStats(buttonClick){
				if(buttonClick){
					this.searchStatsSearch.tagPage=1;
					this.searchStatsSearch.nickPage=1;
					this.getSearchNickStats();
				}
				const resp = await axios.post(contextPath+"/rest/admin/stats/searchTag", this.searchStatsSearch)
				this.searchTagChartRight=true;
				if(resp.data.length<15){
					this.searchTagChartRight=false;
				}
				this.searchTagList.name = _.map(resp.data, 'name');
				this.searchTagList.count = _.map(resp.data, 'count');
				//캔버스 사용 초기화
				if(searchTagChart!=null) {
					searchTagChart.destroy();
				}
				searchTagChart = this.$refs.searchTagChart;
				
				searchTagChart = new Chart(searchTagChart, {
					type: "bar",
					data: {
						labels: this.searchTagList.name,
						datasets: [
							{
								label: "건",
								data: this.searchTagList.count,
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
			searchTagStatsPrev(){
				this.searchStatsSearch.tagPage--;
				this.getSearchTagStats();
			},
			searchTagStatsNext(){
				this.searchStatsSearch.tagPage++;
				this.getSearchTagStats();
			},
			searchNickStatsPrev(){
				this.searchStatsSearch.nickPage--;
				this.getSearchNickStats();
			},
			searchNickStatsNext(){
				this.searchStatsSearch.nickPage++;
				this.getSearchNickStats();
			},
		/*------------------------------ 검색통계 끝 ------------------------------*/
		/*------------------------------ 정지모달 시작 ------------------------------*/
			clickSuspensionModal(index, status){
				this.suspensionModalIndex=index;
				this.suspensionModalStatus=status;
				this.changeModal('suspensionModal');
				this.showSuspensionModal();
			},
 			showSuspensionModal(){
				this.suspensionModal=true;
				this.suspensionIndex=[this.suspensionModalIndex, this.suspensionModalStatus];
				document.body.style.overflow = "hidden";
			},
			hideSuspensionModal(){
				this.suspensionModal=false;
				this.suspensionIndex=[];
				this.suspensionContent=["",""];
				document.body.style.overflow = "unset";
				this.changeModal("");
			},
			async insertSuspension(days, contents){
				let data={
					memberNo:this.memberList[this.suspensionIndex[0]].memberNo,
					memberSuspensionDays:this.suspensionContent[0],
					memberSuspensionContent:this.suspensionContent[1]
				};
				const resp = await axios.post(contextPath+"/rest/suspension/", data);
				this.memberList[this.suspensionIndex[0]]=resp.data;
				this.hideSuspensionModal();
			},
			async deleteSuspension(){
				let data={
						memberNo:this.memberList[this.suspensionIndex[0]].memberNo,
				}
				const resp = await axios.put(contextPath+"/rest/suspension/", data);
				this.memberList[this.suspensionIndex[0]]=resp.data;
				this.hideSuspensionModal();
			},
			clickReportSuspensionModal(index, status){
				this.reportSuspensionModalIndex=index;
				this.reportSuspensionModalStatus=status;
				this.changeModal('reportSuspensionModal');
				this.showReportSuspensionModal();
			},
 			showReportSuspensionModal(){
				this.reportSuspensionModal=true;
				this.reportSuspensionIndex=[this.reportSuspensionModalIndex, this.reportSuspensionModalStatus];
				document.body.style.overflow = "hidden";
			},
			hideReportSuspensionModal(){
				this.reportSuspensionModal=false;
				this.reportSuspensionIndex=[];
				this.reportSuspensionContent=["",""];
				document.body.style.overflow = "unset";
				this.changeModal("");
			},
			async insertReportSuspension(days, contents){
				console.log("실행")
				let data={
					memberNo:this.reportList[this.reportSuspensionIndex[0]].reportMemberNo,
					memberSuspensionDays:this.reportSuspensionContent[0],
					memberSuspensionContent:this.reportSuspensionContent[1]
				};
				const resp = await axios.post(contextPath+"/rest/suspension/", data);
				this.loadReportList();
				this.hideReportSuspensionModal();
			},
			async deleteReportSuspension(){
				let data={
						memberNo:this.reportList[this.reportSuspensionIndex[0]].reportMemberNo,
				}
				const resp = await axios.put(contextPath+"/rest/suspension/", data);
				this.loadReportList();
				this.hideReportSuspensionModal();
			},
		/*------------------------------ 정지모달 끝 ------------------------------*/
		/*------------------------------ 신고 세부 모달 시작 ------------------------------*/
			clickReportDetailModal(index){
				this.reportDetailIndex=index;
				this.changeModal('reportDetailModal');
				this.showReportDetailModal();
			},
 			showReportDetailModal(){
				this.reportDetailData=this.reportList[this.reportDetailIndex];
				this.loadDetailCount();
				this.reportDetailModal=true;
				document.body.style.overflow = "hidden";
			},
			hideReportDetailModal(){
				this.reportDetailModal=false;
				document.body.style.overflow = "unset";
				this.changeModal("");
			},
			async loadDetailCount(){
				const resp = await axios.get(contextPath+"/rest/report/detail?reportTable="+this.reportDetailData.reportTable+
						"&reportTableNo="+this.reportDetailData.reportTableNo+"&memberNo="+this.reportDetailData.reportMemberNo);
				this.reportDetailCountList = [...resp.data.reportDetailCountVO];
				//게시글 신고일 경우
				if(this.reportDetailData.reportTable=='board'){
					this.reportDetailContent=resp.data.boardListVO;
				}
				//댓글 신고일 경우
				else if(this.reportDetailData.reportTable=='reply'){
					this.reportDetailContent=[...resp.data.replyList];
					this.reportDetailContentIndex=this.reportDetailContent.findIndex(content=>content.replyNo==this.reportDetailData.reportTableNo);
				}
				//멤버 신고일 경우
				else{
					this.reportDetailContent=resp.data.memberVO;
				}
			},
			//게시물 관리에서 삭제 기능
			async boardDelete(boardNo){
				const data={reportTableNo:boardNo, reportTable:'board', reportResult:2};
				const resp = await axios.delete(contextPath+"/rest/admin/board", data);
				this.reportDetailData.reportResult=2;
				this.hideBoardViewModal();
				this.loadBoardList();
			},
			//신고관리에서 관리처리, 신고수 초기화 및 게시물 삭제
			async reportManage(reportResult){
				const data={reportTableNo:this.reportDetailData.reportTableNo, reportTable:this.reportDetailData.reportTable, reportResult:reportResult};
				const resp = await axios.put(contextPath+"/rest/admin/reportManage", data);
				this.loadReportList();
				this.hideReportDetailModal();
			},
			clickReportedBoardModal(){
				//this.changeModal('reportedBoardModal');
				this.showReportedBoardModal();
			},
 			showReportedBoardModal(){
				this.reportedBoardModal=true;
				//this.hideReportDetailModal();
				this.reportDetailModal=false;
				document.body.style.overflow = "hidden";
			},
			hideReportedBoardModal(){
				this.reportedBoardModal=false;
				//this.clickReportDetailModal(this.reportDetailIndex);
				this.reportDetailModal=true;
				document.body.style.overflow = "hidden";
				//this.changeModal("");
			},
			clickReportedReplyModal(){
				//this.changeModal('reportedReplyModal');
				this.showReportedReplyModal();
			},
 			showReportedReplyModal(){
				this.reportedReplyModal=true;
				//this.hideReportDetailModal();
				this.reportDetailModal=false;
				document.body.style.overflow = "hidden";
			},
			hideReportedReplyModal(){
				this.reportedReplyModal=false;
				//this.showReportDetailModal(this.reportDetailIndex);
				this.reportDetailModal=true;
				document.body.style.overflow = "hidden";
				//this.changeModal("");
			},
			clickReportedReplyDetailModal(reportNo, index){
				this.reportedReplyDetailModalReportNo=reportNo;
				this.reportedReplyDetailModalIndex=index;
				//this.changeModal('reportedReplyDetailModal');
				this.showReportedReplyDetailModal();
			},
 			async showReportedReplyDetailModal(){
				const resp = await axios.get(contextPath+"/rest/report/detail/"+this.reportedReplyDetailModalReportNo);
				this.reportedReplyDetailList=[...resp.data];
				this.reportedReplyDetailIndex=this.reportedReplyDetailList.findIndex(content=>content.replyNo==this.reportDetailContent.replyList[this.reportedReplyDetailModalIndex].replyNo);
				this.reportedReplyDetailModal=true;
				this.reportedReplyModal=false;
				document.body.style.overflow = "hidden";
			},
			hideReportedReplyDetailModal(){
				this.reportedReplyDetailModal=false;
				this.reportedReplyModal=true;
				document.body.style.overflow = "hidden";
				//this.changeModal("");
			},
			clickReportedBoardDetailModal(index){
				this.reportedBoardDetailModalIndex=index;
				//this.changeModal('reportedBoardDetailModal');
				this.showReportedBoardDetailModal();
			},
 			showReportedBoardDetailModal(){
				this.boardViewNo=this.reportDetailContent.boardList[this.reportedBoardDetailModalIndex].boardWithNickDto.boardNo;
				this.boardViewContent=this.reportDetailContent.boardList[this.reportedBoardDetailModalIndex];
				this.reportedBoardDetailModal=true;
				this.reportedBoardModal=false;
				document.body.style.overflow = "hidden";
			},
			hideReportedBoardDetailModal(){
				this.reportedBoardDetailModal=false;
				this.reportedBoardModal=true;
				document.body.style.overflow = "hidden";
				//this.changeModal("");
			},
		/*------------------------------ 신고 세부 모달 끝 ------------------------------*/
		},
		created(){
			//데이터 불러오는 영역
			this.loadMemberList();
			this.loadReportContent();
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
			"boardSearchOption.page":function(newVal, oldVal){
				this.loadBoardList();
			},
			boardOrderList:{
				deep:true,
				handler(newVal, oldVal) {
					this.makeQueryForBoardOrderList();
				}
			},
			"boardSearchOption.tagPage":function(newVal, oldVal){
				this.loadTagList();
			},
			tagOrderList:{
				deep:true,
				handler(newVal, oldVal) {
					this.makeQueryForTagOrderList();
				}
			},
			"reportSearchOption.page":function(newVal, oldVal){
				this.loadReportList();
			},
			reportList:{
				deep:true,
				handler(){
					this.reportDifference=this.reportList.map((obj1, indexAfter)=>{
						const indexBefore  = this.reportListBefore.findIndex(obj => this.compareReport(obj1, obj));
						const obj2 = this.reportListBefore[indexBefore];
						//index에 올라가는 등수 반환 커졌으면(순위가 올라가면) +, 작아졌으면(순위가 내려가면) -
						if(obj2!=undefined){
							return {count:obj1.count != obj2.count, index:indexBefore-indexAfter};
						}
						else{
							return{count:false, index:16};
						}
					})
				}
			},
			adminMenu(){
				this.changeModal("", true);
				if(this.adminMenu==1){
					//회원관리
					this.loadMemberList();
					this.loadReportContent();
				}
				else if(this.adminMenu==2){
					//게시물 관리
					this.loadBoardList();
					this.loadTagList();
				}
				else if(this.adminMenu==3){
					//신고 관리
					this.connectReportServer();
					this.loadReportList();
					this.loadReportContent();
				}
				else if(this.adminMenu==4){
					//회원 통계
					this.getMemberLoginStats();
					this.getMemberJoinStats();
					this.getMemberCumulativeStats();
				}
				else if(this.adminMenu==5){
					//게시물 통계
					this.getBoardTimeStats();
					this.getBoardTagStats();
				}
				else if(this.adminMenu==6){
					//조회 통계
					this.getSearchTagStats();
					this.getSearchNickStats();
				}
			},
			modal(){
				if(this.modal=='boardViewModal'){
					this.showBoardViewModal();
				}
				if(this.modal=='forbiddenModal'){
					this.showForbiddenModal();
				}
				if(this.modal=='reportContentModal'){
					this.showReportContentModal();
				}
				if(this.modal=='reportedBoardModal'){
					this.showReportedBoardModal();
				}
				if(this.modal=='reportedReplyModal'){
					this.showReportedReplyModal();
				}
				if(this.modal=='reportedReplyDetailModal'){
					this.showReportedReplyDetailModal();
				}
				if(this.modal=='reportedBoardDetailModal'){
					this.showReportedBoardDetailModal();
				}
				if(this.modal=='suspensionModal'){
					this.showSuspensionModal();
				}
				if(this.modal=='reportSuspensionModal'){
					this.showReportSuspensionModal();
				}
				if(this.modal=='reportDetailModal'){
					this.showReportDetailModal();
				}
				if(this.modal==''){
					this.hideAllModal();
				}
			},
			forbiddenWord:_.throttle(function(){
				this.moveScroll(this.forbiddenWord);
			}, 500),
		},
		mounted(){
			//쿼리 초기화 및 변화 감지
			this.initializePageFromQuery();
			//뒤로가기, 앞으로가기 누르면 이전 쿼리 반환
			window.addEventListener('popstate', this.initializePageFromQuery);
			//모달 선언
		},
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>