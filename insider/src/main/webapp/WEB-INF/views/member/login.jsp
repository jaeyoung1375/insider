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
                    <input class="form-input w-50" type="text" name="memberEmail">
                </div>
                <div class="row">
                    <input class="form-input w-50" type="password" name="memberPassword">
                </div>
                <div class="row">
                    <button class="form-btn w-50 positive" type="submit">로그인</button>
                </div>
            </form>
        </div>
			
</body>
</html>