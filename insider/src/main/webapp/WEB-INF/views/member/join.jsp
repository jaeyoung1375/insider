<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>	
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/static/css/commons.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<!-- font-awesome cdn -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"/>
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
    			.nonHide{
    			display:block;
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
		
		.input-container {
  position: relative;
}

.input-wrapper {
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  border-radius: 4px;
  overflow: hidden;
}

.input-wrapper input {
  flex-grow: 1;
  border: none;
  padding: 8px;
}

.input-wrapper button {
  background-color: #f1f1f1;
  border: none;
  padding: 25px;
  cursor: pointer;
}
.timer {
	position:absolute;
	right : 0;
	bottom : 0;
	margin-bottom:30px;
	margin-right:10px;
	
	
}
.gender-buttons {
  display: flex;
  justify-content: center;
  align-items: center;
}

.gender-button {
  flex: 1;
  padding: 10px;
  border: none;
  font-size: 16px;
  cursor: pointer;
}

.gender-button.active {
  background-color: #3f51b5;
  color: #fff;
}

.gender-button:not(.active) {
  background-color: #fff;
  color: #3f51b5;
  border: 1px solid #3f51b5;
  margin: 0 10px;
}

@media (max-width: 480px) {
  .gender-buttons {
    flex-wrap: wrap;
  }

  .gender-button {
    flex: none;
    width: 50%;
    margin: 10px 0;
  }

  .gender-button:not(.active) {
    margin: 0;
  }
}


</style>
	</head>
	<body>
			
	        <form action="join" method="post"  ref="joinForm" id="app">
	    <div class="container col-lg-3 card p-5 mt-5">
	    
	   		<!-- 1단계 -->
	            <div class="text-center mb-3">         	
			         	<a href="/" class="logo"><img src="/static/image/logo.png" width="50" height="50" class="me-3">insider</a>
	                </div>
	        <div :class="{hide:stepOneHidden}">
	            <div class="row form-floating mb-3"> 
	                <input class="form-control" type="text" name="memberEmail" placeholder="이메일" v-model="email" @blur="validateEmail" @keyup="isEmailDuplicatedCheck(email)" :class="{'is-valid' : !showEmailWarning && !isEmailDuplicated  && email.length > 10,'is-invalid': showEmailWarning || isEmailDuplicated }">
	                    <label for="floatingInput">이메일 주소 <span style="color:red;">*</span></label>
	                <p v-if="showEmailWarning" class="email-warning-message">유효하지 않은 이메일입니다</p>
	                <p v-if="isEmailDuplicated" class="email-warning-message">중복된 이메일 입니다</p>
	            </div>
	            <div class="row form-floating mb-3">
	                <input class="form-control" type="text" name="memberName" placeholder="성명" v-model="name" @blur="validateName" :class="{'is-valid': name !== '' && !showNameWarning, 'is-invalid': (name === '' && showNameWarning) || (name !== '' && showNameWarning)}">
	                 <label for="floatingInput">성명 <span style="color:red;">*</span></label>
	                <p v-if="showNameWarning" class="name-warning-message">2~10자 한글, 영문 대소문자, 숫자, 특수문자를 사용하세요.</p>
	            </div>
	            <div class="row form-floating mb-3">
	                <input class="form-control" type="text" name="memberNick" placeholder="닉네임" v-model="nickname" @blur="validateNick" @keyup="isNickDuplicatedCheck(nickname)" @input="nickname = $event.target.value" :class="{'is-valid' : !showNickWarning && !isNickDuplicated && nickname != '','is-invalid': showNickWarning || isNickDuplicated }">
	                 <label for="floatingInput">닉네임 <span style="color:red;">*</span></label>
	                <p v-if="showNickWarning" class="nick-warning-message">2~10자 한글, 영문 대소문자, 숫자, 특수문자를 사용하세요.</p>
	                <p v-if="isNickDuplicated" class="email-warning-message">중복된 닉네임 입니다</p>
	            </div>
	            <div class="row form-floating mb-3">
	                <input class="form-control" type="password" name="memberPassword" placeholder="비밀번호" v-model="password" @blur="validatePassword" :class="{'is-valid' : password != '' && !showPasswordWarning, 'is-invalid' : showPasswordWarning }">
	                 <label for="floatingInput">비밀번호<span style="color:red;">*</span></label>
	                <p v-if="showPasswordWarning" class="password-warning-message">8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</p>
	
	            </div>
	             <div class="row form-floating mb-3">
	                <input class="form-control" type="password" placeholder="비밀번호 확인" v-model="passwordCk" @blur="validatePasswordCk" :class="{'is-valid' : !showPasswordCkWarning && password == passwordCk && passwordCk != '', 'is-invalid' : showPasswordCkWarning}">
	                 <label for="floatingInput">비밀번호 확인 <span style="color:red;">*</span></label>
	                <p v-if="showPasswordCkWarning" class="passwordCk-warning-message">비밀번호가 일치하지 않습니다.</p>
	            </div>
	              <div class="row form-floating mb-3">
	                <input class="form-control" type="text" name="memberTel" v-model="tel" @blur="validateTel" :class="{'is-valid': !showTelWarning && tel !== '', 'is-invalid': showTelWarning || (tel === '' && showTelWarning)}">
	                 <label for="floatingInput">전화번호 <span style="color:red;">*</span></label>
	                <p v-if="showTelWarning" class="tel-warning-message">유효한 휴대폰번호를 입력해주세요. (예: 010-1234-5678)</p>
	            </div>
	            	<div class="row form-floating mb-3">
	            		 <button type="button" class="btn btn-primary" @click="StepOneSubmit">다음</button>
	            	 </div>
	            </div>
	            <!-- 1단계 끝 -->
	            
	            <!-- 2단계 -->
	            <div :class="{hide: !stepOneHidden || stepTwoHidden}">
	            
	            <!-- 생년월일 -->
	           <div class ="bir_wrap mb-3">
	                <div class="bir_yy">
	                    <span class="ps_box">	               
	                      <select v-model="selectedYear" id="year" class="form-select" @blur="saveMemberBirth">
	                      	 <option v-for="year in years" :value="year">{{ year }}</option>
	                      </select>
	                    </span>
	                </div>
	                <div class="bir_mm">
	                    <span class="ps_box focus">
	                        <select class="form-select" id="month" id="exampleSelect1" @blur="saveMemberBirth" v-model="selectedMonth">
	                            <option v-for="month in months" :value="month">{{ month }}월</option>
	                         </select>
	                    </span>
	                </div>
	                <div class="bir_dd">
	                    <span class="ps_box">
	                    <select class="form-select" id="day" id="exampleSelect1" @blur="saveMemberBirth" v-model="selectedDay">
	                            <option v-for="day in days" :value="day">{{ day }}</option>
	                         </select>
	                    </span>
	                </div>
	                <input type="hidden" name="memberBirth" v-model="formattedMemberBirth">
	            </div>
	            
	            
	          <!--  <div class="mb-3 row">
	                        <select class="form-select" v-model="gender" name="memberGender">
	                        	<option value="">성별</option>
	                            <option value="0">남성</option>
	                            <option value="1">여성</option>
	                         </select>
	           </div> -->
<div class="gender-buttons">
  <button type="button" class="gender-button active" data-gender="male" @click="selectGender(0)">남성</button>
  <button type="button" class="gender-button" data-gender="female" @click="selectGender(1)">여성</button>
</div>
<input type="hidden" name="memberGender" :value="gender">


	         <div class="mb-3 input-container">
  <div class="input-wrapper">
    <div class="input-group">
      <input type="text" name="memberPost" class="form-control mb-3" placeholder="우편번호" readonly v-model="post">
      <button type="button" class="btn btn-primary" @click="findAddress"><i class="fa-solid fa-magnifying-glass fa-lg"></i></button>
    </div>
  </div>
</div>
<div class="mb-3">
  <input type="text" name="memberBasicAddr" class="form-control" placeholder="기본주소" readonly v-model="basicAddr">
</div>
<div class="mb-3">
  <input type="text" name="memberDetailAddr" class="form-control" placeholder="상세주소" v-model="detailAddr">	    
</div>
	             <div class="row mb-3">
	            		 <button type="button" class="btn btn-primary" @click="StepTwoSubmit">다음</button>	 
	            </div>
	             <div class="row mb-3">
	            		 <button type="button" class="btn btn-primary" @click="prevBtn">이전으로</button>	 
	            </div>
	                     
	             </div>
	             <!-- 2단계 끝 -->
	             
	             <!-- 3단계 -->
	             <div :class="{hide :!stepThreeHidden}">
	              
	                <div class="text-center mb-3">         	
						<p>{{email}} 으로 전송된 인증번호를 입력하세요.</p>
	               </div>
	               <div class="form-floating mb-3">
	                <input type="text" class="form-control" placeholder="인증번호" v-model.number="emailCode" @blur="emailVerifyCode" ref="inputCode" >
	                 <span class="timer" :class="{'hide': !isDisabled }">
  					{{ Math.floor(count / 60) }}: {{ String(count % 60).padStart(2, '0') }}
  					</span>
	                 <p v-if="showEmailCodeWarning" class="tel-warning-message">인증번호가 일치하지 않습니다</p>
	             </div>
	             
	             
	                <div class="row mb-3">
	            		 <button type="submit" class="btn btn-primary" @click="handleSubmit">가입하기</button>	 
	            	</div>
	    
        </div>
	             	            				
	        </div>
	                   <div class="container col-lg-3 card p-3 mt-3" style="display:flex;">
        	<div class="text-center">
        		계정이 있으신가요??
        		<a href="login">로그인하기</a>
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
	                    num : '',
	                    nickname : '',
	                    password : '',
	                    passwordCk : '',
	                    tel : '',
	                    gender : "1",
	                    post : '',
	                    basicAddr : '',
	                    detailAddr : '',
	                    emailCode : '',
	                    showEmailWarning : false,
	                    showNameWarning : false,
	                    showNickWarning : false,
	                    showPasswordWarning : false,
	                    showPasswordCkWarning : false,
	                    showTelWarning : false,
	                    showEmailCodeWarning : false,
	                    memberBirth : '',
	                    formSubmit : false,
	                    isEmailDuplicated : false,
	                    isNickDuplicated : false,
	                    stepOneHidden : false,
	                    stepTwoHidden : false,
	                    stepThreeHidden : false,
	                    selectedYear: new Date().getFullYear(),
	                    selectedMonth: new Date().getMonth()+1,
	                    selectedDay: new Date().getDate(),
	                    isDisabled : false,
            			count : 0,
	                };
	            },
	            computed: {
	                formattedMemberBirth() {
	                	  const yy = this.selectedYear;
	            		  const MM = this.selectedMonth;
	            		  const dd = this.selectedDay;

	            		  this.memberBirth = yy + '/' + MM + '/' + dd;
	                	
	                	
	                  const parts = this.memberBirth.split('/'); // '/'로 분리된 연도, 월, 일
						console.log(parts);
	                  if (parts.length === 3) {
	                    const year = parts[0];
	                    const month = parts[1].padStart(2, '0'); // 월을 2자리로 맞추고 부족한 부분은 0으로 채움
	                    const day = parts[2].padStart(2, '0'); // 일을 2자리로 맞추고 부족한 부분은 0으로 채움

	                    return year + '/' + month + '/' + day;
	                  }

	                  return ''; // 형식에 맞지 않는 경우 빈 문자열 반환
	                },
	              years(){
	            	  const currentYear = new Date().getFullYear();
	                  const startYear = 1920; // 시작 연도
	                  const endYear = currentYear; // 종료 연도
	                  const years = [];
	                  for (let year = endYear; year >= startYear; year--) {
	                    years.push(year);
	                  }
	                  return years;
	              },
	              months(){
	            	  const currentMonth = new Date().getMonth();
	                  const startMonth = 1; // 시작 월
	                  const endMonth = 12; // 종료 월
	                  const months = [];
	                  for (let month = startMonth; month <= endMonth; month++) {
	                    months.push(month);
	                  }
	                  return months;
	              },
	              days(){
	            	  const currentday = new Date().getDay();
	                  const startDay = 1; // 시작 일
	                  const endDay= 31; // 종료 일
	                  const days = [];
	                  for (let day = startDay; day <= endDay; day++) {
	                    days.push(day);
	                  }
	                  return days;
	              },	              	                  
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
	                    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%^*?&])[A-Za-z\d@$#^!%*?&]{8,16}$/;
	
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
	                StepOneSubmit(){
	                	   if(this.showEmailWarning || this.email == "" ||
	      	                     this.showNameWarning || this.name == "" ||
	      	                        this.showNickWarning || this.nickname == "" ||
	      	                        this.showPasswordCkWarning || this.passwordCk == "" ||
	      	                        this.showPasswordWarning || this.password == "" || 
	      	                        this.showTelWarning || this.tel == "" || this.isEmailDuplicated == true || this.isNickDuplicated == true){
	      	                         return;
	                	   }
	                	   this.stepOneHidden = true;  	
	                },
	                StepTwoSubmit(){ 	
	                	if(this.gender == "" || this.post == "" || this.basicAddr == "" ||
	                		this.detailAddr == ""){
	                		return;
	                	}
	                	   this.stepOneHidden = true;
	                	   this.stepTwoHidden = true;
	                	   this.stepThreeHidden = true;
	                	   this.sendEmail(this.email);
	                	   this.$nextTick(() => {
	                	        // 다음 Vue 루프에서 실행되도록 설정
	                	        this.$refs.inputCode.focus(); // 입력란에 포커스 설정
	                	      });
	                	 
	                },
	                goBackStepOne(){
	                	this.stepOneHidden = false;
	                	this.stepTwoHidden = true;
	                },           
	                handleSubmit(event){
	                     if(this.showEmailWarning || this.email == "" ||
	                     this.showNameWarning || this.name == "" ||
	                        this.showNickWarning || this.nickname == "" ||
	                        this.showPasswordCkWarning || this.passwordCk == "" ||
	                        this.showPasswordWarning || this.password == "" || 
	                        this.showTelWarning || this.tel == "" || this.gender == "" ||
	                        this.post == "" || this.basicAddr == "" || this.detailAddr == "" || 
	                        this.isEmailDuplicated || this.isNickDuplicated ||
	                        this.showEmailCodeWarning){
	                    	 event.preventDefault();
	                         return;
	                    }
	                       this.stepOneHidden = true;	
	                      this.$refs.joinForm.submit();
	         
	                },
	                selectGender(gender){
	                	this.gender = gender;
	                },
	                async isEmailDuplicatedCheck(memberEmail){
	                	try{
	                		const response = await axios.get("emailCheck",{
	                			params : {
	                				memberEmail : this.email
	                			}	                	
	                		});
	                	
	                	this.isEmailDuplicated = response.data === "fail";
	             
	                	}catch(error){
	                		console.error(error);
	                	}
	                	
	                },
	                
	                async isNickDuplicatedCheck(memberNick){
	                	try{
	                		const response = await axios.get("nickCheck",{
	                			params : {
	                				memberNick : this.nickname
	                			}			
	                		});
	                	
	                	this.isNickDuplicated = response.data === "fail";
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
	                
	                async sendEmail(memberEmail){	     			       		
	     				const response = await axios.get("sendMail",{
	     					params : {
	     						memberEmail : this.email
	     					}
	     				});
	     				// 인증번호
	     				this.num = response.data;
	     				// num을 다른메서드에서 쓰기 위함
	     				this.emailVerifyCode();
	     				
						this.isDisabled = true;
	     				this.count = 299;
	     				this.timer = setInterval(() => {
	     					this.count--;
	     					 if (this.count === 0) {
	     				        clearInterval(this.timer); // 타이머 종료
	     				        this.emailCode == '';
	     				      }
	     				},1000);
	     				
	                },
	                
	                emailVerifyCode(){
	                	console.log(this.num);
	                	if(this.num != this.emailCode){
	                		this.showEmailCodeWarning = true;
	                	}else{
	                		this.showEmailCodeWarning = false;
	                	}
		                	
	                },
	          		prevBtn(){
	                	this.stepOneHidden = false;
	                	
	                },    
	          
	            },	      
	        });
	        app.mount("#app");
	    </script>
	
	</body>
	</html>