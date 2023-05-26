<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../template/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
   .media-height{
           width: 250px; 
           height:250px; 
           overflow: hidden;
        }
        .imgHover:hover{
         opacity:1!important;
      }
      .nomal{
         text-decoration: none;
         color:black;
      }
      .hide{
      	display:none;
      }
   	.profile-container {
  position: relative;
  display: inline-block;
}

.profile-preview {
  position: absolute;
  margin-left :30px;
  top: 50px;
  left: 0;
  width: 400px;
  height: 400px;
  background-color: white;
  border: 1px solid gray;
  padding: 10px;
}

.profile-container:hover .profile-preview {
  display: block; 
}
     


   
</style>

      <div id="app" class="container-fluid">
             <div class="row">
                <!-- 본인 여부에 따른 프로필 변경  -->
            <div class="col-4 text-center">
               <c:choose>
               <c:when test="${isOwner}">
                <img style="border-radius: 70%;" :src="profileUrl"
             width = "150" height="150" @click="openFileInput">
             <input ref="fileInput" type="file" @change="handleFileUpload" accept="image/*" style="display: none;">
                </c:when>       
                <c:otherwise> 
                  <img style="border-radius: 70%;" width="150" height="150">
                </c:otherwise>
                </c:choose>           
            </div>
            <div class="col-4" style=" width:40%; margin-left:70px;">   
               <div class="col-7" style="display:flex;">
                  <div class="col-6" style="width:60%;">
                  <a href="#" class="btn btn-default" @click="showModal">${memberDto.memberNick}</a>    
           </div>
              <c:choose>
              <c:when test="${isOwner}"> <!-- 본인 프로필 이라면 -->
                 <div class="col-7">
                  <a class="btn btn-secondary" href="/member/setting?page=1">프로필 편집</a>
                  </div>
               <div class="col-5" style="width:40%;">
               <button class="btn btn-secondary" @click="myOptionModalShow" style="background-color: white; border:none;"><i class="fa-sharp fa-solid fa-gear" style="font-size:24px;"></i></button>
             </div>
              </c:when>
              <c:otherwise> <!-- 본인 프로필이 아니라면 -->
                    <div class="col-5">
               <button class="btn btn-primary" @click="follow(${memberDto.memberNo})" v-if="followCheckIf(${memberDto.memberNo})">팔로우</button>
               <button class="btn btn-secondary" @click="unFollow(${memberDto.memberNo})" v-else>팔로잉</button>
               
               </div>
               <div class="col-5"  style=" width:70%;">
               <button class="btn btn-secondary">메시지 보내기</button>
               </div>
               <div class="col-5" style=" width:30%;">
               <button class="btn btn-secondary"><i class="fa-solid fa-user-plus"></i></button>
               </div>
               <div class="col-5" style="width:40%;">
               <button class="btn btn-secondary" @click="showModal2"><i class="fa-solid fa-ellipsis"></i></button>
             </div>
              </c:otherwise>
              </c:choose>
              
             </div>
               <div class="row mt-4" style="width:130%;">
                  <div class="col-7" style="display:flex; margin-left:10px;">
                     <div class="col-6">
                        <span>게시물 
                           <span style="font-weight: bold;">${totalPostCount}</span>
                        </span>
                     </div>
                     <div class="col-6" @click="followerModalShow">
                        <span>팔로워
                        <span style="font-weight: bold;">{{totalFollowerCnt}}</span>
                         </span>
                     </div>
                     <div class="col-6" @click="followModalShow">
                        <span>팔로우
                        <span style="font-weight: bold;">{{totalFollowCnt}}</span>
                         </span>
                     </div>
                  </div>   
               </div>
               <div class="row mt-4">
                  <span style="font-size:12px;">
                  <h5>${memberDto.memberName}</h5>
                  Aespa fashion 에스파 패션             
               팬 페이지
               for aespa 💙
               #aespastyles_ (member)
               est june 2020 ✨ | twitter:
               twitter.com/aespastyles?s=21      
               </span>
               </div>
               
            </div>
            </div>
            <hr>
     <!-- 게시물 시작 -->
