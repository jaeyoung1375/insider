<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>게시물 등록</h2>
<form action="upload" method="post" enctype="multipart/form-data">
	내용 : <input type="text" name="boardContent">
	첨부파일 : <input type="file" name="attaches" multiple accept="image/*">
	<button type="submit">업로드</button>
</form>