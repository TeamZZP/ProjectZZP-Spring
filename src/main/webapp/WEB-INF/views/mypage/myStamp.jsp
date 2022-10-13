<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	a {
		color : black;
		text-decoration: none;
	}
	.currCategory {
		color: green; 
		font-weight: bold;
	}
     .hover-zoomin a {
      display: block;
      position: relative;
      overflow: hidden;
      border-radius: 15px;
    }
    .hover-zoomin img {
      width: 100%;
      height: auto;
      -webkit-transition: all 0.2s ease-in-out;
      -moz-transition: all 0.2s ease-in-out;
      -o-transition: all 0.2s ease-in-out;
      -ms-transition: all 0.2s ease-in-out;
      transition: all 0.2s ease-in-out;
    }
    .hover-zoomin:hover img {
      -webkit-transform: scale(1.05);
      -moz-transform: scale(1.05);
      -o-transform: scale(1.05);
      -ms-transform: scale(1.05);
      transform: scale(1.05);
    } 
    .tableTop {
    	border-bottom-color: #24855B;
    	border-bottom-width: 2.5px;
    }
    .stamp-num {
    	position: absolute;
    	left: 86%;
		top: 15%; 
    }
    .paging {
		cursor: pointer;
	}
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function () {
		//페이징
		$('.paging').on('click', function() {
			location.href = '/zzp/mypage/${login.userid}/stamp?page='+$(this).attr('data-page');
		})
	});
</script>

<div class="container">
<div class="row">
	<div class="col-lg-2">
	   <div class="col">
			<a href="/zzp/mypage/${login.userid}">마이페이지 홈</a>
	   </div>
	   <div class="col">
	   		<a href="/zzp/mypage/${login.userid}/order">주문 내역</a>
	   </div>
	   <div class="col">
	   		<a href="/zzp/mypage/${login.userid}/review">내 구매후기</a>
	   </div>
	   <div class="col">
	   		<a href="/zzp/mypage/${login.userid}/coupon">내 쿠폰함</a>
	   </div>
	   <div class="col">
	   		<a href="/zzp/mypage/${login.userid}/challenge">내 챌린지</a>
	   </div>
	   <div class="col">
	   		<a href="/zzp/mypage/${login.userid}/stamp" class="currCategory">내 도장</a>
	   </div>
	   <div class="col">
	      	<a href="/zzp/mypage/${login.userid}/question">내 문의 내역</a>
	   </div>
	   <div class="col">
	      	<a href="/zzp/mypage/${login.userid}/address">배송지 관리</a>
	   </div>
	   <div class="col">
	      	<a href="/zzp/mypage/${login.userid}/check">계정 관리</a>
	   </div>
	</div>
<div class="col-lg-10">

<table class="table text-center">
	<tr class="tableTop">
		<th>내 도장 <span class="text-success fw-bold">${stampTotalNum}</span></th>
	</tr>
</table>

<div class="row ms-3">

<c:forEach var="s" items="${pDTO.list}">	
     <div class="col-xl-4 col-md-6">
       <div class="position-relative">
	       <div class="hover-zoomin">
				<img src="/upload/challenge/${s.stamp_img}" border="0" onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'"
						 data-bs-toggle="modal" data-bs-target="#stampModal${s.stamp_id}">
		   </div>
		   <span class="translate-middle badge rounded-pill bg-danger stamp-num">
		    ${s.stamp_num}
		   </span>
	   </div>
     </div>
     
     <!-- Modal -->
	<div class="modal fade" id="stampModal${s.stamp_id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">${s.stamp_name}</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body text-center">
	      <img src="/upload/challenge/${s.stamp_img}" width="400">
	      </div>
	      <div class="modal-footer mb-3 text-center">
	       ${s.stamp_content}
	      </div>
	    </div>
	  </div>
	</div>
</c:forEach>
	
</div>


	<!-- 페이징 -->
	  <div class="p-2 text-center">
		  <c:if test="${pDTO.prev}">
		  	<a class="paging" data-page="${pDTO.startPage-1}">prev&nbsp;&nbsp;</a>
		  </c:if>
		  <c:forEach var="p" begin="${pDTO.startPage}" end="${pDTO.endPage}">
			  <c:choose>
		  		<c:when test="${p==pDTO.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
		  		<c:otherwise><a class="paging" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
		  	  </c:choose>
		  </c:forEach>
		  <c:if test="${pDTO.next}">
		  	<a class="paging" data-page="${pDTO.endPage+1}">next</a>
		  </c:if>
	  </div>
	  

</div>
</div>
</div>