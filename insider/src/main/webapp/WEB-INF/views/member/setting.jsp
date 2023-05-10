<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-fluid mt-4" id="app">
	<div class="row">
	<!-- 좌측 사이드 메뉴바 -->
		<div class="col-md-4">
			<div class="row setting-menu" v-on:click="page=1">
				<div class="col">
					<h2>프로필 편집</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=2">
				<div class="col">
					<h2>푸시 알림</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=3">
				<div class="col">
					<h2>내가 볼 수 있는 내용</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=4">
				<div class="col">
					<h2>공개 범위</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=5">
				<div class="col">
					<h2>소통 방법</h2>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>변경사항 저장</h2>
				</div>
			</div>
		</div>
	<!-- 프로필 편집 -->
		<div class="col-md-8" v-show="page==1">
			<div class="row">
				<div class="col">
					<h1>프로필 편집</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					프사위치
				</div>
				<div class="col-9">
					{{member.memberName}}
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					소개
				</div>
				<div class="col-9">
					<input class="form-control" v-model="member.memberMsg">
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					성별
				</div>
				<div class="col-9">
					<input class="form-control" v-model="member.memberGender">
				</div>
			</div>
		</div>
	<!-- 푸시 알림 -->
		<div class="col-md-8" v-show="page==2">
			<div class="row">
				<div class="col">
					<h1>푸시 알림</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>좋아요 알림</h2>
				</div>
				<div class="col">
					받음
					<input type="radio" value="1" v-model="setting.settingLikeAlert" v-bind:checked="setting.settingLikeAlert==1">
				</div>
				<div class="col">
					안받음
					<input type="radio" value="0" v-model="setting.settingLikeAlert" v-bind:checked="setting.settingLikeAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>댓글 알림</h2>
				</div>
				<div class="col">
					받음
					<input type="radio" value="1" v-model="setting.settingReplyAlert" v-bind:checked="setting.settingReplyAlert==1">
				</div>
				<div class="col">
					안받음
					<input type="radio" value="0" v-model="setting.settingReplyAlert" v-bind:checked="setting.settingReplyAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>팔로우 알림</h2>
				</div>
				<div class="col">
					받음
					<input type="radio" value="1" v-model="setting.settingFollowAlert" v-bind:checked="setting.settingFollowAlert==1">
				</div>
				<div class="col">
					안받음
					<input type="radio" value="0" v-model="setting.settingFollowAlert" v-bind:checked="setting.settingFollowAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>댓글에 좋아요 알림</h2>
				</div>
				<div class="col">
					받음
					<input type="radio" value="1" v-model="setting.settingReplyLikeAlert" v-bind:checked="setting.settingReplyLikeAlert==1">
				</div>
				<div class="col">
					안받음
					<input type="radio" value="0" v-model="setting.settingReplyLikeAlert" v-bind:checked="setting.settingReplyLikeAlert==0">
				</div>
			</div>
		</div>
	<!-- 내가볼수있는내용 -->
		<div class="col-md-8" v-show="page==3">
			<div class="row">
				<div class="col">
					<h1>내가 볼 수 있는 내용</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>좋아요 수 및 조회수 숨기기</h3>
				</div>
				<div class="col">
					<input type="checkbox" @change="watchLike" v-model="setting.isWatchLike">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>다른 게시물에서~</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>반경 설정</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label>반경</label>
				</div>
				<div class="col">
					<input type="text" v-model="setting.settingDistance">
				</div>
				<div class="col">
					<label>km 이내 게시물을 탐색합니다</label>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>동영상 자동재생</h2>
				</div>
				<div class="col">
					자동재생
					<input type="radio" value="1" v-model="setting.settingVideoAuto" v-bind:checked="setting.settingVideoAuto==1">
				</div>
				<div class="col">
					수동재생
					<input type="radio" value="0" v-model="setting.settingVideoAuto" v-bind:checked="setting.settingVideoAuto==0">
				</div>
			</div>
		</div>
	<!-- 내 콘텐츠를 볼수 있는 사람 -->
		<div class="col-md-8" v-show="page==4">
			<div class="row">
				<div class="col">
					<h1>내 콘텐츠를 볼 수 있는 사람</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>계정 공개 범위</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="0" v-model="setting.settingHide" v-bind:checked="setting.settingHide==0">
					<label>전체 공개</label>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="1" v-model="setting.settingHide" v-bind:checked="setting.settingHide==1"><label>친구추천 불가</label>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="2" v-model="setting.settingHide" v-bind:checked="setting.settingHide==2"><label>친구에게만 공개</label>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="3" v-model="setting.settingHide" v-bind:checked="setting.settingHide==3"><label>비공개 계정</label>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col">
					<h3>차단된 계정</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label>차단한 계정 확인하고 관리하기</label>
				</div>
			</div>
		</div>
	<!-- 다른 사람이 나와 소통할 수 있는 방법 -->
		<div class="col-md-8" v-show="page==5">
			<div class="row">
				<div class="col">
					<h1>다른 사람이 나와 소통할 수 있는 방법</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>댓글관리</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>댓글을 허용할 사람 선택</h3>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="0" v-model="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==0"> 모든 사람
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="1" v-model="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==1"> 내가 팔로우 하는 사람
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="2" v-model="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==2"> 내 팔로워
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="3" v-model="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==3"> 내가 팔로우 하는 사람 및 내 팔로워
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	Vue.createApp({
		data() {
			return {
				page:1,
				member:{
					memberNo:"",
					memberName:"",
					memberLat:"",
					memberLon:"",
					memberPost:"",
					memberBasicAddr:"",
					memberDetailAddr:"",
					memberMsg:"",
					memberTel:"",
					memberGender:"",
					memberBirth:"",
					attachmentNo:"",
				},
				setting:{
					memberNo:"",
					settingHide:"",
					settingDistance:"",
					settingLikeAlert:"",
					settingReplyAlert:"",
					settingFollowAlert:"",
					settingVideoAuto:"",
					settingReplyLikeAlert:"",
					settingMessage:"",
					settingAllowReply:"",
					settingWatchLike:"",
					isWatchLike:this.settingWatchLike==1,
				}
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//watchLike 체크에 따른 값 변화
			watchLike(){
				if(this.setting.isWatchLike){
					this.setting.settingWatchLike=0;
				}
				else{
					this.setting.settingWatchLike=1;
				}
			},
			
			//세팅 데이터 불러오기
			async loadSetting(){
				const resp = await axios.get(contextPath+"/rest/member/setting/"+memberNo);
				Object.assign(this.setting, resp.data);
			}
		},
		created(){
			//쿼리에서 memberNo 반환
			//this.setting.memberNo = this.$route.query.memberNo;
			//세팅데이터 로드
			//this.loadSetting();
		},
		watch:{
			//감시영역
		}
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>