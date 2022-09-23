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
		})//end ready
	</script>
</head>
<body>
<%
	String category = request.getParameter("category"); //카테고리
	String searchValue = request.getParameter("searchValue"); //검색어
	if(searchValue == null){searchValue = "";}
%>
	<form action="/zzp/qna/search" method="post">
	<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
		<table border="1" style="border-collapse: collapse; border: 1px solid green;">
			<tr>
				<td>
					<select  name="category" id="category" class="form-select">
						<option value="p_name" <c:if test="${category == 'p_name'}"> selected="selected" </c:if>>상품명</option>
						<option value="p_id" <c:if test="${category == 'p_id'}"> selected="selected" </c:if>>상품코드</option>
					</select>
				</td>
				<td colspan="2">
					<div class="input-group">
					  <input type="text" name="searchValue" id="searchValue" value="${searchValue}" class="form-control">
					  <button class="btn btn-outline-secondary" type="submit" id="search">검색하기</button>
					</div>
				</td>
			</tr>
	<%
		Integer prodSelectCount = (Integer)request.getAttribute("prodSelectCount");
		if(prodSelectCount == null){prodSelectCount = 0;}
	%>
		<tr>
			<td style="color: blue;" colspan="2">총 <%=prodSelectCount%> 개의 상품이 검색되었습니다.</td>
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
			<td> ${list.p_name} <br> ${list.p_content} <br> ${list.p_cost_price}원 </td>
			<td> <button class="btn btn-outline-success check" data-pID="${list.p_id}" data-pName="${list.p_name}" >선택</button> </td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="3">
			  <c:set var="totalPage" value="${prodSelect.totalCount/prodSelect.perPage}" />
			  <c:forEach var="p" begin="1" end="${totalPage+(1-(totalPage%1))%1}">
			  	<c:choose>
			  		<c:when test="${p==prodSelect.curPage}"><b>${p}</b>&nbsp;&nbsp;</c:when>
			  		<c:otherwise>
			  			<a style='color: green; text-decoration: none;' id="prodSelect"
				  		href='search?curPage=${p}&category=${category}&searchValue=${searchValue}&prodNum=${prodNum}'>
				  			 ${p}&nbsp;&nbsp;
			  			</a> 
			  		</c:otherwise>
			  	</c:choose>
			</c:forEach>
			</td>
		</tr>
	</table>
</form>
</body>
</html>