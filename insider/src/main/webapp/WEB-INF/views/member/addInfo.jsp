<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jquery cdn -->
<link rel="stylesheet" href="/static/css/commons.css">
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
        </style>  
        <div class="container-800 center">
<h1>추가정보 입력</h1>
<form action="addInfo" method="post">
<input type="hidden" name="memberNo" value="${socialUser.memberNo}">
<input type="hidden" name="memberName" value="${socialUser.memberName}">
<input type="hidden" name="memberNick" value="${socialUser.memberNick}">
<input type="hidden" name="memberPassword" value="${socialUser.memberPassword}">
<input type="hidden" name="memberEmail" value="${socialUser.memberEmail}">


 <div class="row select">
                 <input type="radio" id="select" name="memberGender" value="0"><label for="select">남성</label>
    			 <input type="radio" id="select2" name="memberGender" value="1"><label for="select2">여성</label>
            </div>

  <div class="row">
                <input class="form-input w-60" type="text" name="memberTel" placeholder="전화번호">
            </div>
            <div class="row">
                <input class="form-input w-60" type="date" name="memberBirth" placeholder="생년월일">
            </div>
 <div class="row">
                <input type="text" name="memberPost" class="form-input w-30" placeholder="우편번호" readonly>
                <button type="button" class="form-btn neutral find-address-btn w-30">우편번호 찾기</button>
             </div>
             <div class="row">
                <input type="text" name="memberBasicAddr" class="form-input w-60" placeholder="기본주소" readonly>
             </div>
             <div class="row">
                <input type="text" name="memberDetailAddr" class="form-input w-60" placeholder="상세주소">
    
             </div>
             <div class="row">
                <button type="submit" class="form-btn w-60 positive">가입하기</button>
             </div>
</form>
</div>
