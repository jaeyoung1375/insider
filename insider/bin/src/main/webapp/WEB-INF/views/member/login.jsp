<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/static/css/commons.css">
</head>
<body>
		        <div class="container-600 center">
            <form action="login" method="post">
                <div class="row">
                    <input class="form-input w-50" type="text" name="memberEmail" placeholder="이메일 입력">
                </div>
                <div class="row">
                    <input class="form-input w-50" type="password" name="memberPassword" placeholder="비밀번호 입력">
                </div>
                <div class="row">
                    <button class="form-btn w-50 positive" type="submit">로그인</button>
                </div>             
            </form>
            	<div class="row">
            		<a class="form-btn w-50 negative" href="join">회원가입</a>
            	</div>
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=1b308937b1aec37f7b4bc57faeb4931b&redirect_uri=	
http://localhost:8080/member/auth/kakao/callback&response_type=code&scope=account_email,gender,age_range&prompt=login">
            	 <img src="/static/image/social/kakao_login.png" width="300" height="60">
            </a> <br>
             <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=197694978566-bljc0eo7lnf071parv36ntrenp3g69eb.apps.googleusercontent.com&
				redirect_uri=http://localhost:8080/member/login/oauth_google_check&response_type=code
&scope=email%20profile%20openid
&access_type=offline&prompt=login">
            	 <img src="/static/image/social/google_login.png" width="310" height="70">
            </a>
           
        </div>
			
</body>
</html>