<div class="position-absolute mt-5 start-50 translate-middle-x media-width" style="display: flex; flex-direction: column; width: 770px; height:700px;"> 
 
    <div class="mt-5" style="display: flex;flex-direction: column; justify-content: center; align-items: center;" v-if="myBoardList.length == 0 && !isOwner">    
   <i class="fa-solid fa-camera fa-2xl" style="font-size:100px;"></i>
   <h2 class="mt-5">게시물 없음</h2>
   </div>
   

   <div class="mt-5" style="display: flex;flex-direction: column; justify-content: center; align-items: center;" v-if="myBoardList.length == 0 && isOwner">    
   <i class="fa-solid fa-camera fa-2xl" style="font-size:100px;"></i>
   <h2 class="mt-5">사진 공유</h2>
   <p>사진을 공유하면 회원님의 프로필에 표시됩니다.</p>
  
   </div>
   
   

    <div style="margin-bottom:10px;display: flex; width: 110%;"> 
    	 <div style="margin-bottom:10px;display: flex;flex-wrap:wrap; width: 100%;">
	    	<div v-for="(board,index) in myBoardList" :key="board.boardNo" style="margin-right: 10px;">
    		 <div class="media-height" style="margin-right: 10px; position:relative;">
    		 	<img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + board.attachmentNo" style="width:100%; height:250px;">
    		 	 <i class="fa-solid fa-note-sticky fa-lg" style="color:white;position:absolute;right:0;top:20px;"></i>
    		 	  <div class="imgHover" style="cursor:pointer;position:absolute;background-color:#22222221;left:0;right:0;top:0;bottom:0;opacity:0;color:white;">
    		 	   <i class="fa-solid fa-heart fa-lg" style="position:absolute;top:50%;left:25%;">{{board.boardLike}}</i>
    		 	     <i class="fa-regular fa-comment fa-lg" style="position:absolute;top:50%;left:50%;">{{board.boardReply}}</i> 	    		 	 	    
    		 	  </div> 
    		 </div>  
    	</div>
     
    	</div>
    </div>
    
