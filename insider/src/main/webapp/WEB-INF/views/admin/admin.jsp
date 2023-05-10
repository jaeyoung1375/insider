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
	<!-- 내가볼수있는내용 -->
		<div class="col-md-8" v-show="page==3">
			<div class="row">
				<div class="col">
					<h1>내가 볼 수 있는 내용</h1>
				</div>
			</div>
		</div>
	<!-- 내 콘텐츠를 볼수 있는 사람 -->
		<div class="col-md-8" v-show="page==4">
			<div class="row">
				<div class="col">
					<h1>공개 범위</h1>
				</div>
			</div>
		</div>
	<!-- 다른 사람이 나와 소통할 수 있는 방법 -->
		<div class="col-md-8" v-show="page==5">
			<div class="row">
				<div class="col">
					<h1>소통 방법</h1>
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
					member
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
				}
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
			async loadSetting(){
				const resp = await axios.get(contextPath+"/rest/member/setting/"+memberNo);
				Object.assign(this.setting, resp.data);
			}
		},
		created(){
			//this.setting.memberNo = this.$route.query.memberNo;
			//데이터 불러오는 영역
			//this.loadSetting();
		},
		watch:{
			//감시영역
		}
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>