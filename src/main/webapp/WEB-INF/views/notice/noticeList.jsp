<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	a{
		text-decoration: none;
		color: black;
	}
</style>
	<c:if test="${!empty mesg}">
		<script>
			alert("${mesg}");
		</script>
	</c:if>
	
	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="resources/images/notice/notice3.png" alt="..." style="width: auto;">
	</div>

	<c:if test="${mDTO.role == 1}">
		<form method="get" action="notice/write">
			<div style="text-align: right; padding-right: 10px;">
				<button type="submit" class="btn btn-outline-success">공지 글쓰기</button> 
			</div>
		</form>
	</c:if>
   <table border="1" style="text-align: center; border-collapse: collapse;" class="table table-hover">
		<tr style="background-color: #8FBC8F">
			<td>번호</td>
			<td>제목</td>
			<td>작성일</td>
			<td>조회</td>
		</tr>
    	<c:forEach var="point" items="${NoticePointList}">
    	<tr style="background: #DCDCDC">
    		<td> <b> ${point.notice_id} </b> </td>
    		<td> 
    			<a href="notice/${point.notice_id}?category=${point.notice_category}"> 
    				<b> ${point.notice_tittle} </b> 
    			</a> 
    		</td>
    		<td> <b>  ${point.notice_created.substring(0, 10)} </b> </td>
    		<td> <b>  ${point.notice_hits} </b> </td>
    	</tr>
    	</c:forEach>
		<c:forEach var="list" items="${pDTO.list}">
    	<tr>
    		<td> ${list.notice_id} </td>
    		<td><a href="notice/${list.notice_id}?category=${list.notice_category}"> ${list.notice_tittle} </a> </td>
    		<td> ${list.notice_created.substring(0,10)} </td>
    		<td> ${list.notice_hits} </td>
    	</tr>
    	</c:forEach>
		<tr>
			<td colspan="4">
			  <c:set var="totalPage" value="${pDTO.totalCount/pDTO.perPage}" />
			  <c:forEach var="p" begin="1" end="${totalPage+(1-(totalPage%1))%1}">
			  	<c:choose>
			  		<c:when test="${p==pDTO.curPage}"><b>${p}</b>&nbsp;&nbsp;</c:when>
			  		<c:otherwise><a style='color: green; text-decoration: none;' href="notice?curPage=${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
			  	</c:choose>
			  </c:forEach>
			</td>
		</tr>
    </table>