</div>
<!-- 게시물 영역 끝 --> 
      
      
      <!-- Modal 창 영역 -->
                   <div class="modal" tabindex="-1" role="dialog" id="modal03"
                            data-bs-backdrop="static"
                            ref="modal03" @click.self="hideModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center;">
                        <h5 class="modal-title" style="text-align:center;">
                            <img style="border-radius: 70%;" :src="profileUrl"
                      width = "150" height="150">
                      <div class="nickname">
                      ${memberDto.memberNick}
                      </div>   
                   <div class="content" style="text-align:left;">
                      <div class="content">
                      <p style="font-size: 12px; color:gray;">신뢰할 수 있는 커뮤니티를 유지하기 위해 Insider 계정에 대한 정보가 표시됩니다</p>
                      </div>
                      <div class="date" style="display:flex;">
                      <i class="fa-solid fa-calendar-days"></i>&nbsp;&nbsp;
                      <h5>최근 로그인 일자</h5>
                      </div>
                      <p style="font-size:12px; color:gray;">
                      ${memberDto.memberLogin}
                      </p>
                      <div class="location" style="display:flex;">
                      <i class="fa-solid fa-location-dot"></i>&nbsp;&nbsp;
                      <h5>계정 기본 위치</h5>
                      </div>
                      <p style="font-size:12px; color:gray;">한국</p>
                   </div>   
                        </h5>
                    </div>
                   
                 
                        <button type="button" class="btn"
                                data-bs-dismiss="modal">닫기</button>
                   
                </div>      
            </div>
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="myOptionModal"
                            data-bs-backdrop="static"
                            ref="addtionModal" @click.self="hideModal2">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center;">
                        <a href="#" class="btn btn-default block" style="color:red;"  @click="blockModalShow">차단</a>
                    </div>
                     
                       <div class="modal-header" style="display:flex; justify-content: center;">
                        <a href="#" class="btn report" style="color:red;">신고</a>
                    </div>
                        <div class="modal-header" style="display:flex; justify-content: center;">
                          <a @click="accountView">이 계정 정보</a>
                    </div>
                   
                 
                        <button type="button" class="btn"
                                data-bs-dismiss="modal">취소</button>
                   
                </div>      
            </div>
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="blockModal"
                            data-bs-backdrop="static"
                            ref="blockModal" @click.self="blockModalHide">
            <div class="modal-dialog" role="document" style="width:30%;">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center; flex-direction: column;">
                     <h5 class="modal-title" style="text-align:center;">
                        ${memberDto.memberNick}님을 차단하시겠어요?
                     </h5>
                     <div class="content" style="font-size:12px; text-align:center;">
                        상대방은 Insider에서 회원님의 프로필, 게시물 및 스토리를 찾을 수 없게 됩니다. Insider은 회원님이 차단한 사실을 상대방에게 알리지 않습니다.                     
                     </div>
                    </div>
                     <div class="modal-header" style="display:flex; justify-content: center;" >
                         <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">취소</button>
                    </div>
                   
                    <div class="modal-header" style="display:flex; justify-content: center;">
                          <a @click="blockResultModalShow">차단</a>
                    </div>
                   
                </div>      
            </div>
        </div>
        
         <div class="modal" tabindex="-1" role="dialog" id="blockResultModal"
                            data-bs-backdrop="static"
                            ref="blockResultModal" @click.self="blockResultModalHide">
            <div class="modal-dialog" role="document" style="width:30%;">
                <div class="modal-content">
                    <div class="modal-header" style="display:flex; justify-content: center; flex-direction: column;">
                     <h5 class="modal-title" style="text-align:center;">
                        ${memberDto.memberNick}님을 차단했습니다.
                     </h5>
                     <div class="content" style="font-size:12px; text-align:center;">
                        <p style="font-size:12px; color:gray;">상대방의 프로필에서 언제든지 차단을 해제할 수 있습니다.</p>                    
                     </div>
                     </div>
                     <div class="model-header" style="text-align:center;">
                     <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">닫기</button>   
                     </div>
                     
            </div>
        </div>
      
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="myOptionModal"
                            data-bs-backdrop="static"
                            ref="myOptionModal" @click.self="myOptionModalHide">
            <div class="modal-dialog" role="document">
                   <div class="modal-content">
                          <div class="modal-header" style="display:flex; justify-content: center;">
                          <a href="/member/setting" class="nomal">설정 및 개인정보</a>
                       </div>
                        <div class="modal-header" style="display:flex; justify-content: center;">
                          <a href="/member/setting?page=2" class="nomal">알림</a>
                       </div>
                    
                        <div class="modal-header" style="display:flex; justify-content: center;">
                          <a href="/member/logout" class="nomal">로그아웃</a>
                       </div>
                   
                 
                        <button type="button" class="btn"
                                data-bs-dismiss="modal" style="color:red;">취소</button>
                   
                </div>      
            </div>
        </div>
        
        
          <div class="modal" tabindex="-1" role="dialog" id="followerModal"
                            data-bs-backdrop="static"
                            ref="followerModal" @click.self="followerModalHide">	
            <div class="modal-dialog" role="document">
                   <div class="modal-content">
                       <div class="modal-header text-center" style="display:flex; justify-content: center;">
							<h5 class="modal-title">팔로워</h5>
                       </div>
                       <div class="modal-body">
                     	<div v-for="item in myFollowerList" :key="item.attachmentNo">
  						 <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="40" height="40">
						  <a :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
						  
						  <button class="float-end btn btn-primary" @click="follow(item.memberNo)" v-if="followCheckIf(item.memberNo)" :class="{'hide' : item.memberNo == ${memberNo}}">팔로우</button>
						  <button class="float-end btn btn-secondary" @click="myUnFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && ${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}">팔로잉</button>					  
						  <button class="float-end btn btn-secondary unfollow-button" @click="unFollower(item.memberNo)" v-if="!followCheckIf(item.memberNo) && !${isOwner}" :class="{'hide' : item.memberNo == ${memberNo}}">팔로잉</button>
						 
						
						</div>
                     		
                       </div>           
                        <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">취소</button>
                </div>      
            </div>
        </div>
        
          <div class="modal" tabindex="-1" role="dialog" id="followModal"
                            data-bs-backdrop="static"
                            ref="followModal" @click.self="followModalHide">
             <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center" style="display:flex; justify-content: center;">
        <h5 class="modal-title">팔로우</h5>
      </div>
      <div class="modal-body">
        <div v-for="item in myFollowList" :key="item.attachmentNo">
         <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="40" height="40" @mouseover="profileHover(item)">
          <div class="profile-preview" v-if="selectedItem === item" @mouseleave="profileLeave">
                  <!-- 프로필 미리보기 내용 -->
                   <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="75" height="75" style="border-radius:25px;">
                    <a :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
                    <p>{{item.memberName}}</p>
                    <hr>
                    <div class="col-7" style="display: flex; margin-left: 10px;">
                    	<div class="col-6">
                    		<span>게시물 <span style="font-weight: bold;">44</span></span>
                    	</div>
                    	<div class="col-6">
                    		<span>팔로워 <span style="font-weight: bold;">1</span></span>
                    	</div>
                    	<div class="col-6">
