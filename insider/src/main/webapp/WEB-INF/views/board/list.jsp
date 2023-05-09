<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>이미지 목록</h1>
<hr>
<br>
<c:forEach var="attachmetnDto" items="${list}">
	<img width="150" height="150" src="${attachmentDto.imageURL }"><br>
	번호 :${attachmentDto.no }, 이름 : ${attachmentDto.name }, 파일확장자 : ${attachmentDto.type }
	<hr>
</c:forEach>