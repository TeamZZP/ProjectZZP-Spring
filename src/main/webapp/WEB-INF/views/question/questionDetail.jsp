<%@page import="com.dto.AnswerDTO"%>
<%@page import="com.dto.QuestionProductDTO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.QuestionDTO"%>
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
		$("#questionList").click(function () {
			var preUrl = document.referrer; //이전페이지 url정보
			if (preUrl.includes("qna")) {
				 $("#detailForm").attr("method", "get").attr("action", "/zzp/qna");
			} else {
				 $("#detailForm").attr("method", "get").attr("action", "/zzp/mypage/${qDTO.userid}/question");
			}
		});//
		$("#questionUpdate").click(function () {
			location.href = "/zzp/qna/write/${qDTO.q_id}";
			event.preventDefault();
		});//
		$("#questionDelete").click(function () {
			$("#detailForm").attr("action", "/zzp/qna/${qDTO.q_id}");
		});//
		$("#before").click(function () {
			history.back();
			event.preventDefault();
		});//
		if ($("#pId").val() == "null") {
			$("#pId").val("");
		}//
		$("#answerBtn").click(function() {
			$.ajax({
				type:"post",
				url:"/zzp/qna/${qDTO.q_id}/answer",
				data:{
					answer : $("#answer").val()	
				},
		        dataType: "text",
				success: function (data, status, xhr) {
					$("#modal").trigger("click");
					$("#mesg").text("답변이 작성되었습니다.");
					$("#answerCheck").text($("#answer").val());
					$("#answer").val("");
				},
				error: function (xhr, status, error) {

				}
			});//end ajax
		});//
		$("#uploadBtu").click(function () {
			var upload = $("#upload").attr("src");
			window.open("/zzp/showImg", "", "width=400px height=500px");
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
				<c:choose>
					<c:when test="${qDTO.q_img == null || qDTO.q_img eq 'null'}">
						<td colspan="2"></td>
					</c:when>
					<c:otherwise>
						<td colspan="2">
							<div>
							  	<button type="button" class="btn btn-secondary" id="uploadBtu" style="padding: 2rem;">첨부파일</button>
							  	<img id="upload" alt="" src="/upload/qna/${qDTO.q_img}" width="100px" height="100px" style="border: 1px solid gray;">
							</div>
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td colspan="2">
					<div class="input-group">
					  <span class="input-group-text">답변</span>
					  <textarea class="form-control shadow-none" readonly="readonly" id="answerCheck"><c:if test="${!empty aDTO}">${aDTO.answer_content}</c:if><c:if test="${aDTO == null}">${qDTO.q_status}</c:if></textarea>
					</div> 
				</td>
			</tr>
			<c:if test="${mDTO.userid == qDTO.userid}">
			<tr>
				<td>
					<button id="questionList" class="btn btn-outline-success" >목록</button> 
				</td>
				<td style="text-align: right;">
					<button id="questionUpdate" class="btn btn-outline-success" >수정</button> 
				 	<button id="questionDelete" class="btn btn-outline-success" >삭제</button>
				</td>
			</tr>
			</c:if>
			<c:if test="${mDTO.role == 1}">
			<tr>
				<td colspan="2">
					<div class="input-group"> 
					  <textarea class="form-control" id="answer"></textarea>
					  <button class="btn btn-outline-secondary" type="button" id="answerBtn" data-qid="${qDTO.q_id}">답변하기</button>
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