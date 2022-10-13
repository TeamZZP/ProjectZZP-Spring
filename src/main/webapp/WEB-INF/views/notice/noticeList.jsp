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
	.paging {
	    cursor: pointer;
	    color: green;
	}
	#noticeListTable {
		text-align: center; 
		border-collapse: collapse;
		
	}
	.tableTop {
	border-bottom-color: #24855B;
	border-bottom-width: 2.5px;
	}
	.modal-body{
		text-align: center;
	}	
	#mesg{
		margin: 0;
	}
	#modalBtn{
		display: none;
	}
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:if test="${!empty mesg}">
	<script>
		$(document).ready(function () {
			$("#modal").trigger("click");
			$("#mesg").text("${mesg}");
		});
	</script>
</c:if>

<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="/zzp/resources/images/notice/notice3.png" alt="..." style="width: auto;">
	</div>
<div style="margin: 0 100px;">
   <table id="noticeListTable" class="table table-hover">
		<tr class="tableTop">
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
    </table>
    <div>
    	<c:if test="${mDTO.role == 1}">
			<form method="get" action="notice/write">
				<div style="text-align: right; padding-right: 10px;">
					<button type="submit" class="btn btn-outline-success">공지 글쓰기</button> 
				</div>
			</form>
		</c:if>
    </div>
	<div class="p-2 text-center">
		<c:if test="${pDTO.prev}">
			<a class="paging" data-page="${pDTO.startPage-1}">prev&nbsp;&nbsp;</a>
		</c:if>
		<c:forEach var="p" begin="${pDTO.startPage}" end="${pDTO.endPage}">
			<c:choose>
				<c:when test="${p==pDTO.page}">
					<b>${p}</b>&nbsp;&nbsp;</c:when>
				<c:otherwise>
					<a class="paging" href="notice?page=${p}" data-page="${p}">${p}&nbsp;&nbsp;</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pDTO.next}">
			<a class="paging" data-page="${pDTO.endPage+1}">next</a>
		</c:if>
	</div>
</div>

<!-- Button trigger modal -->
<button type="button" id="modal" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#noticeModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="noticeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">ZZP</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <span id="mesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>