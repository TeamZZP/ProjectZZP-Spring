<%@page import="com.dto.ReviewProductDTO"%>
<%@page import="com.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.dto.ProductOrderReviewDTO"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="com.dto.MemberDTO"%>
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
<c:if test="${!empty mesg}">
	<script>
		$(document).ready(function () {
			$("#modal").trigger("click");
			$("#mesg").text("${mesg}");
		});
	</script>
</c:if>

	<script type="text/javascript">
		$(document).ready(function() {
			$("input").keydown(function () {
				if(event.keyCode == 13){
					return false;
				}
			});
			$("#review_title").focus();
			$("#reviewInsert").click(function() {
				var REVIEW_TITLE = $("#review_title").val();
				var REVIEW_CONTENT = $("#review_content").val();
				if (review_title.length == 0) {
					$("#modal").trigger("click");
					$("#mesg").text("제목을 입력하십시오.");
					event.preventDefault();
				} else if (review_content.length == 0) {
					$("#modal").trigger("click");
					$("#mesg").text("내용을 입력하십시오.");
					event.preventDefault();
				}
			});//
			$("#reviewList").click(function () {
				history.back();
				event.preventDefault();
			});//
			$("#reviewUpdate").click(function () {
				$("#reviewUpdateForm").attr("action", "/zzp/review/${review.review_id}");
			}); //
			function checkFileExtension(){ 
				let fileValue = $("#qFile").val(); 
				let reg = /(.*?)\.(jpg|jpeg|png|gif)$/;
				if (fileValue.match(reg)) {
					return true;
				} else {
					alert("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
					return false;
				}
			}//
			$("#uploadBtu").click(function () {
				$("#reviewUpdateForm").attr("method", "get");
				window.open("/zzp/showImg", "", "width=400px height=500px");
				event.preventDefault();
			});//
		});//end ready
	</script>
<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="/zzp/resources/images/review/reviewMain.png" alt="..." style="width: auto;">
</div>

<form id="reviewUpdateForm" encType="multipart/form-data" method="post">
<input type="hidden" name="userid" value="${mDTO.userid}">
<input type="hidden" name="oldFile" id="oldFile" value="${review.review_img}">
<div class="container justify-content-center">
<div class="row">
		<table>
			<tr> 
				<td> 
					<input type="hidden" name="review_id" value="${review.review_id}">
					<input type="hidden" name="order_id" value="${review.order_id}>">
					<input type="hidden" name="p_id" value="${review.p_id}">
					<div class="input-group">
					  <span class="input-group-text">주문한 상품</span>
					  <input type="text" class="form-control shadow-none" value="${review.p_name}" readonly="readonly">
					</div>
				</td>
				<td colspan="2"> 
					<div class="input-group">
					  <label class="input-group-text" for="inputGroupSelect01">구매 만족도</label>
					  <select class="form-select"  name="review_rate"> 
					    <option value="만족" <c:if test="${review.review_rate eq '만족'}"> selected="selected" </c:if>>만족</option>
					    <option value="보통" <c:if test="${review.review_rate eq '보통'}"> selected="selected" </c:if>>보통</option>
					    <option value="불만족" <c:if test="${review.review_rate eq '불만족'}"> selected="selected" </c:if>>불만족</option>
					  </select>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<div class="input-group">
					  <span class="input-group-text">제목</span>
					  <input type="text" class="form-control" name="review_title" id="review_title" value="${review.review_title}">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>
					  <textarea class="form-control" rows="15" cols="50" name="review_content" id="review_content" placeholder="내용을 입력하십시오.">${review.review_content}</textarea>
					</div>
				</td>
			</tr>
			<tr>
				<c:choose>
					<c:when test="${review.review_img == null || review.review_img eq 'null'}">
					<td colspan="2">
						<input class="form-control" type="file" accept="image/*" name="review_img" id="review_img">
					</td>
					</c:when>
					<c:otherwise>
					<td colspan="2">
						<div>
						  <button class="btn btn-secondary" id="uploadBtu" style="padding: 2rem;">첨부파일</button>
						  	<img id="upload" alt="" src="/upload/review/${review.review_img}" width="100px" height="100px" style="border: 1px solid gray;">
						  	<input class="form-control" type="file" accept="image/*" name="review_img">
						</div>
					</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td> <button id="reviewList" class="btn btn-success">목록</button> </td>
				<td style="text-align: right;">
					<button id="reviewUpdate" data-userid="${review.userid}" data-reviewID="${review.order_id}" class="btn btn-success">수정</button>
					<button id="reviewCancel" type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#bb">취소</button>
					
					<div class="modal fade" id="bb" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="staticBackdropLabel">취소</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body" style="text-align: left;">
					        이전 페이지로 돌아가시겠습니까?
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-success" onclick="history.back()">확인</button>
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

<!-- Button trigger modal -->
<button type="button" id="modal" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#reviewModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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