<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
    function previewFile() {
        var preview = document.getElementById('preview');
        var file = document.getElementById('attach').files[0];
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

<!-- <!-- 트리거 --> -->
<!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#uploadModal"> -->
<!--   파일 업로드 -->
<!-- </button> -->

<!-- <!-- Upload modal --> -->
<!-- <div class="modal fade" id="uploadModal" tabindex="-1" aria-labelledby="uploadModalLabel" aria-hidden="true"> -->
<!--   <div class="modal-dialog"> -->
<!--     <div class="modal-content"> -->
<!--       <div class="modal-header"> -->
<!--         <h5 class="modal-title" id="uploadModalLabel">파일 업로드</h5> -->
<!--         <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!--       </div> -->
<!--       <div class="modal-body"> -->
<!--         <form action="upload" method="post" enctype="multipart/form-data"> -->
<!--           <input type="file" name="attach" id="attach" accept="image/*, video/*" onchange="previewFile()"> -->
<!--           <br><br> -->
<!--           <div id="preview"></div> -->
<!--           <br><br> -->
<!--           <button type="submit" class="btn btn-primary">업로드</button> -->
<!--           <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button> -->
<!--         </form> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
<!-- </div> -->


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Modal Title</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal content goes here.</p>
        <form action="upload" method="post" enctype="multipart/form-data">
          <input type="file" name="attach" id="attach" accept="image/*, video/*" onchange="previewFile()">
          <br><br>
          <div id="preview"></div>
          <br><br>
          <button type="submit" class="btn btn-primary">업로드</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        </form>
      </div>
    </div>
  </div>
</div>




<script>
  $(document).ready(function() {
    $('#myModal').modal('show');
  });
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>