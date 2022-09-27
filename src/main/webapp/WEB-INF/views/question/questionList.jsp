<%@page import="com.dto.QuestionProductDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
	a{
		text-decoration: none;
		color: green;
	}
	.paging {
   	 	cursor: pointer;
</style>

<c:if test="${!empty mesg}">
	<script>
		alert("${mesg}");
	</script>
</c:if>
	
    <table  style="text-align: center;" class="table table-hover">
    	<tr>
    		<td>번호</td>
    		<td>상품명</td>
    		<td>카테고리</td>
    		<td>제목</td>
    		<td>작성일</td>
    		<td>작성자</td>
    		<td>답변상태</td>
    	</tr>
	 <c:forEach var="list" items="${pDTO.list}">
	 	<tr>
    		<td> ${list.q_id} </td>
    		<c:if test="${list.p_name == null}">
	    		<td> - </td>
	    	</c:if>
	    	<c:if test="${list.p_name != null}">
	    		<td> ${list.p_name} </td>
    		</c:if>
    		<td>  ${list.q_category} </td>
    		<td> <a style="text-decoration: none; color: black;" 
    			href="qna/${list.q_id}?userid=${list.userid}&before=quesrionList"> ${list.q_title} </a> </td>
    		<td> ${list.q_created.substring(0,10)} </td>
    		<td> 
    			${list.userid.substring(0,2)}****${list.userid.substring(6)}
    		</td>
    		<td <c:if test="${list.q_status == '답변완료'}">style="color: green;"</c:if>> ${list.q_status} </td>
    	</tr>
    </c:forEach>
    <tr>
		<td colspan="7">
		 <!-- 페이징 -->
			     <div class="p-2 text-center">
			        <c:if test="${pDTO.prev}">
			           <a class="paging" data-page="${pDTO.startPage-1}">prev&nbsp;&nbsp;</a>
			        </c:if>
			        <c:forEach var="p" begin="${pDTO.startPage}" end="${pDTO.endPage}">
			           <c:choose>
			              <c:when test="${p==pDTO.page}"><b>${p}</b>&nbsp;&nbsp;</c:when>
			              <c:otherwise><a class="paging" href="qna?page=${p}" data-page="${p}">${p}&nbsp;&nbsp;</a></c:otherwise>
			             </c:choose>
			        </c:forEach>
			        <c:if test="${pDTO.next}">
			           <a class="paging" data-page="${pDTO.endPage+1}">next</a>
			        </c:if>
			     </div>
		</td>
	</tr>
    <tr>
    	<td colspan="6"></td>
    	<td>  
    		<button class="btn btn-outline-success" onclick="location.href='qna/write'">글쓰기</button>
    	</td>
    </tr>
    </table>
   