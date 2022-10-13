<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#challDetailContent {
	width: 90%;
	margin: 0 auto;
	align-items: center;
	position: relative;
}
#img_area {
	position: relative;
}
td {
	align-items: center;
}
.img {
	display: block;
	margin-left: auto;
	margin-right: auto;
}
a {
	text-decoration: none;
	color: black;
}
.stamp {
	position: absolute; 
	left: 65%; 
	top: -3%; 
}
#modalBtn{
	display: none;
}
.modal-body{
	text-align: center;
}
#mesg{
	margin: 0;
}
</style>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		//챌린지 삭제 모달
	 	$("#deleteModal").on("shown.bs.modal", function (e) {
	 		let button = e.relatedTarget;
			let cid = button.getAttribute("data-bs-cid")
			$("#delchall_id").val(cid);
		});
		//챌린지 삭제
		$(".delChallBtn").on("click", function (e) {
			let chall_id = $("#delchall_id").val()
			$.ajax({
				url: '/zzp/admin/challenge/${dto.chall_id}',
				type: 'DELETE',
				success: function () {
					location.href = '/zzp/admin/challenge';
				},
				error: function () {
					alert('문제가 발생했습니다. 다시 시도해 주세요.');
				}
			})
		});
		//목록으로 돌아가기
		$(".backList").on("click", function () {
			let preUrl = document.referrer;
			//게시글 업데이트한 후 이동한 페이지에서는 글작성 페이지로 돌아가지 않도록 최신글 화면으로 이동한다.
			if (preUrl.includes("write")) {
				location.href = "/zzp/admin/challenge";
			} else {
				history.back();
			}
		});
		
	});
</script>


<div id="challDetailContent">
  <div class="row justify-content-md-center">
	 <div class="col-lg-8">
	  <table class="table table-borderless" style="margin: 0 auto;">
		<tr>
			<td width="10%" style="vertical-align: bottom;"><span class="fs-6 badge bg-success">${dto.chall_category}</span></td>
			<td rowspan="2" class="fs-4 fw-bold text-center" style="vertical-align: bottom;">${dto.chall_title}</td>
			<td class="text-end">
				<a href="/zzp/admin/challenge/write/${dto.chall_id}" class="btn btn-outline-success">수정</a> 
				<button type="button" class="btn btn-outline-success" 
						data-bs-toggle="modal" data-bs-target="#deleteModal" data-bs-cid="${dto.chall_id}">삭제</button>
			</td>
		</tr>
		<tr>
			<td width="10%">${dto.chall_created}</td>
			<td class="text-end">조회수 ${dto.chall_hits}</td>
		</tr>
		<tr>
			<td colspan="2">
			    <a href="/zzp/profile/${dto.userid}">
				   <img src="/upload/profile/${dto.profile_img}" width="50" height="50" class="ms-5 mx-3" onerror="this.src='/zzp/resources/images/error/user.png'"></a>
				<a href="/zzp/profile/${dto.userid}">${dto.userid}</a>
			</td>
		</tr>
		<tr id="img_area">
			<td colspan="3">
				<img src="/upload/challenge/${dto.chall_img}" class="img"
					onerror="this.src='/zzp/resources/images/error/salad.jpg'" width="80%">
				<img src="/upload/challenge/${dto.stamp_img}" class="stamp" width="25%">
			</td>
		</tr>
		<tr>
			<td colspan="3" class="text-center">
			  <div class="row">
				<div id="liked_area" class="col">
				  <c:choose>
					<%-- 해당 게시글을 현재 로그인한 회원이 좋아요했던 경우 --%>
					<c:when test="${likedIt == 1}">
						<img src="/zzp/resources/images/challenge/liked.png" width="40" height="40" class="liked">
					</c:when>
					<%-- 그외의 경우 --%>
					<c:otherwise>
						<img src="/zzp/resources/images/challenge/like.png" width="40" height="40" class="liked">
					</c:otherwise>
				  </c:choose>
					<span id="likeNum">${dto.chall_liked}</span>
				</div>
				<div class="col">
					<img src="/zzp/resources/images/challenge/bubble.png" width="37" height="35"> 
					<span id="commentsNum">${dto.chall_comments}</span>
				</div>
			  </div>
			</td>
		</tr>
		<tr>
			<td colspan="3">${dto.chall_content}</td>
		</tr>
		<tr>
			<td>
				<img src="/upload/challenge/${dto.stamp_img}" class="thumb-stamp uploadBtn-stamp" id="uploadarea-stamp" width="300" height="300">
			</td>
			<td colspan="2" style="vertical-align : middle;">
				<span><span class="fs-4 fw-bold text-center">${dto.stamp_name}</span><br>
				${dto.stamp_content}</span>
			</td>
		</tr>
	  </table>
	 </div>
  </div>
</div>



		<!-- Modal -->
			<div id="deleteModal" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="delete-title">ZZP</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        게시글을 삭제하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <input type="hidden" id="delchall_id">
			        <button type="button" class="delChallBtn btn btn-success">삭제</button>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			      </div>
			    </div> 
			  </div>
			</div>