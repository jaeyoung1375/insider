<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-fluid mt-4" id="app">
	<div class="row">
		<div class="offset-md-2 col-md-8">
		<!-- 문서 제목 (Jumbotron)-->
			<div class="row text-center">
				<div class="col bg-dark text-light p-4 rounded">
					<h1>제목</h1>
					<p>부제목 또는 설명</p>
				</div>
			</div>
			
		<!-- 작성하고자 하는 컨텐츠 내용 -->
		</div>
	</div>
</div>
<script>
	Vue.createApp({
		data() {
			return {
				//데이터영역
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
		},
		created(){
			//데이터 불러오는 영역
		},
		watch:{
			//감시영역
		}
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>