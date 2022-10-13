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
		cursor: pointer;
	}
	a:hover {
		color: green;
		font: bold;
	}
	.paging {
   	 	cursor: pointer;
   	}
   	.tableTop {
		border-bottom-color: #24855B;
		border-bottom-width: 2.5px;
	} 	
	.userChk {
		text-decoration: none; 
		color: black;
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

<script>
	$(document).ready(function () {
		$(".userChk").click(function () {
			var writer = $(this).attr("data-writer");
			var loginUser = $(this).attr("data-userid");
			var manager = $(this).attr("data-manager");
			var q_id = $(this).attr("data-q_id");
			if (writer == loginUser || manager == 1){
				$(this).attr("href", "/zzp/qna/"+q_id);
			} else {
				$("#modal").trigger("click");
				$("#mesg").text("다른 사용자의 글 입니다.");
			}
		});//
		$("#questionInsert").click(function () {
			var role = $(this).attr("data-role");
			if(role != 1){
				location.href='qna/write'
			} else {
				$("#modal").trigger("click");
				$("#mesg").text("글쓰기 권한이 없습니다.");
			}
		});//
	}); //end ready
</script>

<table style="text-align: center;" class="table table-hover">
	<tr class="tableTop">
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
			<td>${list.q_id}</td>
			<c:if test="${list.p_name == null}">
				<td>-</td>
			</c:if>
			<c:if test="${list.p_name != null}">
				<td>${list.p_name}</td>
			</c:if>
			<td>${list.q_category}</td>
			<td><a class="userChk" data-writer="${list.userid}"
				data-userid="${mDTO.userid}" data-manager="${mDTO.role}" data-q_id="${list.q_id}"> ${list.q_title} </a>
			</td>
			<td>${list.q_created.substring(0,10)}</td>
			<td>
				${list.userid.substring(0,2)}****${list.userid.substring(6)}
			</td>
			<td
				<c:if test="${list.q_status == '답변완료'}">style="color: green;"</c:if>>
				${list.q_status}
			</td>
		</tr>
	</c:forEach>
</table>
<div style="text-align: right;">
    <button class="btn btn-outline-success" id="questionInsert" data-role="${mDTO.role}">글쓰기</button>
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
				<a class="paging" href="qna?page=${p}" data-page="${p}">${p}&nbsp;&nbsp;</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${pDTO.next}">
		<a class="paging" data-page="${pDTO.endPage+1}">next</a>
	</c:if>
</div>

<!-- Button trigger modal -->
<button type="button" id="modal" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#questionModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="questionModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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