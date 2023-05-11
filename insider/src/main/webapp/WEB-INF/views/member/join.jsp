<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/static/css/commons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
 
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
.logo{
		font-size: 50px;
		color: black;
		text-decoration: none;
	}

    </style>


</head>
<body>
		
        <form action="join" method="post">
        <div class="container col-lg-3 card p-5 mt-5" style="display:flex; justify-content: center;">
        <div>
            <div class="text-center mb-3">         	
		         	<a href="/" class="logo"><img src="/static/image/logo.png" width="50px" height="50px" class="me-3">insider</a>
                </div>
            <div class="mb-3 row"> 
                <input class="form-control" type="text" name="memberEmail" placeholder="이메일">
            </div>
            <div class="mb-3 row">
                <input class="form-control" type="text" name="memberName" placeholder="성명">
            </div>
            <div class="mb-3 row">
                <input class="form-control" type="text" name="memberNick" placeholder="닉네임">
            </div>
            <div class="mb-3 row">
                <input class="form-control" type="password" name="memberPassword" placeholder="비밀번호">
            </div>
             <div class="mb-3 row">
                <input class="form-control" type="password" placeholder="비밀번호 확인">
            </div>
              <div class="mb-3 row">
                <input class="form-control" type="text" name="memberTel" placeholder="전화번호">
            </div>
            <div class="mb-3 row">
                <input class="form-control" type="date" name="memberBirth" placeholder="생년월일">
            </div>
            <div class="text-center mb-3">
                 <input type="radio" id="select1" name="memberGender" value="0" class="btn-check">
                 <label class="btn btn-outline-danger" for="select1">남성</label>
    			 <input type="radio" id="select2" name="memberGender" value="1" class="btn-check">
    			 <label class="btn btn-outline-danger" for="select2">여성</label>
            </div>
            <div class="mb-3">
                <input type="text" name="memberPost" class="form-control" placeholder="우편번호" readonly>
                <button type="button" class="btn btn-secondary find-address-btn">우편번호 찾기</button>
             </div>
             <div class="mb-3">
                <input type="text" name="memberBasicAddr" class="form-control" placeholder="기본주소" readonly>
             </div>
             <div class="mb-3">
                <input type="text" name="memberDetailAddr" class="form-control" placeholder="상세주소">
    
             </div>
             <div class="row mb-3">
                <button type="submit" class="btn btn-primary">가입하기</button>
             </div>

	</div>
        </div>
    </form>
</body>
</html>