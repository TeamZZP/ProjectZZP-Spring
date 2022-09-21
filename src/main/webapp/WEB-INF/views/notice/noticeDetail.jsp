<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
   <c:if test="${!empty mesg}">
		<script>
			alert("${mesg}");
		</script>
	</c:if>
	
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
			$(document).ready(function () {
				$("#noticeUpdate").click(function () {
					$("form").attr("method", "get").attr("action", "../notice/write/${nDTO.notice_id}");
				});
				$("#noticeDelete").click(function () {
					$("form").attr("action", "../notice/${nDTO.notice_id}");
				});
			});//end ready
	</script>
	
	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="../resources/images/notice/notice3.png" alt="..." style="width: auto;">
	</div>
	
	<form action="" method="post">
	<input type="hidden" name="_method" value="delete">
	
	<div class="container justify-content-center">
	<div class="row">
		<input type="hidden" name="notice_id" value="${nDTO.notice_id}">
		<table style="border-collapse: collapse;" >
			<tr>
				<td colspan="2">
					<div class="input-group shadow-none">
						 <span class="input-group-text">글번호</span>
						 <input type="text" class="form-control shadow-none"  value="${nDTO.notice_id}" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="input-group shadow-none">
						 <span class="input-group-text">제목</span>
						 <input type="text" class="form-control shadow-none"  value="${nDTO.notice_tittle}" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="input-group mb-3">
					  <span class="input-group-text">작성일</span>
					  <input type="text" class="form-control shadow-none" value="${nDTO.notice_created.substring(0,10)}" readonly="readonly">
					</div>
				</td>
				<td>
					<div class="input-group mb-3">
					  <span class="input-group-text">조회</span>
					  <input type="text" class="form-control shadow-none" value="${nDTO.notice_hits}" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea class="form-control shadow-none" rows="15" cols="50" readonly="readonly"> ${nDTO.notice_content} </textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="input-group col-mb-3">
						 <a class="btn btn-outline-success col-md-2" href="../notice" style="text-decoration: none;"> 목록 </a>
						 <c:if test="${!empty nextDTO}">
							  <button class="btn btn-outline-success col-md-2" type="button" 
							  	onclick="location.href='../notice/${nextDTO.notice_id}?category=${nextDTO.notice_category}'">
							  	다음글
							  </button>
							  <a class="col-md-8" href="../notice/${nextDTO.notice_id}?category=${nextDTO.notice_category}" 
							  	style="text-decoration: none;">
								 <input style="text-align: center;" type="url" class="form-control shadow-none" 
								 	value="${nextDTO.notice_tittle}" readonly="readonly">
							  </a>
						  </c:if>
					</div>
				</td>
			</tr>
			<tr>
				<c:if test="${mDTO.role == 1}">
					<td colspan="2" style="text-align: right;">
						<button class="btn btn-outline-success" id="noticeUpdate"> 수정 </button>
						<button class="btn btn-outline-success" id="noticeDelete"> 삭제 </button>
					</td>
				</c:if>
			</tr>
		</table>
	</div>
	</div>
	</form>