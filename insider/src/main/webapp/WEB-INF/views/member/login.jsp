<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		        <div class="container col-lg-3 card p-5 mt-5" style="display:flex; justify-content: center">
		        <div>
		         <div class="text-center mb-3">         	
		         	<a href="/" class="logo"><img src="/static/image/logo.png" width="50px" height="50px" class="me-3">insider</a>
                </div>
            <form action="login" method="post">
                <div class="mb-3 row">
                    <input class="form-control" type="text" name="memberEmail" placeholder="이메일 입력">
                </div>
                <div class="mb-3 row">
                    <input class="form-control" type="password" name="memberPassword" placeholder="비밀번호 입력">
                </div>
                <div class="row mb-3">
                    <button class="btn btn-primary" type="submit">로그인</button>
                </div>             
            </form>          
            	<div style="display:flex; justify-content: space-between; flex-direction: column; align-items: center;" >
            	 <div class="row mb-3">
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=1b308937b1aec37f7b4bc57faeb4931b&redirect_uri=	
			http://localhost:8080/member/auth/kakao/callback&
			response_type=code&scope=account_email,gender,age_range&prompt=login">
            	 <img src="/static/image/social/kakao_login.png">
            </a>
            </div>
             <div class="row mb-3">
             <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=197694978566-bljc0eo7lnf071parv36ntrenp3g69eb.apps.googleusercontent.com&
				redirect_uri=http://localhost:8080/member/login/oauth_google_check&response_type=code
				&scope=email%20profile%20openid
				&access_type=offline&prompt=login">
            	 <img src="/static/image/social/google_login.png">
            </a>
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
	        소셜유저 : ${sessionScope.socialUser}, 멤버 : ${sessionScope.member}			
        </div>
</body>
</html>