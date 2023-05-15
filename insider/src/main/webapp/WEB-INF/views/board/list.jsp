<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
    <div class="row">
        <aside class="col">
            <h1>Insider</h1>
        </aside>
        <article class="col">
            <h1>아티클</h1>
            <c:forEach var="attachmentDto" items="${list }">
		<a href = "download?attachmentNo=${attachmentDto.attachmentNo }">
		<img  width="100" height="100" src="/download?attachmentNo=${attachmentDto.attachmentNo }">
		</a>
		&nbsp; &nbsp;
	</c:forEach>
        </article>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>