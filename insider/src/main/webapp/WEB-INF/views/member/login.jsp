<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.kh.insider.configuration.*" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%
// ApplicationContext를 가져옵니다.
ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(application);

// KakaoLoginProperties 빈을 가져옵니다.
KakaoLoginProperties kakaoProperties = context.getBean(KakaoLoginProperties.class);
GoogleLoginProperties googleProperties = context.getBean(GoogleLoginProperties.class);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/static/css/commons.css">
<!-- BootStrap CDN -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
   <style>
   .logo{
      font-size: 50px;
      color: black;
      text-decoration: none;
   }
   </style>
</head>      
<body>

              <div class="container col-lg-3 card p-5 mt-5" style="display:flex; justify-content: center" id="app">
              <div>
               <div class="text-center mb-3">            
                  <a href="/" class="logo"><img src="/static/image/insider2.png" style="width:200px; height:80px;" ></a>
                </div>
            <form action="login" method="post" @submit="isEmpty" >
                <div class="mb-3 row">
                    <input class="form-control" type="text" name="memberEmail" placeholder="이메일 입력" v-model="email">
                </div>
                <div class="mb-3 row">
                    <input class="form-control" type="password" name="memberPassword" placeholder="비밀번호 입력" v-model="password">
                </div>
                <div class="mb-3 row">
                    <p v-if="showEmptyWarning" class="email-warning-message">아이디 혹은 비밀번호를 입력해주세요</p>
                     <p v-if="${result == 0} && !showEmptyWarning">아이디 혹은 비밀번호를 일치하지 않습니다 </p>   
                </div>	
                <div class="row mb-3">
                    <button class="btn btn-primary" type="submit">로그인</button>
                </div> 
                  
            </form>          
               <div style="display:flex; justify-content: space-between; flex-direction: column; align-items: center;" >
                <div class="row mb-3">
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=<%=kakaoProperties.getClientId()%>&redirect_uri=	
http://khds-c.iptime.org:18085/kakao/login&response_type=code&prompt=login">
                <img src="/static/image/social/kakao_login.png">
            </a>
            </div>
             <div class="row text-center">
                   <a class="mt-5" href="/member/passwordSearch">비밀번호를 잊으셨나요?</a>
                </div>         
         <!--  
            <div class="row mb-3">
            <a href="https://www.facebook.com/v2.11/dialog/oauth?
client_id=1721778684918582&
redirect_uri=https://localhost:8080/member/facebook/auth&scope=public_profile,email&prompt=login"><img src="/static/image/social/facebook_login.png" width="183" height="45" ></a>
            </div>
            -->
            </div>
           </div>
        </div>
        <div class="container col-lg-3 card p-3 mt-3" style="display:flex;">
           <div class="text-center">
              계정이 없으신가요?
              <a href="join">가입하기</a>
           </div>
        </div>

        <div>
           소셜유저 : ${sessionScope.socialUser}, 멤버 : ${sessionScope.member} , 세션번호 : ${sessionScope.memberNo}         
        </div>





        <script src="https://unpkg.com/vue@3.2.36"></script>
        <script>
       
          const app = Vue.createApp({
                // 데이터 설정 영역
                data(){
                    return {
                      email : '',
                      password : '',
                      
                      showEmptyWarning : false,
                      showInvalidWarning : false,
                    };
                },
            
                computed:{
                   
                },
                methods:{
                    isEmpty(event){
                        if(this.email == '' || this.password == ''){
                            event.preventDefault();
                            this.showEmptyWarning = true;
                        }else{
                           this.showEmptyWarning = false;
                        }
                    },
                  
                },
                watch:{
    
                },
            });
            app.mount("#app");
        </script>
      

</body>
</html>