<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.alarmModal {
	  display: none;
	  position: fixed;
	  z-index: 1;
	  left: 0;
	  top: 0;
	  width: 100%;
	  height: 100%;
	  overflow: auto;
	  background-color: rgba(0, 0, 0, 0.4);
	}
	
	.alarm-content {
	  background-color: #fefefe;
	  margin: 10% auto;
	  padding: 20px;
	  border: 1px solid #888;
	  width: 80%;
	}
</style>
   
<script type="text/javascript">
	$(function(){
	
		$(document).ready(function() {
			  $('#modalForm').css('display', 'block');
	
			  $('.modal-dialog').on('click', function(event) {
			    event.stopPropagation();
			  });
	
			  $('.cancel').on('click', function() {
			    $('#modalForm').css('display', 'none');
			  });
	
			  $('.close').on('click', function() {
			    $('#modalForm').css('display', 'none');
			  });
			});
	});
</script>
   
   
<div id="modalForm" class="modal">

	<div id="app" class="vue-container">
		
			<div class="container-fluid">
			
				<div class="row mt-3"></div>
				
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
										<h4 class="text-primary text-center" style="margin-top: 1%;">새 게시물 만들기</h4>
										</div>
										<div class="col-md-2">
										<button type="button" class="btn btn-secondary btn-next" style="float:right;">다음</button>
										</div>
									</div>
								</div>
							</div>
						
						</div>
					</div>
				</div>
			
			
			      
			<div class="card-body text-center">
			</div>
			</div>
		<div class="row mb-5"></div>
	</div>
</div>
   
   
   
   
<script src="https://unpkg.com/vue@3.2.36"></script>
<script>
  const app = Vue.createApp({
    //data 영역 : 화면을 구현하는데 필요한 데이터를 작성해둔다.
    el: ".vue-container",
    data(){
      return {
		showModal: false,
      }
    },

    //methods : 애플리케이션 내에서 언제든 호출 가능한 코드 집합이 필요한 경우 작성한다.
    methods: {
		openModal(){
			this.showModal = true;
		},
		closeModal(){
			this.showModal = false;
		},
    },
  });
  app.mount("#app");
</script>
   
   <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>