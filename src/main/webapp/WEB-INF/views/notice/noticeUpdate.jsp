<%@page import="com.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
   <c:if test="${!empty mesg}">
		<script>
			alert("${mesg}");
		</script>
	</c:if>
	
	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="/zzp/resources/images/notice/notice3.png" alt="..." style="width: auto;">
	</div>
	
	<form action="/zzp/notice/${dto.notice_id}" method="post">
	<input type="hidden" name = "_method" value = "put"/>
	<div class="container justify-content-center">
	<div class="row">
		<input type="hidden" name="nId" value="${dto.notice_id}">
		<table border="1" style="border-collapse: collapse;">
			<tr>
				<td colspan="2"> 
					<div class="input-group">
						 <span class="input-group-text">제목</span>
						 <input type="text" class="form-control" name="notice_tittle" id="nTittle"  value="${dto.notice_tittle}">
					</div>
				</td>
			</tr>
			<tr>
				<td>
					 작성일 <input type="text" class="form-control" value="${dto.notice_created.substring(0,10)}">
				</td>
				<td>
					조회수 <input type="text" class="form-control" value="${dto.notice_hits}">
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<textarea rows="10" cols="50" name="notice_content"  class="form-control">${dto.notice_content}</textarea> 
				</td>
			</tr>
			<tr>
				<td><button type="button" onclick="location.href='/zzp/notice'" class="btn btn-success">목록보기</button></td>
				<td style="text-align: right;">
					<button type="submit" class="btn btn-success">수정 완료</button>
				</td>
			</tr>
		</table>
	</div>
	</div>
	</form>