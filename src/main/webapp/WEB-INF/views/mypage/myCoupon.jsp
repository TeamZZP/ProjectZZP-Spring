<%@page import="com.dto.CouponMemberCouponDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function () {
		$("#searchCategory").change(function () {
			var searchCategory = $("#searchCategory").val();
			location.href = "/zzp/mypage/${mDTO.userid}/coupon?searchCategory="+searchCategory;
		});
	});// end ready	
</script>
<div id="addContainer">
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
	   		<a href="/zzp/mypage/${mDTO.userid}/review">내 구매후기</a>
	   </div>
	   <div class="col">
	   		<a href="/zzp/mypage/${mDTO.userid}/coupon" class="currCategory">내 쿠폰함</a>
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
<div style="">
	<form id="myCouponSearchForm" method="post">
		<input type="hidden" name="page" value="1" id="page">
		<div class="row">
			<div class="col-md-9"></div>
			<div class="col-md-3"> 
				<select id="searchCategory" name="searchCategory" class="form-select" aria-label="Default select example">
					<option selected disabled hidden>정렬</option>
					<option value="coupon_discount" 
						<c:if test="${search != null && search.searchCategory eq '할인율 높은순'}"> selected="selected"</c:if> >
						할인율 높은순
					</option>
					<option value="coupon_validity" 
						<c:if test="${search != null && search.searchCategory eq '만료일순'}"> selected="selected"</c:if>>
						만료일순 
					</option>
				</select>
			</div>
		</div>
	</form>		
</div>
<table id="addTable" class="table table-hover" style="text-align: center; vertical-align: middle;">
	<tr class="tableTop">
		<th>쿠폰번호</th>
		<th>쿠폰이미지</th>
		<th>쿠폰명</th>
		<th>할인율</th>
		<th>사용여부</th>
		<th>만료일</th>
	</tr>
	<c:forEach var="list" items="${myCoupon.list}">
	<tr>
		<td> ${list.coupon_id} </td>
	    <td> <img alt="쿠폰" src="/zzp/resources/images/coupon/${list.coupon_img}" width="50" height="50"> </td>
		<td> ${list.coupon_name} </td>
		<td> ${list.coupon_discount} </td>
		<td> 
			<c:choose>
				<c:when test="${list.coupon_used == null}">
					미사용
				</c:when>
				<c:otherwise>
					사용
				</c:otherwise>
			</c:choose>
		</td>
		<td> ${list.coupon_validity.substring(0,10)} </td>
	</tr>
	</c:forEach>
	<tr>
		<td colspan="6" style="text-align: center;">
			<div class="p-2 text-center">
				<c:if test="${myOrder.prev}">
					 <a class="paging" data-page="${myCoupon.startPage-1}">prev&nbsp;&nbsp;</a>
					</c:if>
					<c:forEach var="p" begin="${myCoupon.startPage}" end="${myCoupon.endPage}">
					<c:choose>
						<c:when test="${p==myCoupon.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
						<c:otherwise><a class="paging" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
					</c:choose>
					</c:forEach>
					<c:if test="${myCoupon.next}">
					<a class="paging" data-page="${myCoupon.endPage+1}">next</a>
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