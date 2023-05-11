<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h1>DM HOME</h1>


<h2>채널 6번 예제(방을 선택하여 입장 + 서비스화) - 로그인 필요</h2>
<form action="channel6">
	<input type="text" name="room" placeholder="채널명 입력" required>
	<button type="submit">입장</button>
</form>

<hr>

<h1>채팅방 목록</h1>

<c:forEach var="dmRoom" items="${dmRoomList}">
	<h3>
		<a href="channel6?room=${dmRoom.roomNo}">
		${dmRoom.roomNo}
		</a>
	</h3>
</c:forEach>