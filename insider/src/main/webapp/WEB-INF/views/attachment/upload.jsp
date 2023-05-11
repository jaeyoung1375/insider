<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>다중파일업로드</h2>

<form action = "upload" method = "post" enctype="multipart/form-data">
	<input type="file" name="attaches" multiple accept="image/*">
	<input type="submit" value="업로드">
</form>