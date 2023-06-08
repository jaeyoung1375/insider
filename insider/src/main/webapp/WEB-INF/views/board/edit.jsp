<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>


<style>
	.div-center {
		display: inline-block;
		text-align: center;
	}

	.img {
		
		width: 45px;
		height: 45px;
		
	}
	
	.img.img-circle {
		border-radius: 50%;
	}
	
.note-editor .note-editing-area .note-editable {
    width: 100% !important;
    height: 200px !important;
    resize: none !important;
}
  
  .left {
  	text-align: left;
  	vertical-align: middle;
  }
  
  .right{
  	text-align: right;
  	vertical-align: middle;
  }
  
  .input-upload{
	  padding: 10px 30px;
	  background-color:#eb6864;
	  border-radius: 4px;
	  color: white;
	  cursor: pointer;
	}
	
	.input-uploadPlus{
		padding: 10px 30px;
	  background-color:white;
	  border-radius: 4px;
	  color: #eb6864;
	  cursor: pointer;
	  
	}
	
	.form-switch{
		padding: 0em;
	}
	
	.ppp{
		position: relative;
	}
	
	.xxx{
		position: absolute;
		top: 100px;
		right: 80px;
		z-index: 999;
	}
	
	.file-preview-container {
    height: 100%;
    display: flex;
    flex-wrap: wrap;
 	}
  
	.file-preview-wrapper {
    padding: 10px;
    position: relative;
	}
        
  .file-close-button {
    position: absolute;
    line-height: 18px;
    z-index: 99;
    font-size: 18px;
    right: 5px;
    top: 10px;
    color: #fff;
    font-weight: bold;
    background-color: #666666;
    width: 20px;
    height: 20px;
    text-align: center;
    cursor: pointer;
	}
        
  .file-preview-wrapper-upload {
    margin: 10px;
    padding-top: 20px;
    background-color: white;
    width: 150px;
    border: 1px soild #eb6864;
    
	}
        
        
  .image-box {
    margin-top: 30px;
    padding-bottom: 30px;
    text-align: center;
	}
	
	.file-preview-wrapper>img {
     position: relative;
     width: 200px;
     height: 250px;
     z-index: 10;
 	}
 	
 	.nickname{
 		font-weight: bold;
 		font-size: large;
 		margin-left: 20px;
 	}
 	
 	.hidefile{
 		display:none;
 	}
 	
	.modal {
	  display: none;
	  position: fixed;
	  z-index: 1;
	  left: 0;
	  top: 0;
	  width: 100%;
	  height: 100%;
	  overflow: auto;
	  background-color: rgba(0, 0, 0, 0.5);
	}
	
	.modal-content {
	  background-color: #fefefe;
	  margin: 15% auto;
	  padding: 20px;
	  border: 1px solid #888;
	  width: 100%;
	  max-width: 100%;
	}
	
	.carousel-item {
 	 position: relative;		
	}
	
	.delete-img{
	  position: absolute;
	  top: 10px;
	  right: 10px;
	  z-index: 10;
	  background-color: transparent;
	  border: none;
	  color: red;
	  font-size: 20px;
	  cursor: pointer;
	}
	 	
</style>


<script type="text/javascript">

// <script type="text/javascript">
// $(function(){
//     $('[name=summernote]').summernote({
//         placeholder: '내용 작성',
//         tabsize: 4,//탭키를 누르면 띄어쓰기 몇 번 할지
//         height: 250,//최초 표시될 높이(px)
//         toolbar: [//메뉴 설정
//             ['style', ['style']],
//             ['font', ['bold', 'underline', 'clear']],
//             ['color', ['color']],
//             ['para', ['ul', 'ol', 'paragraph']],
//             ['table', ['table']],
//             ['insert', ['link', 'picture']]
//         ]
//     });
// });



