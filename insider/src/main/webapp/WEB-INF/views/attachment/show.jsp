<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>Insert title here</title>
</head>

    <!--[1] Javascript로 모달창을 열기-->
    <script>
        window.addEventListener("load", function(){
            document.querySelector("#btn01")
                .addEventListener("click", function(){
                //bootstrap을 이용하여 사용 가능한 형태의 모달 객체를 생성해야한다
                const ref = new bootstrap.Modal(document.querySelector("#modal01"));
                ref.show();
                //ref.hide();
            });
        });
    </script>

    <!--[2] jQuery로 모달창을 열기(순서 중요하지 않음) -->
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script>
        $(function(){
            $("#btn02").click(function(){
                $("#modal02").modal("show");
                //$("#modal02").modal("hide");
            });
        });
    </script>

<body>
		
	<div class="container-fluid mt-4">
		<div class="row">
			<div class="offset-md-2 col-md-8">
				
				<!-----------------동영상, 이미지 표시 구간------------------------>
				<h1> 안녕 </h1>
				<!--  동영상이면 재생 -->
				<c:if test="${isVideo eq 'Y'}">
					<video width="640" height="360" controls>
						<source src="/download?attachmentNo=${attachmentNo}" type="${contentType}">
					</video>
				</c:if>
				<!--  이미지면 보여주기 -->
				<c:if test="${isVideo eq 'N'}">
					<img width="500" height="500" src="/download?attachmentNo=${attachmentNo}">
				</c:if>
				<h1>콘텐츠 타입은 ${contentType} 입니다.</h1>
				<!------------------------------------------------------------>
				<!------------------모달 버튼------------------->
				<div class="row mt-4">
                    <div class="col">
                        <button type="button" id="btn01" class="btn btn-primary">열기(Javascript)</button>
                        <button type="button" id="btn02" class="btn btn-primary">열기(jQuery)</button>
                        
                    </div>
                </div>
				<!-------------------------------------------->
				
			</div>
		</div>
		
		<!---------------모달창구간------------------>
		<div class="modal" tabindex="-1" role="dialog" id="modal01"
                            data-bs-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">제목</h5>
                    </div>
                    <div class="modal-body">
                        <!-- 모달에서 표시할 실질적인 내용 구성 -->
                        <p>본문 내용</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>      
            </div>
        </div>

        <div class="modal" tabindex="-1" role="dialog" id="modal02"
                            data-bs-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">제목</h5>
                    </div>
                    <div class="modal-body">
                        <!-- 모달에서 표시할 실질적인 내용 구성 -->
                        <p>본문 내용</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>      
            </div>
        </div>

        <div class="modal" tabindex="-1" role="dialog" id="modal03"
                            data-bs-backdrop="static"
                            ref="modal03">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">제목</h5>
                    </div>
                    <div class="modal-body">
                        <!-- 모달에서 표시할 실질적인 내용 구성 -->
                        <p>본문 내용</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>      
            </div>
        </div>
        <!----------------------------------------->
		
	</div>	
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>