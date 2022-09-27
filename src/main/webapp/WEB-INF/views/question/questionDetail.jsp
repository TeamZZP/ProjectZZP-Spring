<%@page import="com.dto.AnswerDTO"%>
<%@page import="com.dto.QuestionProductDTO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function () {
		$("#questionList").click(function () {
			$("#detailForm").attr("method", "get").attr("action", "../qna");
		});//
		$("#questionUpdate").click(function () {
			location.href = "/zzp/qna/write/${qDTO.q_id}";
			event.preventDefault();
		});//
		$("#questionDelete").click(function () {
			$("#detailForm").attr("action", "../qna/${qDTO.q_id}");
		});//
		$("#before").click(function () {
			history.back();
			event.preventDefault();
		});//
		if ($("#pId").val() == "null") {
			$("#pId").val("");
		}//
		$("#answerBtn").click(function() {
			console.log($("#answer").val());
			$.ajax({
				type:"post",
				url:"../qna/${qDTO.q_id}/answer",
				data:{
					answer : $("#answer").val()	
				},
		        dataType: "text",
				success: function (data, status, xhr) {
					console.log(data.answer)
					$("#answerCheck").text($("#answer").val());
					$("#answer").text(data.answer);
				},
				error: function (xhr, status, error) {

				}
			});//end ajax
		});//
		$("#uploadBtu").click(function () {
			var upload = $("#upload").attr("src");
			var url = "../qna/${qDTO.q_id}/showImg"
			window.open(url, "", "width=400px height=500px");
		});
	});//end ready
</script>
	<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="/zzp/resources/images/question/question.png" alt="..." style="width: auto;">
	</div>
	<form method="post" id="detailForm">
	<input type="hidden" id="methodChange" name="_method" value="delete">
	<div class="container justify-content-center">
	<div class="row">
		<table>
			<tr>
				<td colspan="2"> 
					<div class="input-group">
					  <span class="input-group-text">제목</span>
					  <input type="text" class="form-control shadow-none" value="${qDTO.q_title}" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<td> 
					<div class="input-group">
					  <span class="input-group-text">작성일</span>
					  <input type="text" class="form-control shadow-none" value="${qDTO.q_created.substring(0,10)}" readonly="readonly">
					</div>
				</td>
				<td> 
					<div class="input-group">
					  <span class="input-group-text">작성자</span>
					  <input type="text" class="form-control shadow-none" value="${qDTO.userid}" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<th colspan="2"> 
					<div class="input-group">
					  <span class="input-group-text">상품정보</span>
					  <input type="text" class="form-control shadow-none" <c:if test="${!empty qDTO.p_name}"> value="${qDTO.p_name}" </c:if>  readonly="readonly">
					</div> 
				</th> 
			</tr>
			<tr>
				<td colspan="2">
				  <textarea class="form-control shadow-none" rows="15" cols="50" readonly="readonly"> ${qDTO.q_content} </textarea>
				</td>
			</tr>
			<tr>
			<c:if test="${qDTO.q_img ==null or qDTO.q_img == null}">
				<td></td>
			</c:if>
			<c:if test="${qDTO.q_img !=null}">
				<td>
					<div>
					  	<button type="button" class="btn btn-secondary" id="uploadBtu" style="padding: 2rem;">첨부파일</button>
					  	<img id="upload" alt="" src="/zzp/resources/upload/qna/${qDTO.q_img}" width="100px" height="100px" style="border: 1px solid gray;">
					</div>
				</td>
			</c:if> 
			</tr>
			<tr>
				<td colspan="2">
					<div class="input-group">
					  <span class="input-group-text">답변</span>
					  <textarea class="form-control shadow-none" readonly="readonly" id="answerCheck"><c:if test="${!empty aDTO}">${aDTO.answer_content}</c:if><c:if test="${aDTO == null}">${qDTO.q_status}</c:if></textarea>
					</div> 
				</td>
			</tr>
			<tr>
				<c:if test="${mDTO.userid == qDTO.userid}">
					<c:if test="${before eq 'myQuestion'}">
					<td>
						 <button class="btn btn-outline-success" id="before">이전</button> 
					</td>
					</c:if>
					<c:if test="${before eq 'quesrionList'}">
					<td>
					 	<button id="questionList" class="btn btn-outline-success" >목록</button> 
					</td>
					</c:if>
				<td style="text-align: right;">
					<button id="questionUpdate" class="btn btn-outline-success" >수정</button> 
				 	<button id="questionDelete" class="btn btn-outline-success" >삭제</button>
				</td>
				</c:if>
			</tr>
			<c:if test="${mDTO.role == 1}">
			<tr>
				<td colspan="2">
					<div class="input-group"> 
					  <textarea class="form-control" id="answer"><c:if test="${!empty aDTO}">${aDTO.answer_content}</c:if></textarea>
					  <button class="btn btn-outline-secondary" type="button" id="answerBtn" data-qid="${qDTO.q_id}">답글 올리기</button>
					</div>
				</td>
			</tr>
			<tr>
				<td>
				 	<button id="questionList" class="btn btn-outline-success" >목록</button> 
				</td>
				<td style="text-align: right;">
					<button id="questionDelete" class="btn btn-outline-success" >게시글 삭제</button>
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	</div>
	</form>