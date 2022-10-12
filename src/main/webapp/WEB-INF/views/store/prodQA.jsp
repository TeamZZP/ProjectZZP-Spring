<%@page import="com.dto.ProductDTO"%>
<%@page import="com.dto.AnswerDTO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.dto.QuestionDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function () {
		$(".questionDetail").click(function () {
			var q_id = $(this).attr("data-qID");
			var user = $(this).attr("data-user");
			var witer = $(this).attr("data-witer");
			console.log("클릭된 게시글 번호 " + q_id);
			if(user == witer){
				$.ajax({
					type:"get",
					url: "/zzp/product/qna",
					data:{
						q_id : $(this).attr("data-qID")
					},
					datatype:"text",
					success: function (data, status, xhr) {
						console.log(data);
						if (data != null) {
							$("#answer"+q_id).attr("display","none");
							$("#answer"+q_id).slideToggle("slow").html(data + 
							" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <i class='fa-solid fa-a' style='font-size: 50px';></i>")
							.css({'font-weight':'bold','border-bottom': '1px solid #8FBC8F'});
						}
					},
					error: function (xhr, status, error) {
						$("#modal").trigger("click");
						$("#mesg").text("문제가 발생했습니다. 다시 시도해 주세요.");
					}
				});//end ajax
			} else if (user == "") {
				$("#modal").trigger("click");
				$("#mesg").text("로그인이 필요합니다.");
			} else {
				$("#modal").trigger("click");
				$("#mesg").text("다른 유저의 글 입니다.");
			}
		}); //
		$("#QuestionInsert").click(function () {
			$("#prodQAForm").attr("action", "/zzp/qna/write");
		});// 
	}); //end ready
</script>
<style>
	table#prodQATable {
	  border-collapse: separate;
	  border-spacing: 0px;
	  text-align: left;
	  line-height: 1.5;
	  margin : 20px 10px;
	}
	table#prodQATable td {
	  width: 350px; 
	  padding: 10px;
	  vertical-align: top;
	  border-bottom: 1px solid #8FBC8F;
	  vertical-align: middle;
	}
</style>

<div style="text-align: center; color: gray;"> Q&A </div>
<form id="prodQAForm" method="get">
	<table id="prodQATable" style="text-align: center;">
		<tr>
			<td colspan="6" style="background-color: #8FBC8F; padding: 10px;"></td>
		</tr>
		<tr>
			<td colspan="6" style="display: none;">
				<input type="hidden" id="p_id" name="p_id" value="${pdto.p_id}">
				<input type="hidden" id="p_name" name="p_name" value="${pdto.p_name}">
			</td>
		</tr>
		<tr>
			<td></td>
			<td>답변상태</td>
			<td>작성자</td>
			<td>제목</td>
			<td>작성일</td>
			<td></td>
		</tr>
			<c:forEach var="qDTO" items="${prodQuestion}">
		<tr class="questionDetail" data-user="${mdto.userid}" data-witer="${qDTO.userid}" data-qID="${qDTO.q_id}" title="더블클릭">
			<td style="text-align: center;"><i class="fa-solid fa-q" style="font-size: 50px;"></i></td>
			<td>${qDTO.q_status}</td>
			<td>${qDTO.userid.substring(0,2)}****${qDTO.userid.substring(6)}</td>
			<td>${qDTO.q_title}</td>
			<td>${qDTO.q_created.substring(0, 10)}</td>
			<td style="text-align: center;"> <img alt="문의 답변 보기" src="/zzp/resources/images/question/down.png" width="20px" height="20px"> </td>
		</tr>
		<tr>
			<td colspan="6" style="border-bottom: none;">
				<div style="text-align: right; margin: 0px 82px;" id="answer${qDTO.q_id}"> 
					<span class="answer${qDTO.q_id}"> </span> 
				</div> 
			</td>
		</tr>
			</c:forEach>
	</table>
	<div style="text-align: right; padding-right: 50px;">
		<button type="submit" class="btn btn-outline-success" id="QuestionInsert">문의하기</button>
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