$(function(){

	$(document).ready(function() {
		  // Show the modal on page load
		  $('#modalForm').css('display', 'block');

		  // Disable modal closing when clicking outside the modal content
		  $('.modal-dialog').on('click', function(event) {
		    event.stopPropagation();
		  });

		  // Close the modal when the cancel button is clicked
		  $('.cancel').on('click', function() {
		    $('#modalForm').css('display', 'none');
		  });

		  // Close the modal when the close button is clicked
		  $('.close').on('click', function() {
		    $('#modalForm').css('display', 'none');
		  });
		});



	
	
$(document).ready(function() {
    $('#summernote').summernote({
        toolbar: false,
        callbacks: {
            onInit: function() {
                // Retrieve the initial content
                var content = $('#summernote').val();
                // Convert line breaks to <br> tags
                content = content.replace(/\n/g, '<br>');
                // Set the modified content back to Summernote
                $('#summernote').summernote('code', content);
            },
            onKeyup: function() {
                // Update the character count
                var content = $('#summernote').summernote('code');
                var characterCount = content.replace(/<[^>]+>/g, '').length;
                $('.count').text(characterCount);
            }
        }
    });
});

	$(".cancel").click(function(){
		 event.stopPropagation(); 
		const text = confirm("게시물을 수정을 그만하시겠어요?\n지금 나가면 수정 내용이 저장되지 않습니다.");
		
		if(text){
			location.replace("/")
		}
		else{
			location.reload();
		}
	});
		
	
	$(".form-submit").submit(function(e){
	
		if($(".content").val() == ""){
			alert("문구를 입력하세요.");
			e.preventDefault();
		}
		
		/* if($("#upload2").val() == ""){
			$("#upload2").attr("disabled", true);
		}
		else{
			$("#upload2").attr("disabled", false);
		} */
		
		
		if ($(".content").val() == "" || $("#tagName").val() != "") {

		    $("#tagName").attr("disabled", false);

		    tagBoardDto.tagName = $("#tagName").val();
		  } else {
		    $("#tagName").attr("disabled", true);
		  }
		
		if($(".content").val() == "" || $("#memberTag").val() != ""){
			$("#memberTag").attr("disabled", false);
		}
		else{
			$("#memberTag").attr("disabled", true);
		}
		
	});
	
		//멀티 페이지
		let index = 0;
		move(index);
		
		$(".btn-next").click(function(){
			
			if($("#upload").val() == "" && $("#upload2").val() == ""){
					alert("사진을 선택하세요.");
					$(".btn-next").attr("disabled", false);
			}
			else{
				index++;
				move(index);
			}	
			
		});
		
		$(".btn-prev").click(function(){
			index--;
			move(index);
		});
		
		function move(index){
			$(".page").hide();
			$(".page").eq(index).show();
		}
});


</script>

<!------------------------------------------------------------------------------------->

<div id="modalForm" class="modal">


<div id="app" class="vue-container">

