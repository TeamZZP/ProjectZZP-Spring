<%@page import="com.dto.ImagesDTO"%>
<%@page import="com.dto.PageDTO"%>

<%@page import="com.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<!-- 부트스트랩 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>

<style>
	a{
		text-decoration: none;
	}
	.paging {
	    cursor: pointer;
	    color: green;
	}
	table {
		border: 1px solid #24855B;
		vertical-align: middle;
		text-align: center;
	}
	table tr {
		border: 1px solid green;
	}
	.paging {
		   cursor: pointer;
	}
</style>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {
			$(".check").click(function () {
				var p_id = $(this).attr("data-pID");
				var p_name = $(this).attr("data-pName");
				opener.$("#p_name").val(p_name);
				opener.$("#p_id").val(p_id);
				window.close();
			});
			$('.paging').on('click', function() {
				   $('#page').val($(this).attr('data-page'));
				   $('form').submit();
			});
			$("#prodNum").change(function () {
				$("form").submit();
			});
		})//end ready
	</script>
</head>
<body>
	<form action="/zzp/qna/search" method="get">
	<div class="container justify-content-center">
	<div class="row">
	<input type="hidden" name="page" value="1" id="page">
	<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
	<table>
		<tr>
			<td>
				<select  name="category" id="category" class="form-select">
					<option value="p_name" <c:if test="${category == 'p_name'}"> selected="selected" </c:if>>상품명</option>
					<option value="p_id" <c:if test="${category == 'p_id'}"> selected="selected" </c:if>>상품코드</option>
				</select>
			</td>
			<td colspan="2">
				<div class="input-group"> 
				  <input type="text" name="searchValue" id="searchValue" 
				  	<c:if test="${!empty searchValue}"> value="${searchValue}"</c:if> class="form-control">
				  <button class="btn btn-outline-secondary" type="submit" id="search">검색하기</button>
				</div>
			</td>
		</tr>
		<tr>
			<td style="color: blue; text-align: left;" colspan="2">
				<c:choose>
					<c:when test="${prodSelectCount != null}">
						${prodSelectCount} 개의 상품이 검색되었습니다.
					</c:when>
					<c:otherwise>
						0 개의 상품이 검색되었습니다.
					</c:otherwise>
				</c:choose>
			</td>
			<td> 
				<select class="form-select" name="prodNum" id="prodNum">
					<option value="5" <c:if test="${prodNum == 5}"> selected="selected" </c:if>>5개씩보기</option>
					<option value="10" <c:if test="${prodNum == 10}"> selected="selected" </c:if>>10개씩보기</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>상품 이미지</td>
			<td>상품 정보</td>
			<td>선택</td>
		</tr>
		<c:forEach var="list" items="${prodSelect.list}">
		<tr>
			<td> <img alt="상품사진" src="${contextPath}/resources/images/product/p_image/${list.image_route}" width="100px" height="100px"></td>
			<td style="text-align: left;"> ${list.p_name} <br> ${list.p_content} <br> ${list.p_cost_price}원 </td>
			<td> <button class="btn btn-outline-success check" data-pID="${list.p_id}" data-pName="${list.p_name}" >선택</button> </td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="3">
			  <div class="p-2 text-center">
			       <!-- 페이징 -->
				     <div class="p-2 text-center">
				        <c:if test="${prodSelect.prev}">
				           <a class="paging" data-page="${prodSelect.startPage-1}">prev&nbsp;&nbsp;</a>
				        </c:if>
				        <c:forEach var="p" begin="${prodSelect.startPage}" end="${prodSelect.endPage}">
				           <c:choose>
				              <c:when test="${p==prodSelect.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
				              <c:otherwise>
				              	<a class="paging" data-page="${p}">
				              		<c:if test="${p != 0}">${p}&nbsp;&nbsp;</c:if>
				              	</a>
				              </c:otherwise>
				             </c:choose>
				        </c:forEach>
				        <c:if test="${prodSelect.next}">
				           <a class="paging" data-page="${prodSelect.endPage+1}">next</a>
				        </c:if>
				     </div>
			    </div>
			</td>
		</tr>
	</table>
	</div>
	</div>
</form>
</body>
</html>