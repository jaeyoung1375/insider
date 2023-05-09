<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>다중파일업로드</h2>

<form action = "" method = "post" enctype="multipart/form-data">
	<input type="file" name="attaches" multiple accept="image/*">
	<button>전송</button>
</form>