<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.ImagesDTO"%>
<%@page import="com.dto.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.MemberDTO"%>
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
		$(".chk").click(function () {
			var chk = $(this);
			var order_id = $(this).attr("data-orderID");
			var p_name = $(this).attr("data-pNAME");
			var p_id = $(this).attr("data-pID");
		 	$.ajax({
				type:"post",
				url:"/zzp/orders/review",
				data:{
					order_id : order_id,
					p_id : p_id
				},
				dataType:"text",
				success: function (data, status, xhr) {
					console.log( "==",data);
					if (data != 0) {
						chk.attr("href","/zzp/review/"+data);
					} else {
						chk.attr("href","/zzp/review?order_id="+order_id+"&p_name="+p_name+"&p_id="+p_id);
					}
				},
				error: function (xhr, status, error) {
					
				}  
			});//end ajax
		});
		$('.paging').on('click', function() {
			   $('#page').val($(this).attr('data-page'));
			   $('form').submit();
		});
	}); //end ready
</script> 
    
<div id="addContainer">
<div class="container">
<div class="row">
<div class="col-lg-2">
		<div class="col">
			<a href="MypageServlet">마이페이지 홈</a>
		</div>
	   <div class="col">
	   		<a href="/zzp/mypage/${mDTO.userid}/order"  class="currCategory">주문 내역</a>
	   </div>
	   <div class="col">반품/취소/교환 목록</div>
	   <div class="col">
	   		<a href="/zzp/mypage/${mDTO.userid}/review">내 구매후기</a>
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
<form method="get" action="/zzp/mypage/${mDTO.userid}/order">
	<input type="hidden" name="page" value="1" id="page">
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-2">
			<select id="searchCategory" name="searchCategory" class="form-select" aria-label="Default select example">
				<option value="p_name" 
					<c:if test="${search != null && search.searchCategory eq '상품명'}">selected="selected"</c:if>>
					상품명
				</option>
				<option value="order_date" 
					<c:if test="${search != null && search.searchCategory eq '구매날짜'}">selected="selected"</c:if>>
					구매날짜
				</option>
			</select>
		</div>
		<div class="col-md-5">
			<input type="text" id="search" name="search" class="form-control" placeholder=" ex) 상품명:칫솔   ex) 날짜:YY/MM/DD 혹은 MM/DD"
			<c:if test="${search != null && search.search != null}">value="${search.search}"</c:if>>
		</div>
		<div class="col-md-2">
			<button type="submit" id="searchBtn" class="btn btn-outline-success">구매항목검색</button>
		</div>
	</div>
</form>
<br>
<table id="addTable" class="table table-hover" style="text-align: center; vertical-align: middle;">
	<tr class="tableTop">
		<th width="25%">상품명</th>
		<th width="10%">가격</th>
		<th width="10%">주문날짜</th>
		<th width="35%">주소</th>
		<th width="10%">배송상태</th>
		<th></th>
	</tr>
	<c:forEach var="list" items="${myOrder.list}">
	<tr>
	    <td> 
	    	<a href="ProductRetrieveServlet?p_id=${list.p_id}"> 
	   		<img alt="상품사진" src="/zzp/resources/images/product/p_image/${list.image_route}" width="100px" height="100px"> 
	    	<br> ${list.p_name}
	    	</a>
	    </td>
	    <td> ${list.total_price} </td>
		<td> ${list.order_date.substring(0,10)} </td>
		<td> ${list.delivery_address} </td>
		<td> ${list.order_state} </td>
		<td> 
		<c:choose>
			<c:when test="${list.order_state eq '배송완료'}">
				<a data-orderID="${list.order_id}" data-pNAME="${list.p_name}" 
					data-pID="${list.p_id}"
					data-userid="${list.userid}"
					class="btn btn-outline-success chk" role="button">
					리뷰작성
				 </a>
				<input type="hidden" class="order_id" value="${list.order_id}">
				<input type="hidden" class="p_name" value="${list.p_name}">
				<input type="hidden" class="p_id" value="${list.p_id}">
			</c:when>
			<c:otherwise>
				<button type="button" class="btn btn-outline-secondary">배송현황</button> 
			</c:otherwise>
		</c:choose>
		</td>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="7" style="text-align: center;">
			<!-- 페이징 -->
				     <div class="p-2 text-center">
				        <c:if test="${myOrder.prev}">
				           <a class="paging" data-page="${myOrder.startPage-1}">prev&nbsp;&nbsp;</a>
				        </c:if>
				        <c:forEach var="p" begin="${myOrder.startPage}" end="${myOrder.endPage}">
				           <c:choose>
				              <c:when test="${p==myOrder.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
				              <c:otherwise><a class="paging" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
				             </c:choose>
				        </c:forEach>
				        <c:if test="${myOrder.next}">
				           <a class="paging" data-page="${myOrder.endPage+1}">next</a>
				        </c:if>
				     </div>
		</td>
	</tr>
</table>
</div>
</div>
</div>
</div>
</div>