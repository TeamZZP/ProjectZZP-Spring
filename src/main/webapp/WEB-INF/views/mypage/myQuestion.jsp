<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="com.dto.QuestionProductDTO"%>
<%@page import="com.dto.QuestionDTO"%>
<%@page import="java.util.List"%>
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
	
	.paging {
		cursor: pointer;
	}
</style>  

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
	   		<a href="/zzp/mypage/${mDTO.userid}/coupon">내 쿠폰함</a>
	   </div>
	   <div class="col">
	   		<a href="ProfileCategoryServlet?category=mychallenge&userid=${mDTO.userid}">내 챌린지</a>
	   </div>
	   <div class="col">
	   		<a href="ProfileCategoryServlet?category=mystamp&userid=${mDTO.userid}">내 도장</a>
	   </div>
	   <div class="col">
	      <a href="/zzp/mypage/${mDTO.userid}/question" class="currCategory">내 문의 내역</a>
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
<table id="addTable" class="table table-hover" style="text-align: center;">
	<tr class="tableTop">
		<th>번호</th>
		<th>상품명</th>
		<th>카테고리</th>
		<th>제목</th>
		<th>작성일</th>
		<th>답변상태</th>
	</tr>
	<c:forEach var="list" items="${orderList.list}">
	<tr>
		<td> ${list.q_id} </td>
		<c:choose>
			<c:when test="${list.p_name == null}">
				<td> - </td>
			</c:when>
			<c:otherwise>
				<td> ${list.p_name} </td>
			</c:otherwise>
		</c:choose>
		<td> ${list.q_category} </td>
		<td>
			<a style="text-decoration: none; color: black;" 
    			href="/zzp/qna/${list.q_id}?userid=${list.userid}&before=myQuestion">
		  		${list.q_title}
		 	</a>
		</td>
		<td> ${list.q_created.substring(0,10)} </td>
		<td <c:if test="${list.q_status eq '답변완료'}"> style="color: green;" </c:if>> ${list.q_status} </td>
	</tr> 
	</c:forEach>
	<tr>
		<td colspan="6" style="text-align: center;">
			 <!-- 페이징 -->
			     <div class="p-2 text-center">
			        <c:if test="${orderList.prev}">
			           <a class="paging" data-page="${orderList.startPage-1}">prev&nbsp;&nbsp;</a>
			        </c:if>
			        <c:forEach var="p" begin="${orderList.startPage}" end="${orderList.endPage}">
			           <c:choose>
			              <c:when test="${p==orderList.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
			              <c:otherwise><a class="paging" href="/zzp/mypage/{userid}/myQuestion?page=${p}" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
			             </c:choose>
			        </c:forEach>
			        <c:if test="${orderList.next}">
			           <a class="paging" data-page="${orderList.endPage+1}">next</a>
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