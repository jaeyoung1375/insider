<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../template/header.jsp" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js" integrity="sha512-E8QSvWZ0eCLGk4km3hxSsNmGWbLtSCSUcewDQPQWZF6pEU8GlT8a5fF32wOl1i8ftdMhssTrF/OhyGWwonTcXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<style>
#app {
  display: flex;
  justify-content: center;
  align-items: center;
  
}

.password-reset-container {
  max-width: 400px;
  width: 100%;
  padding: 20px;
}

.password-reset-form {
  background-color: #ffffff;
  border-radius: 10px;
  padding: 30px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-title {
  font-size: 24px;
  color: #333333;
  margin-bottom: 30px;
  text-align: center;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  font-size: 16px;
  color: #333333;
  margin-bottom: 10px;
}

.form-group input {
  width: 100%;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #cccccc;
  border-radius: 5px;
  transition: border-color 0.3s;
}

.form-group input:focus {
  outline: none;
  border-color: #5c7cfa;
}

.btn-submit {
  display: block;
  width: 100%;
  padding: 12px;
  background-color: #5c7cfa;
  color: #ffffff;
  font-size: 16px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.btn-submit:hover {
  background-color: #4c6ef5;
}

.btn-submit:active {
  background-color: #435ce4;
}


</style>
<div id="app">
  <div class="password-reset-container">
    <div class="password-reset-form">
       <div class="row form-floating mb-3">
	                <input class="form-control" type="password" name="memberPassword" placeholder="비밀번호" v-model="password" @blur="validatePassword" :class="{'is-valid' : password != '' && !showPasswordWarning, 'is-invalid' : showPasswordWarning }">
	                 <label for="floatingInput">신규 비밀번호<span style="color:red;">*</span></label>
	                <p v-if="showPasswordWarning" class="password-warning-message">8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</p>
	
	            </div>
	             <div class="row form-floating mb-3">
	                <input class="form-control" type="password" placeholder="비밀번호 확인" v-model="passwordCk" @blur="validatePasswordCk" :class="{'is-valid' : !showPasswordCkWarning && password == passwordCk && passwordCk != '', 'is-invalid' : showPasswordCkWarning}">
	                 <label for="floatingInput">비밀번호 확인 <span style="color:red;">*</span></label>
	                <p v-if="showPasswordCkWarning" class="passwordCk-warning-message">비밀번호가 일치하지 않습니다.</p>
	            </div>
      <button class="btn-submit" @click="passwordChange">확인</button>
    </div>
  </div>
</div>


 <script src="https://unpkg.com/vue@3.2.36"></script>
        <script>
    	
          const app = Vue.createApp({
                // 데이터 설정 영역
                data(){
                    return {
            			email : '',
            			password : '',
  	                    passwordCk : '',
  	                  showPasswordWarning : false,
	                    showPasswordCkWarning : false,
                    };
                },
            
                computed:{
                   
                },
                methods:{
                	async passwordChange(){
                		
                	if (this.password !== this.passwordCk) {
                        alert('비밀번호가 일치하지 않습니다.');
                        return;
                     }
                	
                	
                	 try {
                	        const response = await axios.post('/member/passwordChange', {
                	          memberEmail: this.email,
                	          memberPassword: this.password,
                	        });
                		
                		window.location.href="/member/login";
                		
                	
                		
                	}catch(error){
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
                
                },
                watch:{
                	
                	
                },
                created(){
                	  const urlParams = new URLSearchParams(window.location.search);
                	  const token = urlParams.get('token');
                	  const encodedEmail = urlParams.get('email');
                	// CryptoJS 라이브러리를 사용하여 이메일 복호화
                	const decryptedEmail = CryptoJS.AES.decrypt(encodedEmail, 'encryptionKey').toString(CryptoJS.enc.Utf8);
                	this.email = decryptedEmail;
                },
       
            });
            app.mount("#app");
        </script>