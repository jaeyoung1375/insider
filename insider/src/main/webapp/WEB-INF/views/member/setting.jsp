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
			<div class="row setting-menu" v-on:click="page=0" :class="{'selected':page==0}">
				<div class="col">
					<h2>개인정보 변경</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=1" :class="{'selected':page==1}">
				<div class="col">
					<h2>프로필 편집</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=2" :class="{'selected':page==2}">
				<div class="col">
					<h2>푸시 알림</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=3" :class="{'selected':page==3}">
				<div class="col">
					<h2>내가 볼 수 있는 내용</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=4" :class="{'selected':page==4}">
				<div class="col">
					<h2>공개 범위</h2>
				</div>
			</div>
			<div class="row setting-menu" v-on:click="page=5" :class="{'selected':page==5}">
				<div class="col">
					<h2>소통 방법</h2>
				</div>
			</div>
		</div>
	<!-- 개인정보 변경 -->
		<div class="col-md-8" v-show="page==0">
			<div class="row">
				<div class="col">
					<h1>개인정보 변경</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<span>연락처 정보</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberEmail">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<span>생일</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberBirth">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<span>주소</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberPost" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberBasicAddr" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input class="form-control" v-model="member.memberDetailAddr">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h3>비밀번호 변경</h3>
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
					<img :src="profileUrl">
				</div>
				<div class="col-9">
					<div class="row">
						<div class="col">
							<span>{{member.memberName}}</span>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<span @click="openFileInput">프로필 사진 변경</span>
							<input ref="fileInput" type="file" @change="handleFileUpload" accept="image/*" style="display: none;">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<span>소개</span>
				</div>
				<div class="col-9">
					<input class="form-control" v-model="member.memberMsg">
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<span>성별</span>
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
					<span>받음</span>
					<input type="radio" value="1" v-model="setting.settingLikeAlert" v-bind:checked="setting.settingLikeAlert==1">
				</div>
				<div class="col">
					<span>안받음</span>
					<input type="radio" value="0" v-model="setting.settingLikeAlert" v-bind:checked="setting.settingLikeAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>댓글 알림</h2>
				</div>
				<div class="col">
					<span>받음</span>
					<input type="radio" value="1" v-model="setting.settingReplyAlert" v-bind:checked="setting.settingReplyAlert==1">
				</div>
				<div class="col">
					<span>안받음</span>
					<input type="radio" value="0" v-model="setting.settingReplyAlert" v-bind:checked="setting.settingReplyAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>팔로우 알림</h2>
				</div>
				<div class="col">
					<span>받음</span>
					<input type="radio" value="1" v-model="setting.settingFollowAlert" v-bind:checked="setting.settingFollowAlert==1">
				</div>
				<div class="col">
					<span>안받음</span>
					<input type="radio" value="0" v-model="setting.settingFollowAlert" v-bind:checked="setting.settingFollowAlert==0">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>댓글에 좋아요 알림</h2>
				</div>
				<div class="col">
					<span>받음</span>
					<input type="radio" value="1" v-model="setting.settingReplyLikeAlert" v-bind:checked="setting.settingReplyLikeAlert==1">
				</div>
				<div class="col">
					<span>안받음</span>
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
					<span>반경</span>
				</div>
				<div class="col">
					<input type="text" v-model="setting.settingDistance">
				</div>
				<div class="col">
					<span>km 이내 게시물을 탐색합니다</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h2>동영상 자동재생</h2>
				</div>
				<div class="col">
					<span>자동재생</span>
					<input type="radio" value="1" v-model="setting.settingVideoAuto" v-bind:checked="setting.settingVideoAuto==1">
				</div>
				<div class="col">
					<span>수동재생</span>
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
					<span>전체 공개</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="1" v-model="setting.settingHide" v-bind:checked="setting.settingHide==1"><span>친구추천 불가</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="2" v-model="setting.settingHide" v-bind:checked="setting.settingHide==2"><span>친구에게만 공개</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<p>계정이 공개된 상태인 경우</p>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="3" v-model="setting.settingHide" v-bind:checked="setting.settingHide==3"><span>비공개 계정</span>
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
					<span>차단한 계정 확인하고 관리하기</span>
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
					<input type="radio" value="0" v-model="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==0">
					<span>모든 사람</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="1" v-model="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==1"> 
					<span>내가 팔로우 하는 사람</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="2" v-model="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==2"> 
					<span>내 팔로워</span>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<input type="radio" value="3" v-model="setting.settingAllowReply" v-bind:checked="setting.settingAllowReply==3"> 
					<span>내가 팔로우 하는 사람 및 내 팔로워</span>
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
					memberEmail:"",
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
				},
			};
		},
		computed: {
			//계산영역
			profileUrl(){
				if(this.member.attachmentNo>0){
					return contextPath+"/rest/attachment/download"+this.member.attachmentNo;
				}
				else{
					return "https://via.placeholder.com/100x100?text=profile";
				}
			}
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
			},
			//멤버 정보 불러오기
			async loadMember(){
				const resp = await axios.get(contextPath+"/rest/member/"+memberNo);
				Object.assign(this.member, resp.data);
			},
			
			//프로필 사진 변경 누르면 실행
		    openFileInput() {
				this.$refs.fileInput.click();
			},
			//파일이 추가되면 실행
			handleFileUpload(event) {
				const file = event.target.files[0];
				// 파일 업로드 로직 처리
				if (file) {
					let fd = new FormData();
					fd.append("attach", file);
					this.member.attachmentNo= this.uploadProfile(fd);
				};
			},
			//파일 저장 비동기 처리
			async uploadProfile(formData){
				const resp = await axios.post(contextPath+"/rest/attachment/upload/profile", formData);
				
				return resp;
			},
			//비동기 회원 데이터 수정
			async saveMember(){
				const resp = await axios.put(contextPath+"/rest/member/"+this.member.memberNo, this.member);
			},
			//비동기 세팅 데이터 수정
			async saveSetting(){
				const resp = await axios.put(contextPath+"/rest/member/setting/"+this.member.memberNo, this.setting);
			}
		},
		created(){
			//쿼리에서 memberNo 반환
			//this.setting.memberNo = this.$route.query.memberNo;
			//세팅데이터 로드
			//this.loadMember();
			//this.loadSetting();
		},
		watch:{
			//감시영역
			member:{
				deep:true,
				handler(){
					this.saveMember();
				},
			},
			setting:{
				deep:true,
				handler(){
					this.saveSetting();
				},
			}
		}
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>