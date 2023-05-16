<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!--  <form action="upload" method="post" enctype="multipart/form-data"> -->
<!--           <input type="file" name="attach" id="attach" accept="image/*, video/*" onchange="previewFile()"> -->
<!--           <br><br> -->
<!--           <div id="preview"></div> -->
<!--           <br><br> -->
<!--           <button type="submit" class="btn btn-primary">업로드</button> -->
<!--           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button> -->
<!--  </form> -->

<form action="insert" method="post">
	<textarea name="boardContent" required rows="10" cols="60"></textarea> <br><br>
	<button type="submit">등록</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>