<!--                     		<span>팔로우 <span style="font-weight: bold;">{{getTotalFollowCount(item.memberNick)}}</span></span> -->
							<span>팔로우 <span style="font-weight: bold;">{{followCounts[item.memberNick]}}</span></span>
                    	</div>
                    </div>
                    <div class="col-6">
                    	<div style="display:flex;">
                    	   <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="127" height="150" style="margin-right:3px;">
                    	   <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="127" height="150" style="margin-right:3px;">
                    	   <img :src="'${pageContext.request.contextPath}/rest/attachment/download/' + item.attachmentNo" width="127" height="150" style="margin-right:3px;">
                    	 </div>
                    </div>
                    <div class="col-9" style="display:flex; justify-content: space-between; margin-left:20px;">
                  	 <button class="btn btn-primary" @click="follow(item.followFollower)" v-if="followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}">팔로우</button>
                  	 <button class="btn btn-primary">메시지 보내기</button>
          			<button class="btn btn-secondary unfollow-button" @click="unFollow(item.followFollower)" v-if="!followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}" >팔로잉</button>
                    </div>
          </div>
          <a :href="'${pageContext.request.contextPath}/member/' + item.memberNick">{{ item.memberNick }}</a>
          <button class="float-end btn btn-primary" @click="follow(item.followFollower)" v-if="followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}">팔로우</button>
          <button class="float-end btn btn-secondary unfollow-button" @click="unFollow(item.followFollower)" v-if="!followCheckIf(item.followFollower)" :class="{'hide' : item.followFollower == ${memberNo}}">팔로잉</button>
        </div>
      </div>
      <button type="button" class="btn" data-bs-dismiss="modal" style="color:red;">취소</button>
    </div>
  </div>
