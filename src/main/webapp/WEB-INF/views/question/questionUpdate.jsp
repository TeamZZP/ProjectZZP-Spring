<%@page import="com.dto.QuestionProductDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@page import="com.dto.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function () {
		$("#questionUpdate").click(function() {
			var q_title = $("#q_title").val();
			var qContent = $("#q_content").val();
			if (q_title.length == 0) {
				alert("제목을 입력하십시오");
				event.preventDefault();
			} else if (q_content.length == 0) {
				alert("내용을 입력하십시오");
				event.preventDefault();
			}
		});
		if ($("#p_id").val() == 0) {
			$("#p_id").val("");
		}
		$("#questionUpdate").click(function () {
			$("#questionForm").attr("action", "/zzp/qna/${dto.q_id}");
		});
		$("#prodSel").click(function() {
 			var url = "/zzp/qna/pop"
 			window.open(url, "", "width=400px height=500px");
 		});
		$("#QuestionList").click(function () {
			$("#questionForm").attr("action", "/zzp/qna");
		});
		$("#uploadBtu").click(function () {
			var upload = $("#upload").attr("src");
			var url = "../qna/${qDTO.q_id}/showImg"
			window.open(url, "", "width=400px height=500px");
		});
		function checkFileExtension(){ 
			let fileValue = $("#qFile").val(); 
			let reg = /(.*?)\.(jpg|jpeg|png|gif)$/;
			if (fileValue.match(reg)) {
				return true;
			} else {
				alert("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
				return false;
			}
		}
	});//end ready
</script>
<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="/zzp/resources/images/question/question.png" alt="..." style="width: auto;">
</div>
<form id="questionForm" method="post" enctype="multipart/form-data">
<div class="container justify-content-center">
<div class="row">
 <input type="hidden" name="q_id" value="${dto.q_id}">
 <input type="hidden" name="userid" value="${dto.userid}">
		<table>
			<tr>
				<td colspan="2">
					<div class="input-group">
					  <span class="input-group-text">제목</span>
					  <input type="text" class="form-control" name=q_title id="q_title" value="${dto.q_title}">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<div class="input-group">
					  <button id="prodSel" class="btn btn-outline-secondary" type="button">상품 정보</button>
					  <input type="text" class="form-control shadow-none"  <c:if test="${!empty dto.p_name}"> value="${dto.p_name}" </c:if> readonly="readonly" name="p_name" id="p_name">
					  <input type="hidden" class="form-control" <c:if test="${!empty dto.p_id}"> value="${dto.p_id}" </c:if> name="p_id" id="p_id">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<div class="input-group">
					  <label class="input-group-text" for="inputGroupSelect01">문의 글 카테고리</label>
					  <select class="form-select"  name="q_board_category">
					   	<option value="1" <c:if test="${1 == dto.q_board_category}"> selected="selected" </c:if>>상품문의</option>
						<option value="2" <c:if test="${2 == dto.q_board_category}"> selected="selected" </c:if>>문의 게시판</option>
					  </select> 
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="input-group">
					  <label class="input-group-text" for="inputGroupSelect01">질문 카테고리</label>
					  <select name="q_category" class="form-select">
					    <option <c:if test="${dto.q_category eq '상품'}">selected="selected"</c:if>>상품</option>
						<option <c:if test="${dto.q_category eq '배송'}">selected="selected"</c:if>>배송</option>
						<option <c:if test="${dto.q_category eq '교환'}">selected="selected"</c:if>>교환</option>
						<option <c:if test="${dto.q_category eq '환불'}">selected="selected"</c:if>>환불</option>
						<option <c:if test="${dto.q_category eq '기타'}">selected="selected"</c:if>>기타</option>
					  </select> 
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea class="form-control" rows="15" cols="50" name="q_content" id="q_content">${dto.q_content}</textarea>
				</td>
			</tr>
			<tr> 
				<c:choose>
					<c:when test="${dto.q_img == null || dto.q_img eq 'null'}">
					<td colspan="2">
						<input class="form-control" type="file" accept="image/*" name="qna_img" id="qFile">
					</td>
					</c:when>
					<c:otherwise>
						<td colspan="2">
							<div>
							  <button type="button" class="btn btn-secondary" id="uploadBtu" style="padding: 2rem;">첨부파일</button>
							  	<img id="upload" alt="" src="/zzp/resources/upload/qna/${qDTO.q_img}" width="100px" height="100px" style="border: 1px solid gray;">
							  	<input class="form-control" type="file" accept="image/*" name="qna_img">
							</div>
						</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td> <button id="QuestionList" class="btn btn-outline-success" >목록</button> </td>
				<td style="text-align: right;">
					<button type="submit" id="questionUpdate" class="btn btn-outline-success">등록</button>
					<button type="reset" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#aa">취소</button>
					
					<div class="modal fade" id="aa" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="staticBackdropLabel">취소</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body" style="text-align: left;">
					        Q&A게시판으로 이동하시겠습니까?
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-success" onclick="location.href='QuestionListServlet'">확인</button>
					        <button type="button" class="btn btn-success" data-bs-dismiss="modal">취소</button>
					      </div>
					    </div>
					  </div>
					</div>
				</td>
			</tr>
		</table>
</div>
</div>
</form>