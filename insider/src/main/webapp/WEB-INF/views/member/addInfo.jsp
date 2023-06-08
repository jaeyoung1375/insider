<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jquery cdn -->
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
               
        .select {
    padding: 15px 10px;
}
.select input[type=radio]{
    display: none;
}
.select input[type=radio]+label{
    display: inline-block;
    cursor: pointer;
    height: 24px;
    width: 90px;
    border: 1px solid #333;
    line-height: 24px;
    text-align: center;
    font-weight:bold;
    font-size:13px;
}
.select input[type=radio]+label{
    background-color: #fff;
    color: #333;
}
.select input[type=radio]:checked+label{
    background-color: #333;
    color: #fff;
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

        </style>  
        <div class="container col-lg-3 card p-5 mt-5" id="app">
<h1 class="text-center">추가정보 입력</h1>
<form action="addInfo" method="post" ref="joinForm">
<input type="hidden" name="memberNo" value="${loginUser.memberNo}">
<input type="hidden" name="memberPassword" value="${loginUser.memberPassword}">
<input type="hidden" name="memberEmail" value="${loginUser.memberEmail}">

<!-- 
				 <div class="text-center mb-3">
	                 <input type="radio" id="select1" name="memberGender" value="0" class="btn-check" v-model="gender">
	                 <label class="btn btn-outline-danger" for="select1">남성</label>
	    			 <input type="radio" id="select2" name="memberGender" value="1" class="btn-check" v-model="gender">
	    			 <label class="btn btn-outline-danger" for="select2">여성</label>
	            </div>
	            -->
	            


  <div class="row form-floating mb-3">  				
	                <input class="form-control" type="text" name="memberName" placeholder="성명" v-model="name" @blur="validateName" :class="{'is-valid': name !== '' && !showNameWarning, 'is-invalid': (name === '' && showNameWarning) || (name !== '' && showNameWarning)}">
	                  <label for="floatingInput">이름 <span style="color:red;">*</span></label>
	                <p v-if="showNameWarning" class="name-warning-message">2~10자 한글, 영문 대소문자, 숫자, 특수문자를 사용하세요.</p>
	            </div>
	            <div class="row form-floating mb-3">
	                <input class="form-control" type="text" name="memberNick" placeholder="닉네임" v-model="nickname" @blur="validateNick" @keyup="isNickDuplicatedCheck(nickname)" @input="nickname = $event.target.value" :class="{'is-valid' : !showNickWarning && !isNickDuplicated && nickname != '','is-invalid': showNickWarning || isNickDuplicated }">
	                  <label for="floatingInput">닉네임<span style="color:red;">*</span></label>
	                <p v-if="showNickWarning" class="nick-warning-message">2~10자 한글, 영문 대소문자, 숫자, 특수문자를 사용하세요.</p>
	                <p v-if="isNickDuplicated" class="email-warning-message">중복된 닉네임 입니다</p>
	            </div>
	            
	            <div class="row form-floating mb-3">
	                        <select class="form-select" v-model="gender" name="memberGender">
	                        
	                        	<option value="">성별</option>
	                            <option value="0">남성</option>
	                            <option value="1">여성</option>
	                         </select>
	                </div>

 

   <div class="row form-floating mb-3">
	                <input class="form-control" type="text" name="memberTel" placeholder="전화번호" v-model="tel" @blur="validateTel" :class="{'is-valid': !showTelWarning && tel !== '', 'is-invalid': showTelWarning || (tel === '' && showTelWarning)}">
	                  <label for="floatingInput">전화번호<span style="color:red;">*</span></label>
	                <p v-if="showTelWarning" class="tel-warning-message">유효한 휴대폰번호를 입력해주세요. (예: 010-1234-5678)</p>
	            </div>
           <div class ="bir_wrap mb-3">
	                <div class="bir_yy">
	                    <span class="ps_box">
	                    <!-- 
	                        <input type="text" class="form-control" id="year" placeholder="년(4자)" maxlength="4" @blur="saveMemberBirth">
	                     -->
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
   			<div class="mb-3 input-container row form-floating">
   					<div class="input-wrapper">
	                <input type="text" name="memberPost" class="form-control mb-3" placeholder="우편번호" readonly v-model="post">
	                <button type="button"  @click="findAddress"><i class="fa-solid fa-magnifying-glass fa-xl"></i></button>
   					</div>
	       </div>
	             <div class="row form-floating mb-3">
	                <input type="text" name="memberBasicAddr" class="form-control" placeholder="기본주소" readonly v-model="basicAddr">
	                  <label for="floatingInput">기본주소 <span style="color:red;">*</span></label>
	             </div>
	             <div class="row form-floating mb-3">
	                <input type="text" name="memberDetailAddr" class="form-control" placeholder="상세주소" v-model="detailAddr">	 
	                  <label for="floatingInput">상세 주소 <span style="color:red;">*</span></label>   
	             </div>
	             <div class="row form-floating mb-3">
	            		 <button type="button" class="btn btn-primary" @click="handleSubmit">가입하기</button>	 
	            </div>
</form>
</div>


	    <script src="https://unpkg.com/vue@3.2.36"></script>
	    <script>
	
	      const app = Vue.createApp({
	            // 데이터 설정 영역
	            data(){
	                return {
	                    name : '',     
	                    nickname : '',
	                    tel : '',
	                    gender : '',
	                    post : '',
	                    basicAddr : '',
	                    detailAddr : '',
	                    showNameWarning : false,
	                    showNickWarning : false,
	                    showTelWarning : false,
	                    memberBirth : '',
	                    isNickDuplicated : false,
	                    selectedYear: new Date().getFullYear(),
	                    selectedMonth: new Date().getMonth()+1,
	                    selectedDay: new Date().getDate(),
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
	             
	                validateTel(){
	                    const telRegex = /^01[0-9]{1}-?[0-9]{3,4}-?[0-9]{4}$/;
	                    if(telRegex.test(this.tel)){
	                        this.showTelWarning = false;
	                    }else{
	                        this.showTelWarning = true;
	                    }
	                    
	                },
	                
                       
	                handleSubmit(event){
	
	                     if(this.showNameWarning || this.name == "" ||
	                        this.showNickWarning || this.nickname == "" ||
	                        this.showTelWarning || this.tel == "" || this.gender == "" ||
	                        this.post == "" || this.basicAddr == "" || this.detailAddr == "" || 
	                       this.isNickDuplicated){
	                    	 event.preventDefault();
	                         return;
	                    }

	                      this.$refs.joinForm.submit();
	         
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

	            },
	            watch: {
	           
	               
	            },
	        });
	        app.mount("#app");
	    </script>
	