<form action="edit" method="post" enctype="multipart/form-data" class="form-submit">
	<input type="hidden" name="boardNo" value="${board.boardNo}">
	<div class="container-fluid" style="width: 1200px">
	
		<div class="row mt-3"></div>
		
		<%-- <!-- 1. 사진 첨부 영역 -->
		<div class="page">
		<div class="row w-70 mt-5" style="float: none; margin: 0 auto;">
		  <div class="col">
		
		    <div class="card border-primary mb-3" style="height: 600px;">
		      <div class="card-header">
		        <div class="row">
		          <div class="col-md-2">
		            <button type="button" class="btn btn-secondary cancel" style="float:left;">취소</button>
		          </div>
		          <div class="col-md-8">
		            <h4 class="text-primary text-center" style="margin-top: 1%;">게시물 수정하기</h4>
		          </div>
		          <div class="col-md-2">
		            <button type="button" class="btn btn-secondary btn-next" style="float:right;">다음</button>
		          </div>
		        </div>
		      </div>
		      
		      
		      <div>
		      	
		      	<!-- 1-1. 사진 첨부전, 업로드 버튼 영역 -->
			      <div :class="{'hidefile':files.length > 0}">
				      <div class="card-body text-center" style="margin-top: 20%;">
				        <h1 class="card-title" ><i class="fa-regular fa-images"></i></h1>
				        <p class="card-text fs-5">사진을 선택하세요.</p>
				        <label for="upload" class="input-upload">업로드</label>
				        <input type="file" name="boardAttachment" accept="image/*, video/*" id="upload" ref="files" @change="imageUpload" style="display:none;" multiple>
				        <p style="margin-top: 20px;">* 이미지는 최대 5개까지 선택 가능합니다.</p>
				      </div>
			      </div>
			      
			      <!-- 1-2. 사진 첨부했을 때, 미리보기 영역 -->
			      <div :class="{'hidefile':files.length==0}">
				      <div class="file-preview-container">
				        <div v-for="(file, index) in files" :key="index" class="file-preview-wrapper">
				        	<div class="file-close-button" @click="fileDeleteButton" :name="file.number">
				        		X
				        	</div>
				        	<img :src="file.preview"/>
				        </div>
				        <div class="file-preview-wrapper-upload">
				        	<div class="image-box" v-show="files.length <5">
						        <label for="upload2" class="input-uploadPlus">
						        	<i class="fa-solid fa-plus fa-3x"></i>
						        </label>
						        <input type="file" name="boardAttachment" accept="image/*, video/*" id="upload2" ref="files2" @change="imageAddUpload" style="display:none;" multiple/>				        	
				        	</div>
				        </div>
				      </div>
			      </div>
		      
		      </div>
		      

		    </div>
		
		  </div>
		</div>
		</div> --%>
		
		
		<!-- 2. 게시물 등록 영역 -->
		<div class="page">
		<div class="row w-70 mt-5" style="float: none; margin: 0 auto;">
		  <div class="col">
		
		    <div class="card border-primary mb-3" style="height: 600px;">
		      <div class="card-header">
		        <div class="row">
		          <div class="col-md-2">
		            <button type="button" class="btn btn-secondary cancel" style="float:left;">이전</button>
		          </div>
		          <div class="col-md-8">
		            <h4 class="text-primary text-center" style="margin-top: 1%;">게시물 수정하기</h4>
		          </div>
		          <div class="col-md-2">
		            <button type="submit" class="btn btn-primary" style="float:right;">공유하기</button>
		          </div>
		        </div>
		      </div>
		      
		      <div class="card-body text-center">
		      
		      	<div class="row">
		      		<div class="col-md-7">
		      			
		      			<div id="carouselExampleIndicators" class="carousel slide" data-bs-interval="false">
								  <div class="carousel-indicators">
								    <button v-for="(file, index) in files" :key="index" type="button" data-bs-target="#carouselExampleIndicators" :data-bs-slide-to="index" :class="{'active':index==0}" :aria-current="index==0" :aria-label="'Slide'+(index+1)"></button>
								  </div>
								  
								  <div class="carousel-inner" >
									  	<div  v-for="(file, index) in files" :key="index" class="carousel-item" v-bind:class="{'active':index==0}">
									  		<img :src="file.preview" class="d-block w-100" style="height: 480px; width:470px position: relative; display: inline-block!important;" />
									  		<button class="delete-img" v-if="path.length > 1" @click="deleteImage(index, $event, boardNo)">X</button>
									  	</div>
								  </div>
								  
								  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
								    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
								    <span class="visually-hidden">Previous</span>
								  </button>
								  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
								    <span class="carousel-control-next-icon" aria-hidden="true"></span>
								    <span class="visually-hidden">Next</span>
								  </button>
								</div>
		      			
		      		</div>
		      		
		      		<div class="col-md-5">
					    	<div class="row">
					    		<div class="col-md-10 left bottom">
					    			<span class="nickname">${board.memberNick}</span>
					    		</div>
					    	</div>
					    	
					    	<div class="row mb-2"></div>
					    	
					    <div class="row">
						    <div id="summernoteContainer">
						        <textarea id="summernote" class="form-control content" rows="6" name="boardContent" placeholder="문구를 입력하세요" required >${board.boardContent}</textarea>
						    </div>
						    <div class="right">
						        <span class="length">
						            <span class="count">0</span>
						            /
						            <span class="total">1000</span>
						        </span>
						    </div>
						</div>

					    	
					    	<div class="row mt-3">
					    		<input type="text" name="tagName" class="form-control" placeholder="#해시태그" id="tagName" autocomplete="off" value="${tag}">
					    	</div>
					    	
					    	<div class="row mt-3">
					    		{{currentAddr}}
					    	</div>
					    	
					    	
					    	<div class="row mt-3 form-check form-switch" style="display: flex;">
					    		
										<div class="col-md-9 left" style="margin-left: 0px;">
											<label class="fs-5" for="replyCheck">댓글 기능 해제</label>
										</div>
										<div class="col-md-3">
											<input type="checkbox" name="boardReplyValid" v-model="boardReplyValid" :value="boardReplyValid?1:0" class="form-check-input fs-5" style="margin-left: 0;" id="replyCheck">
										</div>
									
					    	</div>
					    	
					    	<div class="row mt-2 form-check form-switch" style="display: flex;">
					    		
										<div class="col-md-9 left" style="margin-left: 0px;">
											<label class="fs-5" for="replyCheck">좋아요 수 숨김</label>
										</div>
										<div class="col-md-3">
											<input type="checkbox" name="boardLikeValid" v-model="boardLikeValid" :value="boardLikeValid?1:0" class="form-check-input fs-5" style="margin-left: 0;" id="replyCheck">
										</div>
									
					    	</div>
					    	
					    	<div class="row mt-1">
									<p class="left" style="font-size: small;">게시물 상단의 메뉴에서 이 설정을 변경할 수 있습니다.</p>
					    	</div>
					    	
					    	</div>
			    	
			   			</div>
		      	</div>
		        
		      </div>
		      
		    </div>
		
		  </div>
		 </div>
		</div>
		
		<div class="row mb-5"></div>
	

