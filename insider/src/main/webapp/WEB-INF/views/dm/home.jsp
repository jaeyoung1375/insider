<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h1>DM HOME</h1>

<p>회원 번호 : ${sessionScope.memberNo}</p>
<p>회원 닉네임 : ${sessionScope.memberNick}</p>

<hr>

<h1>채팅방 목록</h1>

<c:forEach var="dmRoom" items="${dmRoomList}">
	<h3>
		<a href="channel?room=${dmRoom.roomNo}">
		${dmRoom.roomNo}
		</a>
	</h3>
</c:forEach>
