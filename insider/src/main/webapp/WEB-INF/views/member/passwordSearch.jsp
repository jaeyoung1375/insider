<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js" integrity="sha512-E8QSvWZ0eCLGk4km3hxSsNmGWbLtSCSUcewDQPQWZF6pEU8GlT8a5fF32wOl1i8ftdMhssTrF/OhyGWwonTcXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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

/* CSS */
.input-group {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  max-width: 300px;
  margin: 0 auto;
}

.input-group .form-control {
  width: 40px;
  height: 40px;
  text-align: center;
  font-size: 18px;
  padding: 0;
}

.input-group .form-control:focus {
  box-shadow: none;
  border-color: #ced4da;
}

.input-group .form-control:nth-child(n+2) {
  margin-left: 10px;
}

.input-group .form-control:last-child {
  margin-right: 0;
}

</style>

<%@include file="../template/header.jsp" %>
		<div class="container col-lg-5 card p-5 mt-5" style="display:flex; justify-content: center;" id="app">
		
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
	            </div>
	            
	             <div class="row mb-3">
	            	<button type="button" class="btn btn-primary" @click="sendEmail(email)" :disabled="isDisabled">전송</button>	 
	            </div>
	    
	            
			<div>
			</div>
			
		</div>
		    <div class="container col-lg-5 card p-4 mt-5" style="display:flex;">
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
            			isDisabled : false,
            			count : 0,
            			encryptedEmail: '',
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
   						this.isDisabled = true;
   						
   						this.count = 299;
	     				this.timer = setInterval(() => {
	     					this.count--;
	     					 if (this.count === 0) {
	     				        clearInterval(this.timer); // 타이머 종료
	     				       this.emailCode == '';
	     				      }
	     				},1000);
   						
	     				const response = await axios.get("sendMail",{
	     					params : {
	     						memberEmail : this.email
	     					}
	     				});
	     				
	     				 // CryptoJS 라이브러리를 사용하여 이메일 암호화
	     	              this.encryptedEmail = CryptoJS.AES.encrypt(this.email, 'encryptionKey').toString();
	     				// 인증번호
	     				this.num = response.data;
	     				// num을 다른메서드에서 쓰기 위함
	     				this.emailVerifyCode();
	     				
	     				
	     			
	                },
	                emailVerifyCode(){
	  	   	   
   	                	if(this.num == this.emailCode){
   	                		this.showEmailCodeWarning = true;
   	                		const certDto = {
   	                			secret : this.num,
   	                			email : this.email
   	                		};
   	                		axios.post("/member/checkCert",certDto)
   	                		.then(response => {
   	                			if(response.data === 'Y'){
   	                				window.location.href= this.getResetPasswordUrl();
   	                				
   	                			}
   	                		}).catch(error => {
   	                			console.error(error);
   	                		});
   	                
   	                	}else{
   	                		this.showEmailCodeWarning = false;
   	                	}
   		                	
   	                },
   	                getResetPasswordUrl(){
   	              // 임시 토큰 생성
   	                 const tokenArray = new Uint8Array(16);
   	                 window.crypto.getRandomValues(tokenArray);
   	                 const token = Array.from(tokenArray, byte => byte.toString(16).padStart(2, '0')).join('');
   	                 
   	           	 
   	              const resetPasswordUrl = '/member/resetPassword?token=' + encodeURIComponent(token) + '&email=' + encodeURIComponent(this.encryptedEmail);
   	              // 토큰과 이메일을 매개변수로 사용하여 비밀번호 재설정 URL 생성

   	              return resetPasswordUrl;
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