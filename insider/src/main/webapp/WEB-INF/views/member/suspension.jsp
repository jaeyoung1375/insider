<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Insider</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    	<!-- font-awesome cdn -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"/>
	<!--favicon -->
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/favicon.png">
	<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/favicon.png">
  </head>
  <body>
    <div class="container-fluid mt-4 w-60" style="position: absolute; left: 50%; top: 50%; width: 1200px; height: 700px; transform: translate(-50%, -50%);">
    	<div class="row mt-4">
			<div class="col d-flex justify-content-center">
				<i class="fa-solid fa-ban" style="font-size:10em; color:red"></i>
			</div>
		</div>
		<div class="row mt-4">
			<div class="col d-flex justify-content-center">
				<h3>회원님의 계정은 정지상태입니다.</h3>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center mt-4">
				<h5>사유 : ${suspensionDto.memberSuspensionContent}</h5>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<h5>해제일 : ${suspensionDto.memberSuspensionLiftDate}</h5>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<h6>저희 서비스를 이용해주셔서 감사합니다.</h6>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<h6>회원님의 계정이 일시적으로 정지되었습니다.</h6>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<h6>만약 어떠한 불만사항이나 이의제기가 있으시다면 아래의 이메일 주소로 문의해주시기 바랍니다</h6>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<h6>이메일: admin@test.com</h6>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<h6>저희는 회원님의 의견을 소중히 생각하며, 가능한 빠른 시일 내에 회신 드리도록 하겠습니다.</h6>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<h6>불편을 드려 죄송하며, 이용에 참고하여 주시기 바랍니다.</h6>
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-center">
				<h6>감사합니다.</h6>
			</div>
		</div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
  </body>
</html>
