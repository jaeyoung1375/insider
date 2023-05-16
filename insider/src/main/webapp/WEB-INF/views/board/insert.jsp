<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
  $(function () {
   
  });
  

  function previewFile() {
      var boardContent = document.getElementById('boardContent');
      var file = document.getElementById('attach').files[0];
      var reader = new FileReader();
      var text = $("#boardContent").val();
	
      
      if (file.type.match('image.*')) {
          reader.onloadend = function() {
        	  boardContent.append( '<img src="' + reader.result + '" style="max-width: 400px;">' );
          }
      } else if (file.type.match('video.*')) {
          reader.onloadend = function() {
        	  boardContent.append( '<video src="' + reader.result + '" controls style="max-width: 400px;"></video>' );
          }
      } 

      if (file) {
          reader.readAsDataURL(file);
      }
  }
  
</script>

<c:choose>
  <c:when test="${parentBoardNo==null}">
    <h1>새글 작성</h1>
  </c:when>
  <c:otherwise>
    <h1>답글 작성</h1>
  </c:otherwise>
</c:choose>

  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-content">
      <div class="modal-body">
<form action="insert"  method="post" enctype="multipart/form-data">
  <%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>
  <c:if test="${parentBoardNo!=null}">
        <input type="hidden" name="parentBoardNo" value="${parentBoardNo}">
  </c:if>

	<div></div>

  <label for="boardContent">내용: </label>
  <!-- <textarea id="boardContent" rows="10" cols="60" name="boardContent" required></textarea> -->
  <textarea id="boardContent" rows="10" cols="60" name="boardContent" required></textarea>
  <br /><br />

          <input type="file" name="attach" id="attach" accept="image/*, video/*" onchange="previewFile()">
          <br><br>
          <div id="preview"></div>
          <br><br>
          <button type="submit" class="btn btn-primary">저장</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
</form>
      </div>
    </div>
  </div>
  
  
  <script>
  $(document).ready(function() {
    $('#myModal').modal('show');
  });
</script>
<!-- 
  <br /><br />
  <button>작성1</button>
  <br /><br />
  <a href="/">취소</a> -->

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>