</form>

</div>

</div>






<!------------------------------------------------------------------------------------->

<!-- 카카오맵 CDN -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e45b9604d6c5aa25785459639db6e025&libraries=services"></script>
<script src="https://unpkg.com/vue@3.2.36"></script>
<script>
  //div[id=app]을 제어할 수 있는 Vue instance를 생성
  const app = Vue.createApp({
    //data 영역 : 화면을 구현하는데 필요한 데이터를 작성해둔다.
    el: ".vue-container",
    data(){
      return {
    	  files : [],
    	  filesPreview: [],
    	  uploadImageIndex: 0,

    	  path : [],
    	  boardNo : ${board.boardNo},
    	  boardReplyValid : ${board.boardReplyValid}==1,
    	  boardLikeValid : ${board.boardLikeValid}==1,
    	  gpsLat:memberGpsLat,
    	  gpsLon:memberGpsLon,
    	//주소 알아오는 코드
    	  geocoder:null,
    	  currentAddr:"",
    	  /* //사람태그
    	  keyword: "",
    	  nickList: [],
    	  click: false, */
        
      }
    },

    //methods : 애플리케이션 내에서 언제든 호출 가능한 코드 집합이 필요한 경우 작성한다.
     methods: {
    	 imageUpload(){
     		let num = -1;
     		for(let i = 0; i < this.$refs.files.files.length; i++){
     			this.files = [
     				...this.files,
     				{
     					file: this.$refs.files.files[i],
     					preview: URL.createObjectURL(this.$refs.files.files[i]),
     					number: i
     				}
     			];
     			num = i;
     		}
     		this.uploadImageIndex = num + 1;
     	},
     	
     	imageAddUpload(){
     		let num = -1;
     		for(let i = 0; i < this.$refs.files2.files.length; i++){
     			this.files = [
     				...this.files,
     				{
     					file: this.$refs.files2.files[i],
     					preview: URL.createObjectURL(this.$refs.files2.files[i]),
     					number: i + this.uploadImageIndex
     				}
     			];
     			num = i;
     		}
     		this.uploadImageIndex = this.uploadImageIndex + num + 1;
        
      },
      
      
    	fileDeleteButton(e){
    		const name = e.target.getAttribute('name');
    		this.files = this.files.filter(data => data.number != Number(name));
    	},
    	
    	async deleteImage(index,event, boardNo){
    		this.path = ${image};
    		event.preventDefault();
    		//console.log(path[index]);
    		const confirmed = confirm("사진을 삭제하시겠습니까?\n 사진은 복구되지 않습니다.");
    		
    		if(confirmed){
	    		const resp = await axios.delete("${pageContext.request.contextPath}/rest/attachment/delete/"+ this.path[index], { params: { boardNo: boardNo } });
	    		this.path.splice(index,1);
	    		console.log(this.path);
	    		//this.loadImage();
	    		//this.path = ${image};
	    		//console.log(this.path);
	    		location.reload();    			
    		}
    		else{
    			location.reload();
    		}
    		
    	},
    	
    	loadImage(){
    		this.files = [];
    		this.path = ${image};
        	/* console.log(path);
        	console.log(path.length);
        	console.log(path[0], path[1]); */
        	
     		let num = -1;
    		for(let i=0; i<this.path.length; i++){
      			this.files = [
      				...this.files,
      				{
      					file:"",
      					preview:"${pageContext.request.contextPath}/rest/attachment/download/" + this.path[i],
      					number : i
      				}
      			] 
      			num = i;
      		} 
    		this.uploadImageIndex = num + 1;
    	},
    	//주소 알아오는 메소드
    	searchAddrFromCoords(callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    this.geocoder = new kakao.maps.services.Geocoder();
		    this.geocoder.coord2RegionCode(memberGpsLon, memberGpsLat, callback);
		},
		displayCenterInfo(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        for(var i = 0; i < result.length; i++) {
		            // 행정동의 region_type 값은 'H' 이므로
		            if (result[i].region_type === 'H') {
		                this.currentAddr = result[i].address_name;
		                break;
		            }
		        }
		    }    
		},
		
    },
    
    created() {
    	
    	//this.files.preview.push(...a);
    	//this.image.push(...a)
    	//console.log(this.files);
    	//this.files.preview = [...a];
    	//console.log(this.files.preview)
    	this.loadImage();
    	this.searchAddrFromCoords(this.displayCenterInfo);
    },
    

  });
  app.mount("#app");
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>