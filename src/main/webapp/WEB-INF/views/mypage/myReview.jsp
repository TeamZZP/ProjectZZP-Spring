<%@page import="com.dto.MemberDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.PageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
<c:if test="${!empty mesg}">
	<script>
		alert("${mesg}");
	</script>
</c:if>  
    
<style>
a {
	color: black;
	text-decoration: none;
}

.currCategory {
	color: green;
	font-weight: bold;
}

.tableTop {
	border-bottom-color: #24855B;
	border-bottom-width: 2.5px;
}

.paging {
	cursor: pointer;
}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function () {
		$(".reviewUpdate").click(function () {
			var review_id = $(this).attr("data-reviewID");
			location.href = "/zzp/review/"+review_id;
		});
		$(".reviewDelete").click(function () {
			var review_id = $(this).attr("data-reviewID");
			$.ajax({
				type:"delete",
				url:"/zzp/review/"+review_id,
				data:{
					review_id:review_id
				},
				dataType:"text",
				success: function (data, status, xhr) {
					console.log(data);
					if (data == 1) {
						location.href= "/zzp/mypage/${mDTO.userid}/review";
						alert("리뷰가 삭제되었습니다.");
					} else {
						alret("리뷰 삭제를 실패했습니다. 다시 시도해주세요");
					} 
				},
				error: function (xhr, status, error) {
					
				}
			});//end ajax
		});
		$(".uploadBtu").click(function () {
			var popupX = (document.body.offsetWidth / 2) - (200 / 2);
			var popupY= (window.screen.height / 2) - (300 / 2);
			
			var img = $(this).children(img).attr("src"); 
			console.log(img);
			
			window.open('/zzp/showImg?img='+img , '', 'status=no, height=500, width=400, left='+ popupX + ', top='+ popupY);
		});
	});//end ready
</script>

<div class="container">
<div class="row">
	<div class="col-lg-2">
		<div class="col">
			<a href="MypageServlet">마이페이지 홈</a>
		</div>
	   <div class="col">
	   		<a href="/zzp/mypage/${mDTO.userid}/order">주문 내역</a>
	   </div>
	   <div class="col">반품/취소/교환 목록</div>
	   <div class="col">
	   		<a href="/zzp/mypage/${mDTO.userid}/review"  class="currCategory">내 구매후기</a>
	   </div>
	   <div class="col">
	   		<a href="/zzp/mypage/${mDTO.userid}/coupon">내 쿠폰함</a>
	   </div>
	   <div class="col">
	   		<a href="ProfileCategoryServlet?category=mychallenge&userid=${mDTO.userid}">내 챌린지</a>
	   </div>
	   <div class="col">
	   		<a href="ProfileCategoryServlet?category=mystamp&userid=${mDTO.userid}">내 도장</a>
	   </div>
	   <div class="col">
	      <a href="/zzp/mypage/${mDTO.userid}/question">내 문의 내역</a>
	   </div>
	   <div class="col">
	      <a href="AddressListServlet">배송지 관리</a>
	   </div>
	   <div class="col">
	      <a href="checkPasswd.jsp">계정 관리</a>
	   </div>
 </div>
<div class="col-lg-10">
<div id="addTableDiv">
<form method="get" id="reviewForm">
<input type="hidden" name="userid" value="${mDTO.userid}">
<table id="reviewTable" class="table table-hover">
	<tr class="tableTop text-center">
		<th width="25%">상품정보</th>
		<th width="40%" colspan="2">내용</th>
		<th width="20%">등록일</th>
		<th width="15%">수정·삭제</th>
	</tr>
	<c:forEach var="list" items="${myReview.list}">
	<tr>
		<td style="padding:5 0 0 10px;" class="text-center">
			<a href="/zzp/product/${list.p_id}"> 
			<img src="/zzp/resources/images/product/p_image/${list.image_route}" border="0" align="middle" class="img pb-1"
					 width="100px" height="100px" onerror="this.src='images/uploadarea.png'"><br>
			${list.p_name}</a>
		</td>
		<td class="align-middle">
			  <b>${list.review_title}</b><br><br>
			  ${list.review_content}<br>
			  <span class="badge rounded-pill bg-secondary mt-1">${list.review_rate}</span>
		</td>
		<td style="text-align: center; vertical-align: middle;">
			<c:choose>
				<c:when test="${list.review_img == null || list.review_img eq 'null'}">
				
				</c:when>
				<c:otherwise>
					<div class="uploadBtu">
						<img class="upload" alt="" src="/zzp/resources/upload/review/${list.review_img}" width="100px" height="100px" style="border: 1px solid gray;">
					</div>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="align-middle text-center">
			<div>${list.review_create.substring(0,10)}</div>
		</td>
		<td class="align-middle text-center">
			<button type="button" class="btn btn-light btn-sm reviewUpdate" data-reviewID="${list.review_id}">수정</button>
			<button type="button" class="btn btn-light btn-sm reviewDelete" data-reviewID="${list.review_id}">삭제</button>
		</td>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="6" style="text-align: center;">
			 <!-- 페이징 -->
			     <div class="p-2 text-center">
			        <c:if test="${myReview.prev}">
			           <a class="paging" data-page="${myReview.startPage-1}">prev&nbsp;&nbsp;</a>
			        </c:if>
			        <c:forEach var="p" begin="${myReview.startPage}" end="${myReview.endPage}">
			           <c:choose>
			              <c:when test="${p==myReview.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
			              <c:otherwise><a class="paging" href=/zzp//mypage/{userid}/review?page=${p}" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
			             </c:choose>
			        </c:forEach>
			        <c:if test="${myReview.next}">
			           <a class="paging" data-page="${myReview.endPage+1}">next</a>
			        </c:if>
			     </div>
		</td>
	</tr>
</table>
</form>
</div>
</div>
</div>
</div>

