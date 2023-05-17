<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!--  <form action="upload" method="post" enctype="multipart/form-data"> -->
<!--           <input type="file" name="attach" id="attach" accept="image/*, video/*" onchange="previewFile()"> -->
<!--           <br><br> -->
<!--           <div id="preview"></div> -->
<!--           <br><br> -->
<!--           <button type="submit" class="btn btn-primary">업로드</button> -->
<!--           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button> -->
<!--  </form> -->


<script>
    $(document).ready(function() {
        $('#summernote').summernote({
            toolbar: false,
            callbacks: {
                onInit: function() {
                    // Retrieve the initial content
                    var content = $('#summernote').val();
                    // Convert line breaks to <br> tags
                    content = content.replace(/\n/g, '<br>');
                    // Set the modified content back to summernote
                    $('#summernote').summernote('code', content);
                },
                onSubmit: function(content) {
                    // Convert <br> tags back to line breaks before submitting
                    content = content.replace(/<br>/g, '\n');
                    // Update the textarea value
                    $('#summernote').val(content);
                }
            }
        });
    });
</script>

<form action="insert" method="post">
    <div id="summernoteContainer">
        <textarea id="summernote" name="boardContent" required></textarea>
    </div>
    <br><br>
    <button type="submit">등록</button>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>