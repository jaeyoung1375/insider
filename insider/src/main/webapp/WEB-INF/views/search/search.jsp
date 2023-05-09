<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-fluid mt-4" id="app">
	<div class="row">
		<div class="offset-md-2 col-md-8">
		<!-- 검색창 -->
			<div class="row text-center">
				<div class="col">
					검색<input type="text" class="form-control rounded">
				</div>
			</div>
			
		<!-- 리스트 -->
			<div class="row">
				
			</div>
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