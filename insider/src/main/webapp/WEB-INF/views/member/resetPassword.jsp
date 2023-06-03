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
      <h2 class="form-title">신규 비밀번호 입력</h2>
      <div class="form-group">
        <label for="newPassword">신규 비밀번호</label>
        <input type="password" id="newPassword" v-model="newPassword" required>
      </div>
      <div class="form-group">
        <label for="confirmPassword">비밀번호 확인</label>
        <input type="password" id="confirmPassword" v-model="confirmPassword" required>
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
            			newPassword : '',
            			confirmPassword : '',
                    };
                },
            
                computed:{
                   
                },
                methods:{
                	async passwordChange(){
                		
                	if (this.newPassword !== this.confirmPassword) {
                        alert('비밀번호가 일치하지 않습니다.');
                        return;
                     }
                	
                	
                	 try {
                	        const response = await axios.post('/member/passwordChange', {
                	          memberEmail: this.email,
                	          memberPassword: this.newPassword,
                	        });
                		
                		window.location.href="/";
                		
                	
                		
                	}catch(error){
                		console.log("error : "+error);
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