</div>
      
        
       
        
        
        
        <!-- Modal 창 영역 끝 -->
      
      </div> <!-- vue 끝 -->
      
      


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/vue@next"></script>
      <script>
   Vue.createApp({
      data() {
         return {
        	 //▼▼▼▼▼▼▼▼▼▼▼▼▼무한 페이징▼▼▼▼▼▼▼▼▼▼▼▼▼
             percent:0,
             page : 1,
             //안전장치
             loading:false,
             finish:false,
             isOwner : false,
             showProfilePreview : false,
            //추가 메뉴 모달 및 신고 모달
            modal : null,
            addtionModal : null,
            reportMenuModal:null,
            blockModal : null,
            blockResultModal : null,
            myOptionModal : null,
            followerModal : null,
            followModal : null,  
            followerHoverModal : null,
            selectedItem: null,
            reportContentList:[],
            followCheckList:[],
            myFollowerList: [],
            myFollowList: [],
            myBoardList : [],
            followCounts: {},
            reportBoardNo:"",  
            memberNo : "${memberDto.memberNo}",
            memberNick : "${memberDto.memberNick}",
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
            totalFollowCnt: 0,
            totalFollowerCnt: 0,
         };
      },
      computed: {
         profileUrl(){
            if(this.member.attachmentNo>0){
               return contextPath+"/rest/attachment/download/"+this.member.attachmentNo;
            }
            else{
               return "https://via.placeholder.com/100x100?text=profile";
            }
         },
         async getFollowCount() {
             return async (memberNick) => {
               if (!this.followCounts[memberNick]) {
                 const resp = await axios.get("totalFollowCount", {
                   params: {
                     memberNick: memberNick,
                   },
                 });
                 this.followCounts[memberNick] = resp.data;
               }
               return this.followCounts[memberNick];
             };
           },
         
         
      },
      methods: {
           showModal(){
                  if(this.modal == null) return;
                  this.modal.show();
              },
              hideModal(){
                  if(this.modal == null) return;
                  this.modal.hide();
              },
              
             showModal2(){
                  if(this.addtionModal == null) return;
                  this.addtionModal.show();
              },
              hideModal2(){
                  if(this.addtionModal == null) return;
                  this.addtionModal.hide();
              },
              blockModalShow(){
                  if(this.blockModal == null) return;
                  this.addtionModal.hide();
                   this.blockModal.show();      
              },
              blockModalHide(){
                 if(this.blockModal == null) return;
                  this.blockModal.hide();
              },
              blockResultModalShow(){
                 if(this.blockResultModal == null) return;
                 this.blockModal.hide();
                  this.blockResultModal.show(); 
              },
              blockResultModalHide(){
                 if(this.blockResultModal == null) return;
                  this.blockResultModal.hide(); 
              },
              myOptionModalShow(){
                 if(this.myOptionModal == null) return;
                  this.myOptionModal.show();  
              },
              myOptionModalHide(){
                 if(this.myOptionModal == null) return;
                  this.myOptionModal.hide();  
              },
              followerModalShow(){
            	  if(this.followerModal == null || this.totalFollowerCnt == 0 ) return;
                  this.followerModal.show();    
              },
              followerModalHide(){
                  if(this.followerModal == null) return;
                   this.followerModal.hide();  
               },
               followModalShow(){
             	  if(this.followModal == null || this.totalFollowCnt == 0 ) return;
                   this.followModal.show();    
               },
               followModalHide(){
                   if(this.followModal == null) return;
                    this.followModal.hide();  
                },
                followerHoverModalShow(){
                	if(this.followerHoverModal == null) return;
                	this.followerHoverModal.show();
                },
              
              accountView(){
                 this.addtionModal.hide();
                 this.modal.show();
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
               this.uploadProfile(fd);
            };
         },
         //파일 저장 비동기 처리
         async uploadProfile(formData){
            const resp = await axios.post(contextPath+"/rest/attachment/upload/profile", formData);
            this.member.attachmentNo = resp.data;
         },
         
         //팔로우
         async follow(followNo) {
         	//const loginNo = sessionStorage.getItem('memberNo');
         	//console.log(followNo);
         	const resp = await axios.post("${pageContext.request.contextPath}/rest/follow/"+followNo);
         	//if(loginNo == this.boardList.boardWithNickDto.memberNo)
         	await this.followCheck();
         	
         	this.totalFollowerCount();    
         	this.totalFollowCount();
         	this.followerList();
         	this.followList();
        
         },
         
         //팔로워 되있는사람 -> 팔로우 삭제
      async unFollower(memberNo) {
		  try {
		    const response = await axios.post("/rest/follow/unFollow", null, {
		      params: {
		        followFollower: memberNo
		      }
		    });
		
		    if (response.data) {
		      // 언팔로우 성공 처리
		      console.log("언팔로우 성공");
		      this.totalFollowerCount();
		      this.totalFollowCount();
		      this.followerList();
		      this.followList();
		    } else {
		      // 언팔로우 실패 처리
		      console.log("언팔로우 실패");
		    }
		  } catch (error) {
		    // 요청 실패 처리
		    console.error("언팔로우 요청 실패", error);
		  }
		},
			// 팔로워 되있는 사람 -> 팔로우 삭제 (본인 프로필 일때)
		   async myUnFollower(memberNo) {
			  try {
			    const response = await axios.post("/rest/follow/myUnFollow", null, {
			      params: {
			        memberNo: memberNo
			      }
			    });
			
			    if (response.data) {
			      // 언팔로우 성공 처리
			      console.log("언팔로우 성공");
			      this.totalFollowerCount();
			      this.totalFollowCount();
			      this.followerList();
			      this.followList();
			    } else {
			      // 언팔로우 실패 처리
			      console.log("언팔로우 실패");
			    }
			  } catch (error) {
			    // 요청 실패 처리
			    console.error("언팔로우 요청 실패", error);
			  }
			},
		
		
		
	     //팔로우 되있는사람 -> 팔로우 삭제
	      async unFollow(memberNo) {
			  try {
			    const response = await axios.post("/rest/follow/unFollow", null, {
			      params: {
			        //memberNo: this.memberNo,
			        followFollower:memberNo
			      }
			    });
			    if (response.data) {
			      // 언팔로우 성공 처리
			      console.log("언팔로우 성공");
			      this.totalFollowCount();
			      this.totalFollowerCount();
			      this.followList();
			      this.followerList();
			    } else {
			      // 언팔로우 실패 처리
			      console.log("언팔로우 실패");
			    }
			  } catch (error) {
			    // 요청 실패 처리
			    console.error("언팔로우 요청 실패", error);
			  }
			},
		 
         // 팔로우 v-if 여부체크 함수
        	followCheckIf(memberNo){
         	
        		return !this.followCheckList.includes(memberNo);
         },
          
      	 //팔로우 여부 체크
         async followCheck() {
         	const resp = await axios.post("${pageContext.request.contextPath}/rest/follow/check");
    
         	const newData = memberNo;
        
         	 this.followCheckList = resp.data;
         	this.followCheckList.push(...resp.data);
         	this.followCheckList.push(parseInt(newData));
         	
      
         },  
         // 팔로우 총 개수 
         async totalFollowCount() {
        	    const resp = await axios.get("totalFollowCount", {
        	        params: {
        	            memberNick: this.memberNick
        	        }
        	    });
        	    this.totalFollowCnt = resp.data;
        	},
        	
        	        	
        	 // 팔로워 총 개수 
            async totalFollowerCount() {
           	    const resp = await axios.get("totalFollowerCount", {
           	        params: {
           	            memberNick: this.memberNick
           	        }
           	    });
           	    this.totalFollowerCnt = resp.data;           	    
           	},
           	
           	
            async getTotalFollowCount(memberNick) {
           	    const resp = await axios.get("totalFollowCount", {
           	      params: {
           	        memberNick: memberNick
           	      }
           	    });
           	    //console.log(this.followCounts);
           	 	this.$set(this.followCounts, memberNick, resp.data);
           	 	//return resp.data;
           	  },
           	
           	// 본인 팔로워 목록 불러오기
           	async followerList(){
           		const resp = await axios.get("/rest/member/followerList",{
           			params : {
           				memberNo : this.memberNo
           			}
           		});
           		
           		this.myFollowerList= resp.data;
           		console.log("나의 팔로워 리스트 : " +JSON.stringify(this.myFollowerList));
           		console.log(this.followCheckList); 
           	},
         	// 본인 팔로우 목록 불러오기
         	
   				async followList(){
           		const resp = await axios.get("/rest/member/followList",{
           			params : {
           				memberNo : this.memberNo
           			}
           		});
           		this.myFollowList= resp.data;
           		this.followCheck();
           		console.log("나의 팔로우 리스트 : " +JSON.stringify(this.myFollowList));
           		 
           	}, 
           	
           	// 마이페이지 게시물 목록 불러오기
           	async boardList(){
           	  if(this.loading == true) return; //로딩중이면
              if(this.finish == true) return; //다 불러왔으면
              this.loading = true;
              
           		const resp = await axios.get("/rest/member/page/"+this.page,{
           			params : {           
           				memberNo : this.memberNo
           			},
           		});
           		
           		this.myBoardList.push(...resp.data);
           		this.page++;
           		
           		if(resp.data < 5) this.finish = true;
           	
           	
           		console.log(this.myBoardList);
           		
           		this.loading = false;
           		
           	},
           	checkOwnerShip(){
           		this.isOwner = this.memberNo == ${memberNo};
           	},
            profileHover(item) {
                this.selectedItem = item; // 선택한 항목의 정보 저장
                // 다른 작업 처리
              },
              profileLeave() {
                this.selectedItem = {}; // 프로필 미리보기 숨김
                // 다른 작업 처리
              },
           	

      },
      created(){
         //데이터 불러오는 영역   
         this.loadMember();
         this.followCheck();
         this.totalFollowCount();
         this.totalFollowerCount();
         this.followerList();
         this.followList();  
         this.boardList();
         //this.getTotalFollowCount();

      },
      watch:{
    	// percent가 변하면 percent의 값을 읽어와서 80% 이상인지 판정
    	percent(){
    		if(this.percent >= 80){
    			this.boardList();
    		}
    	},
    	
      },
      mounted(){   
			this.checkOwnerShip();
            this.modal = new bootstrap.Modal(this.$refs.modal03);
            this.addtionModal = new bootstrap.Modal(this.$refs.addtionModal);
            this.blockModal = new bootstrap.Modal(this.$refs.blockModal);
            this.blockResultModal = new bootstrap.Modal(this.$refs.blockResultModal);
            this.myOptionModal = new bootstrap.Modal(this.$refs.myOptionModal);
            this.followerModal = new bootstrap.Modal(this.$refs.followerModal);
            this.followModal = new bootstrap.Modal(this.$refs.followModal);
            
            window.addEventListener("scroll", _.throttle(()=>{
            	//console.log("스크롤 이벤트");
            	
            	// 스크롤은 몇 % 위치에 있는가?를 알고 싶다면 
           		// - 전체 문서의 높이(document.body.clientHeight)
           		// - 현재 스크롤의 위치 (window.scrollY)
           		// - 브라우저의 높이 (window.innerHeight)
            const height = document.documentElement.scrollHeight - window.innerHeight;
			const current = window.scrollY;
			const percent = (current / height) * 100;

           		//console.log("percent = " + Math.round(percent));
           		
           		// data의 percent를 계산된 값으로 갱신
           		this.percent = Math.round(percent);
            },250));
      },
   }).mount("#app");
</script>
<%@ include file="../template/footer.jsp" %>