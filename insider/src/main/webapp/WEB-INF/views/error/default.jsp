<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-fluid mt-4">
	<div class="row d-flex align-items-center" 
			style="position: absolute; left: 50%; top: 50%; width: 1200px; height: 700px; transform: translate(-50%, -50%);">
		<div class="offset-2 col-8">
			<div class="row text-center">
				<div class="col-3 d-flex justify-content-end align-items-center">
					<i class="fa-solid fa-ban" style="font-size:8em; color:#d9534f"></i>
				</div>
				<div class="col p-3">
					<h1 class="m-0 p-1"><span style="color:#d9534f">잘못된 접근</span>이거나 요청하신</h1>
					<h1 class="m-0 p-1">페이지를 <span style="color:#d9534f">찾을 수 없습니다</span> :(</h1>
				</div>
			</div>
			<div class="row">
				<div class="col d-flex justify-content-end p-4">
					<h4><a class="modal-click-btn" href="${pageContext.request.contextPath}/" style=" text-decoration: none;">홈으로 이동</a></h4>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>