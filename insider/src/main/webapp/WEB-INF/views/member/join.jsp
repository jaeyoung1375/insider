	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/static/css/commons.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/static/css/member/join.css">
	  <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
	 <!-- jquery cdn -->
	  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	 
	 <!-- 다음 우편 API 사용을 위한 CDN -->
	<script src="https://cdn.jsdelivr.net/gh/hiphop5782/daum-post-api@latest/find-address.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	    <style>
	        .map {
	            width:100%;
	            min-height: 300px;/* 50vh */
	        }
	            .hide{
       		 display:none;
    			}
   
	       
	
	.logo{
			font-size: 50px;
			color: black;
			text-decoration: none;
		}
	  
		.bir_yy,.bir_mm,.bir_dd{
			width:160px;
			display:table-cell;
		}
		.bir_mm+.bir_dd, .bir_yy+.bir_mm{
			padding-left:10px;
		}
	    </style>
	
	
	</head>
	<body>
			
	        <form action="join" method="post"  ref="joinForm" id="app">
	    <div class="container col-lg-3 card p-5 mt-5">
	        <div :class="{hide:stepOneHidden}">
	            <div class="text-center mb-3">         	
			         	<a href="/" class="logo"><img src="/static/image/logo.png" width="50px" height="50px" class="me-3">insider</a>
	                </div>
	            <div class="mb-3 row"> 
	                <input class="form-control" type="text" name="memberEmail" placeholder="이메일" v-model="email" @blur="validateEmail" @keyup="isEmailDuplicated(email)">
	                <p v-if="showEmailWarning" class="email-warning-message">유효하지 않은 이메일입니다</p>
	                <p v-if="isDuplicated" class="email-warning-message">중복된 이메일 입니다</p>
	            </div>
	            <div class="mb-3 row">
	                <input class="form-control" type="text" name="memberName" placeholder="성명" v-model="name" @blur="validateName">
	                <p v-if="showNameWarning" class="name-warning-message">2~10자 한글, 영문 대소문자, 숫자, 특수문자를 사용하세요.</p>
	            </div>
	            <div class="mb-3 row">
	                <input class="form-control" type="text" name="memberNick" placeholder="닉네임" v-model="nickname" @blur="validateNick">
	                <p v-if="showNickWarning" class="nick-warning-message">2~10자 한글, 영문 대소문자, 숫자, 특수문자를 사용하세요.</p>
	            </div>
	            <div class="mb-3 row">
	                <input class="form-control" type="password" name="memberPassword" placeholder="비밀번호" v-model="password" @blur="validatePassword">
	                <p v-if="showPasswordWarning" class="password-warning-message">8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</p>
	
	            </div>
	             <div class="mb-3 row">
	                <input class="form-control" type="password" placeholder="비밀번호 확인" v-model="passwordCk" @blur="validatePasswordCk">
	                <p v-if="showPasswordCkWarning" class="passwordCk-warning-message">비밀번호가 일치하지 않습니다.</p>
	            </div>
	              <div class="mb-3 row">
	                <input class="form-control" type="text" name="memberTel" placeholder="전화번호" v-model="tel" @blur="validateTel">
	                <p v-if="showTelWarning" class="tel-warning-message">유효한 휴대폰번호를 입력해주세요. (예: 010-1234-5678)</p>
	            </div>
	            </div>
	            
	            <div class ="bir_wrap mb-3  ">
	                <label class="form-label mt-4">생년월일</label>
	                <div class="bir_yy">
	                    <span class="ps_box">
	                        <input type="text" class="form-control" id="year" placeholder="년(4자)" maxlength="4" @blur="saveMemberBirth">
	                    </span>
	                </div>
	                <div class="bir_mm">
	                    <span class="ps_box focus">
	                        <select class="form-select" id="month" id="exampleSelect1" @blur="saveMemberBirth">
	                            <option>월</option>
	                            <option>01</option>
	                            <option>02</option>
	                            <option>03</option>
	                            <option>04</option>
	                            <option>05</option>
	                            <option>06</option>
	                            <option>07</option>
	                            <option>08</option>
	                            <option>09</option>
	                            <option>10</option>
	                            <option>11</option>
	                            <option>12</option>
	                         </select>
	                    </span>
	                </div>
	                <div class="bir_dd">
	                    <span class="ps_box">
	                        <input type ="text" class="form-control" id ="day" placeholder="일" maxlength="2" @blur="saveMemberBirth">
	                    </span>
	                </div>
	                <input type="hidden" name="memberBirth" v-model="memberBirth">
	            </div>
	            <div class="text-center mb-3">
	                 <input type="radio" id="select1" name="memberGender" value="0" class="btn-check" v-model="gender">
	                 <label class="btn btn-outline-danger" for="select1">남성</label>
	    			 <input type="radio" id="select2" name="memberGender" value="1" class="btn-check" v-model="gender">
	    			 <label class="btn btn-outline-danger" for="select2">여성</label>
	            </div>
	            <div class="mb-3">
	                <input type="text" name="memberPost" class="form-control mb-3" placeholder="우편번호" readonly v-model="post">
	                <button type="button"  @click="findAddress">우편번호 찾기</button>
	             </div>
	             <div class="mb-3">
	                <input type="text" name="memberBasicAddr" class="form-control" placeholder="기본주소" readonly v-model="basicAddr">
	             </div>
	             <div class="mb-3">
	                <input type="text" name="memberDetailAddr" class="form-control" placeholder="상세주소" v-model="detailAddr">
	    
	             </div>
	             <div class="row mb-3">
	                <button type="button" class="btn btn-primary" @click="handleSubmit">가입하기</button>
	             </div>
	
	
	        </div>
	    </form>
	
	
	    <script src="https://unpkg.com/vue@3.2.36"></script>
	    <script>
	
	      const app = Vue.createApp({
	            // 데이터 설정 영역
	            data(){
	                return {
	                    email : '',
	                    name : '',
	                    nickname : '',
	                    password : '',
	                    passwordCk : '',
	                    tel : '',
	                    gender : '',
	                    post : '',
	                    basicAddr : '',
	                    detailAddr : '',
	                    showEmailWarning : false,
	                    showNameWarning : false,
	                    showNickWarning : false,
	                    showPasswordWarning : false,
	                    showPasswordCkWarning : false,
	                    showTelWarning : false,
	                    memberBirth : '',
	                    formSubmit : false,
	                    isDuplicated : false,
	                    stepOneHidden : false,
	                    stepTwoHidden : true,
	                };
	            },
	        
	            computed:{
	               
	            },
	            methods:{
	
	            	saveMemberBirth() {
	            		  const year = $("#year").val();
	            		  const month = $("#month").val();
	            		  const day = $("#day").val();
	
	            		  this.memberBirth = year + '/' + month + '/' + day;
	            		  $("#memberBirth").val(this.memberBirth);
	            		},
	              
	 
	
	                validateEmail(){
	                    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	
	                    if (emailRegex.test(this.email)) {
	                       this.showEmailWarning = false;
	                    } else {
	                        this.showEmailWarning = true;
	                    }
	                },
	                validateName(){
	                    const nameRegex = /^[가-힣a-zA-Z0-9!@#$%^&*()\-_=+[{\]}\\|;:'",<.>/?]{2,10}$/;
	
	                    if(nameRegex.test(this.name)){
	                        this.showNameWarning = false;
	                    }else{
	                        this.showNameWarning = true;
	                    }
	                },
	                validateNick(){
	                    const nickRegex = /^[가-힣a-zA-Z0-9!@#$%^&*()\-_=+[{\]}\\|;:'",<.>/?]{2,10}$/;
	
	                    if(nickRegex.test(this.nickname)){
	                        this.showNickWarning = false;
	                    }else{
	                        this.showNickWarning = true;
	                    }
	                },
	                validatePassword(){
	                    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
	
	                    if(passwordRegex.test(this.password)){
	                        this.showPasswordWarning = false;
	                    }else{
	                        this.showPasswordWarning = true;
	                    }
	                },
	                validatePasswordCk(){
	
	                    if(this.password == this.passwordCk){
	                        this.showPasswordCkWarning = false;
	                    }else{
	                        this.showPasswordCkWarning = true;
	                    }
	                },
	                validateTel(){
	                    const telRegex = /^01[0-9]{1}-?[0-9]{3,4}-?[0-9]{4}$/;
	                    if(telRegex.test(this.tel)){
	                        this.showTelWarning = false;
	                    }else{
	                        this.showTelWarning = true;
	                    }
	                    
	                },
	                handleSubmit(){
	
	                     if(this.showEmailWarning || this.email == "" ||
	                     this.showNameWarning || this.name == "" ||
	                        this.showNickWarning || this.nickname == "" ||
	                        this.showPasswordCkWarning || this.passwordCk == "" ||
	                        this.showPasswordWarning || this.password == "" || 
	                        this.showTelWarning || this.tel == "" || this.gender == "" ||
	                        this.post == "" || this.basicAddr == "" || this.detailAddr == "" || this.isDuplicated == true){
	                         return;
	                    }
	
	                     //   this.formSubmit = true;
	                        this.stepOneHidden = true;	
	                      //  this.$refs.joinForm.submit(			);
	         
	                },
	                async isEmailDuplicated(memberEmail){
	                	try{
	                		const response = await axios.get("/member/emailCheck",{
	                			params : {
	                				memberEmail : memberEmail
	                			}	
	                	
	                		});
	 		
	                	this.isDuplicated = response.data === "fail";
	                	}catch(error){
	                		console.error(error);
	                	}
	                	
	                },
	                
	                findAddress() {
	                    new daum.Postcode({
	                        oncomplete: (data) => {
	                            this.post = data.zonecode; // 우편번호를 입력
	                            this.basicAddr = data.address; // 기본주소를 입력
	                        }
	                    }).open();
	                },
	
	
	            },
	            watch:{
	
	            },
	        });
	        app.mount("#app");
	    </script>
	
	</body>
	</html>