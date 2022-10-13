<%@page import="com.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.dto.PageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style>
.img {
	width: 100px;
	height: 100px;
}
</style>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		
		//첨부파일 보이기
		$(".uploadBtu").click(function () {
			var popupX = (document.body.offsetWidth / 2) - (200 / 2);
			var popupY= (window.screen.height / 2) - (300 / 2);
			
			var img = $(this).children(img).attr("src");
			console.log(img);
			
			window.open('/zzp/showImg?img='+img , '', 'status=no, height=500, width=400, left='+ popupX + ', top='+ popupY);
		});
		
		//무한 스크롤
		$('.skeleton').hide();
		let curPage = 1;
		let isLoading = false;
		
		function infiniteScroll() {
			let reviewPost = document.querySelector('.reviewPost:last-child')
			
			//인터섹션 옵저버 생성
			const io = new IntersectionObserver((entry, observer)=>{
				
				const ioTarget = entry[0].target //현재 보이는 타겟
				if (entry[0].isIntersecting) { //viewport에 타켓이 보일 때
					console.log('현재 보이는 타겟', ioTarget)
					io.unobserve(reviewPost) //현재 보이는 타겟 감시 취소
					
					//현재 페이지가 전체 페이지와 같거나 로딩 중인 경우 아래 실행 X
					if (curPage == '${pDTO.endPage}' || isLoading) { return; }
				
					isLoading = true //로딩중 true
					$('.skeleton').show() //로딩 이미지 띄우기
					curPage++; //요청할 페이지 증가
					getList(curPage); //추가 페이지 요청 함수
					
					reviewPost = document.querySelector('.reviewPost:last-child') 
					io.observe(reviewPost) //새로운 타겟 감시
				}
			}, {
				threshold: 0.8 //viewport에 타겟이 80%이상 보일 때
			})
			
			io.observe(reviewPost) //타겟 감시
		}
		infiniteScroll() //최초 호출
		
		function getList(curPage) { //추가 페이지 요청 함수
			console.log('inscroll '+curPage)
			$.ajax({
				type:'get',
				url:'/zzp/profile/${userid}/scrollreview',
				data: {
					page:curPage
				},
				dataType:'html',
				success: function (data) {
					$('#reviewTable').append(data) //응답받은 데이터 추가
					$('.skeleton').hide() //로딩 이미지 숨기기
					isLoading = false; //로딩중 false
					infiniteScroll() //다시 호출
				},
				error: function () {
					alert('문제가 발생했습니다. 다시 시도해 주세요.');
				}
			})
		}//무한 스크롤 end
	});
</script>


<div class="row p-2 mx-4 mb-2">
	<div class="col">구매후기 <span class="text-success fw-bold">${pDTO.totalCount}</span></div>
</div>

<div class="row">
<table id="reviewTable" class="table table-hover table-borderless" style="table-layout: fixed">
	
<c:forEach var="r" items="${pDTO.list}">
	<tr class="reviewPost">
		<td style="padding:5 0 0 10px;" width="25%" class="text-center">
			<a href="/zzp/product/${r.p_id}"> 
			<img src="/zzp/resources/images/product/p_image/${r.image_route}" border="0" align="middle" class="img pb-1"
					onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'"><br>
			${r.p_name}</a>
		</td>
		<td width="35%" class="align-middle">
			  <b>${r.review_title}</b><br><br>
			  ${r.review_content}<br>
			  <span class="badge rounded-pill bg-secondary mt-1">${r.review_rate}</span>
		</td>
		<td width="25%" style="text-align: center; vertical-align: middle;">
			<c:choose>
				<c:when test="${r.review_img == null || r.review_img eq 'null'}">
				
				</c:when>
				<c:otherwise>
					<div class="uploadBtu">
						<img class="upload" alt="" src="/upload/review/${r.review_img}" width="100px" height="100px" style="border: 1px solid gray;">
					</div>
				</c:otherwise>
			</c:choose>
		</td>
		<td width="15%" class="align-middle">
			<div>${r.review_created.substring(0,10)}</div>
		</td>
	</tr>
</c:forEach>
	
	
	
	
</table>

<div class="row skeleton ms-3">
  <div class="col-xl-4 col-md-6 ms-2"><img class="img" src="/zzp/resources/images/challenge/none.png" width="67%"></div>
</div>

</div>