<%@page import="com.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
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
<script>
	$(document).ready(function () {
		$("input").keydown(function () {
			if(event.keyCode == 13){
				return false;
			}
		});
		$("#nTittle").focus();
		$("#noticeUpdate").click(function () {
			var nTittle = $("#nTittle").val();
			var nContent = $("#nContent").val();
			if (nTittle.length == 0) {
				$("#modal").trigger("click");
				$("#mesg").text("제목을 입력하십시오.");
				event.preventDefault();
			} else if (nContent.length == 0) {
				$("#modal").trigger("click");
				$("#mesg").text("내용을 입력하십시오.");
				event.preventDefault();
			}
		});
	});;//end ready
</script>
	
	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="/zzp/resources/images/notice/notice3.png" alt="..." style="width: auto;">
	</div>
	
	<form action="/zzp/notice/${dto.notice_id}" method="post">
	<input type="hidden" name = "_method" value = "put"/>
	<div class="container justify-content-center">
	<div class="row">
		<input type="hidden" name="nId" value="${dto.notice_id}">
		<table style="border-collapse: collapse;">
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
					<div class="input-group">
						 <span class="input-group-text"> 작성일</span>
						 <input type="text" class="form-control" value="${dto.notice_created.substring(0,10)}">
					 </div>
				</td>
				<td>
					<div class="input-group">
						 <span class="input-group-text"> 조회수</span>
						 <input type="text" class="form-control" value="${dto.notice_hits}">
					</div>
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
					<button id="noticeUpdate" type="submit" class="btn btn-success">수정 완료</button>
				</td>
			</tr>
		</table>
	</div>
	</div>
	</form>
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