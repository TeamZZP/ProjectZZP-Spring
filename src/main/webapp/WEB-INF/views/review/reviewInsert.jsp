<%@page import="java.util.List"%>
<%@page import="com.dto.PageDTO"%>
<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	<script type="text/javascript">
		$(document).ready(function() {
			$("input").keydown(function () {
				if(event.keyCode == 13){
					return false;
				}
			});
			$("#review.title").focus();
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
				$("#reviewForm").attr("action", "/zzp/mypage/{userid}/review");
			});//
			$("#reviewInsert").click(function () {
				var userid = $(this).attr("data-userid");
				$("#reviewForm").attr("action", "/zzp/review?userid="+userid);
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
		});//end ready
	</script>
<div style="text-align: center; display: flex; justify-content:center; height: 100px; margin-bottom: 10px;" >
		<img src="/zzp/resources/images/review/reviewMain.png" alt="..." style="width: auto;">
</div>

<form id="reviewForm" encType="multipart/form-data" method="post">
<input type="hidden" name="userid" value="${mDTO.userid}">
<div class="container justify-content-center">
<div class="row">
		<table>
			<tr> 
				<td> 
					<input type="hidden" name="order_id" value="${review.order_id}">
					<input type="hidden" name="p_id" value="${review.p_id}">
					<div class="input-group">
					  <span class="input-group-text">주문한 상품</span>
					  <input type="text" class="form-control" value="${review.p_name}" readonly="readonly">
					</div>
				</td>
				<td colspan="2"> 
					<div class="input-group">
					  <label class="input-group-text" for="inputGroupSelect01">구매 만족도</label>
					  <select class="form-select"  name="review_rate">
					    <option value="만족" selected>만족</option>
					    <option value="보통">보통</option>
					    <option value="불만족">불만족</option>
					  </select>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<div class="input-group">
					  <span class="input-group-text">제목</span>
					  <input type="text" class="form-control" name="review_title" id="review_title">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>
					  <textarea class="form-control" rows="15" cols="50" name="review_content" id="review_content" placeholder="내용을 입력하십시오."></textarea>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div>
					  <input class="form-control" accept="image/*" type="file" name="review_img" id="review_img" multiple>
					</div>
				</td>
			</tr>
			<tr>
				<td> <button id="reviewList" class="btn btn-success">목록</button> </td>
				<td style="text-align: right;">
					<button id="reviewInsert" data-userid="${mDTO.userid}" class="btn btn-success">등록</button>
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