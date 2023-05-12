<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div id="app">
	<h1>메인</h1>
</div>
  소셜유저 : ${sessionScope.socialUser}		
  회원번호 : ${sessionScope.memberNo}		
  멤버토큰 : ${sessionScope.member}		

<script>
	Vue.createApp({
		
	});
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>