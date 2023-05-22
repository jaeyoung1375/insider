<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="path/to/dropzone.js"></script>

<!-- 미리보기 -->
<script>
    function previewFile() {
        var preview = document.getElementById('preview');
        var file = document.getElementById('attaches').files[0];
        var reader = new FileReader();

        if (file.type.match('image.*')) {
            reader.onloadend = function() {
                preview.innerHTML = '<img src="' + reader.result + '" style="max-width: 400px;">';
            }
        } else if (file.type.match('video.*')) {
            reader.onloadend = function() {
                preview.innerHTML = '<video src="' + reader.result + '" controls style="max-width: 400px;"></video>';
            }
        } else {
            preview.innerHTML = '';
        }

        if (file) {
            reader.readAsDataURL(file);
        }
    }
</script>

<!-- 서머노트 -->
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

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">이미지 & 동영상 업로드</h4>
      </div>
      <div class="modal-body">
        <form action="upload" method="post" enctype="multipart/form-data">
          <input type="file" name="attaches" id="attaches" accept="image/*, video/*" onchange="previewFile()">
          <br><br>
          <div id="preview"></div>
          <br><br>
<!--           	<div id="summernoteContainer"> -->
<!--         		<textarea id="summernote" name="boardContent" required></textarea> -->
<!--     		</div> -->
          <br><br>
          <button type="submit" class="btn btn-primary">업로드</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        </form>
      </div>
    </div>
  </div>
</div>



<!-- 모달 -->
<script>
  $(document).ready(function() {
    $('#myModal').modal('show');
  });
</script>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>