<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.timer {
	position:absolute;
	right : 0;
	bottom : 0;
	margin-bottom:15px;
	margin-right:10px;
	
	
}
.hide{
	display:none;
}
</style>

<%@include file="../template/header.jsp" %>
		<div class="container col-lg-4 card p-5 mt-5" style="display:flex; justify-content: center;" id="app">
		
			 <h5 class="card-title text-center">로그인에 문제가 있나요?</h5>
			 <div class="form-floating mb-3"> 
	                <input class="form-control" type="text" name="memberEmail" placeholder="이메일" v-model="email" @change="validateEmail"  :class="{'is-valid' : !showEmailWarning && email.length >10}">
	                    <label for="floatingInput">이메일 주소 <span style="color:red;">*</span></label>
	                <p v-if="showEmailWarning" class="email-warning-message">유효하지 않은 이메일입니다</p>
	            </div>
	            
	             <div class="form-floating mb-3" :class="{'hide' : !isDisabled}">
	                <input class="form-control" type="text" v-model.number="emailCode" placeholder="인증번호 입력" @change="emailVerifyCode">
	              <span class="timer" :class="{'hide': !isDisabled }">
  					{{ Math.floor(count / 60) }}: {{ String(count % 60).padStart(2, '0') }}
				  </span>
	                 <label for="floatingInput">인증번호 <span style="color:red;">*</span></label> 
	                <p v-if="showNameWarning" class="name-warning-message">2~10자 한글, 영문 대소문자, 숫자, 특수문자를 사용하세요.</p>
	            </div>
	            
	             <div class="row mb-3">
	            	<button type="button" class="btn btn-primary" @click="sendEmail(email)" :disabled="isDisabled"	>전송</button>	 
	            </div>
	            <div class="row mb-3">
	            	<button type="button" class="btn btn-primary" @click="createBtn" >비밀번호 생성</button>	 
	            </div>
	            
			<div>
			<p>임시 비밀번호 : {{tempPassword}}</p>
			</div>
			
		</div>
		    <div class="container col-lg-4 card p-4 mt-4" style="display:flex;">
	        	<div class="text-center">
	        		계정이 있으신가요??
	        		<a href="login">로그인하기</a>
	        	</div>
        	</div>
		
		
		 <script src="https://unpkg.com/vue@3.2.36"></script>
        <script>
    	
          const app = Vue.createApp({
                // 데이터 설정 영역
                data(){
                    return {
            			email : '',
            			emailCode : '',
            			num : '',
            			showEmailCodeWarning : false,
            			showEmailWarning : false,
            			tempPassword : '',
            			isDisabled : false,
            			count : 0,
                    };
                },
            
                computed:{
                   
                },
                methods:{
   					  async sendEmail(memberEmail){
	     			      
   						  if(this.showEmailWarning || this.email == ''){
   							  this.showEmailWarning = true;
   							  return;
   						  }
	     				
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
	  	   	   
   	                	if(this.num == this.emailCode){
   	                		this.showEmailCodeWarning = true;
   	                	}else{
   	                		this.showEmailCodeWarning = false;
   	                	}
   		                	
   	                },
   	                
   	                async createBtn(){
   	                	if(this.showEmailCodeWarning ){
   	                	
   	                	 const dto = {
   	                	      memberEmail: this.email
   	                	    };
   	                   	                	
   	                		const resp = await axios.post("/member/passwordChange",dto);
   	                		this.tempPassword = resp.data;
   	                		this.isDisabled = true;
   	                		
   	                		
   	                	}
   	                },
   	          
   	             validateEmail(){
   	                    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

   	                    if (emailRegex.test(this.email)) {
   	                       this.showEmailWarning = false;
   	                    } else {
   	                        this.showEmailWarning = true;
   	                    }
   	                },  
 
                },
                watch:{
                	emailCode(newVal){
                		this.emailVerifyCode();
                	}
                },
                
            
            });
            app.mount("#app");
        </script>
</body>
</html>