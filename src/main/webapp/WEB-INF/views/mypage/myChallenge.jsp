<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
	a {
		color : black;
		text-decoration: none;
	}
	.currCategory {
		color: green; 
		font-weight: bold;
	}
	/*ZoomIn Hover Effect*/
     .hover-zoomin a {
      display: block;
      position: relative;
      overflow: hidden;
      border-radius: 15px;
    }
    .hover-zoomin img:not(.stamp) {
      width: 100%;
      height: auto;
      -webkit-transition: all 0.2s ease-in-out;
      -moz-transition: all 0.2s ease-in-out;
      -o-transition: all 0.2s ease-in-out;
      -ms-transition: all 0.2s ease-in-out;
      transition: all 0.2s ease-in-out;
    }
    .hover-zoomin:hover img:not(.stamp) {
      -webkit-transform: scale(1.1);
      -moz-transform: scale(1.1);
      -o-transform: scale(1.1);
      -ms-transform: scale(1.1);
      transform: scale(1.1);
    } 
    .stamp {
    	position: absolute; 
		left: 62%;
		top: -6%; 
		width: 40%;
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
		//페이징
		$('.paging').on('click', function() {
			location.href = '/zzp/mypage/${login.userid}/challenge?page='+$(this).attr('data-page');
		})
		//좋아요 추가/삭제
		$('.liked_area').on('click', '.liked', function () {
			let cid = $(this).attr("data-cid");
			$.ajax({
				type:"post",
				url:"/zzp/challenge/"+cid+"/like",
				data: {
					chall_id:cid,
					userid:"${login.userid}"
				},
				dataType:"text",
				success: function (data) {
					$("#liked_area"+cid+" .liked").attr("src", data);
					countLikes(cid);
				},
				error: function () {
					alert("문제가 발생했습니다. 다시 시도해 주세요.");
				}
			}); 
		});
		//좋아요 개수 구해오기
		function countLikes(cid) {
			$.ajax({
				type:"get",
				url:"/zzp/challenge/"+cid+"/like",
				data: {
					chall_id:cid
				},
				dataType:"text",
				success: function (data) {
					$("#likeNum"+cid).text(data);
				},
				error: function () {
					alert("문제가 발생했습니다. 다시 시도해 주세요.");
				}
			});
		}
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
	   		<a href="/zzp/mypage/${login.userid}/challenge" class="currCategory">내 챌린지</a>
	   </div>
	   <div class="col">
	   		<a href="/zzp/mypage/${login.userid}/stamp">내 도장</a>
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
		<th>내 챌린지 <span class="text-success fw-bold">${pDTO.totalCount}</span></th>
	</tr>
</table>

<div class="row ms-3">

<c:forEach var="c" items="${pDTO.list}">	
     <div class="col-xl-4 col-md-6">
       <div class="p-3">
	       <a href="/zzp/profile/${login.userid}"><img src="/upload/profile/${c.profile_img}" width="30" height="30"></a>&nbsp;&nbsp;
	       <a href="/zzp/profile/${login.userid}">${login.userid}</a><br>
       </div>
       <div class="hover-zoomin">
	       <a href="/zzp/challenge/${c.chall_id}"> 
			<img src="/upload/challenge/${c.chall_img}" border="0" onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'">
			<c:if test="${!empty c.stamp_img}">
				<img src="/upload/challenge/${c.stamp_img}" class="stamp">
			</c:if>
		   </a>
	   </div>
	   <div class="p-2 text-center liked_area" id="liked_area${c.chall_id}">
	   	   <c:if test="${!empty likedList}">
	   	 	 <spring:eval var="likedIt" expression="likedList.contains(${c.chall_id})" />
	   	   </c:if>
	   	   <c:choose>
	   	     <%-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 --%>
	   	     <c:when test="${likedIt}">
	   	     	<img src="/zzp/resources/images/challenge/liked.png" width="30" height="30" class="liked" data-cid="${c.chall_id}">
	   	     </c:when>
	   	     <%-- 그외의 경우 --%>
	   	     <c:otherwise>
	   	     	<img src="/zzp/resources/images/challenge/like.png" width="30" height="30" class="liked" data-cid="${c.chall_id}">
	   	     </c:otherwise>
	   	   </c:choose>
		   <span id="likeNum${c.chall_id}">${c.chall_liked}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   <img src="/zzp/resources/images/challenge/bubble.png" width="30" height="25"> ${c.chall_comments}
	   </div>
	   <div class="pb-5 text-center">
	   		<a href="challenge/${c.chall_id}">${c.chall_title}</a>
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