<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-fluid mt-4" id="app">
	<div class="row">
		<div class="col-4 text-center">
			<img class="rounded-circle" :src="'${pageContext.request.contextPath}'+mainImage" width = "150" height="150">
		</div>
		<div class="col-8">
			<div class="row">
				<div class="col">
					<h1>\#{{tagName}}</h1>
				</div>
			</div>
			<div class="row">
				<div class="col">
					게시물
				</div>
			</div>
			<div class="row">
				<div class="col">
					{{tagData.count}} 개
				</div>
			</div>
			<div class="row mt-3">
				<div class="col-10" v-if="tagData.follow==0">
					<button class="btn btn-primary w-100" @click="tagFollow">팔로우</button>
				</div>
				<div class="col-10" v-else>
					<button class="btn btn-secondary w-100" @click="tagFollow">팔로잉</button>
				</div>
			</div>
		</div>
	</div>
	<hr>
</div>
<script>
	Vue.createApp({
		data() {
			return {
				page:1,
				percent:0,
				tagName:"",
				boardList:[],
				tagData:{},
				mainImage:"",
			};
		},
		computed: {
			//계산영역
		},
		methods: {
			//메소드영역
			async loadList(){
				if(this.loading||this.finish) return;
				this.loading=true;
				const resp = await axios.get(contextPath+"/rest/tag/list/"+this.tagName+"?page="+this.page);
				this.boardList.push(...resp.data);
				this.mainImage=this.boardList[0].boardAttachmentList[0].imageURL
				this.page++;
				if(resp.data.length<10){//데이터가 10개 미만이면 불러오는걸 막음
					this.finish==true;
				}
				this.loading=false;
			},
			getTagNameFromURL(){
				const url = window.location.href;
				const lastSlashIndex = url.lastIndexOf('/');
				const encodedTag = url.substring(lastSlashIndex + 1);
				this.tagName = decodeURIComponent(encodedTag);
				this.loadList();
			},
			async loadData(){
				const resp = await axios.get(contextPath+"/rest/tag/"+this.tagName+"?page="+this.page);
				this.tagData=resp.data;
			},
			async tagFollow(){
				const resp = await axios.post(contextPath+"/rest/tag/follow/"+this.tagName);
				this.tagData.follow=resp.data;
			}
		},
		created(){
			//데이터 불러오는 영역
			this.getTagNameFromURL();
			this.loadData();
		},
		watch:{
			//감시영역
			percent(){
				if(this.percent >= 80){
				this.loadList();
				}
			}	
		},
		mounted(){
			window.addEventListener("scroll", _.throttle(()=>{
				//문서 전체 높이 - 브라우저 높이
				const height = document.body.clientHeight - window.innerHeight;
				//현재 스크롤의 위치
				const current = window.scrollY;
				const percent = (current/height)*100;
				this.percent = Math.round(percent);
			}, 250))
		}
	}).mount("#app");
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>