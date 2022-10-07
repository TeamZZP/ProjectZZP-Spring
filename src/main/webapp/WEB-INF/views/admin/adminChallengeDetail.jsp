<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#challDetailContent {
	width: 700px;
	margin: 0 auto;
	align-items: center;
	position: relative;
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
</style>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		
		//글 삭제시 컨펌창 띄우기 
		$("#deleteChallenge").on("click", function () {
			let mesg = "정말 삭제하시겠습니까? 한번 삭제한 글은 되돌릴 수 없습니다.";
			if (confirm(mesg)) {
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
			}
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




<div class="container pt-5">
	<div id="challDetailContent">
		<div class="row">
		    <div class="d-flex w-75">
				<div class="w-50">${dto.chall_category}</div>
				<div class="w-50">${dto.chall_title}</div>
			</div>
			<div class="w-25">
			  <div class="float-end">
				<a href="/zzp/admin/challenge/write/${dto.chall_id}" class="btn btn-outline-success">수정</a> 
				<a id="deleteChallenge" class="btn btn-outline-success">삭제</a>
			   </div>
			</div>
		</div>
		<div style="height: 10px"></div>
		<div class="row">
			<div class="col">
				${dto.chall_created}
			</div>
			<div class="col">
			  <div class="float-end">
				조회수 ${dto.chall_hits}
			  </div>
			</div>
		</div>
		<div style="height: 10px"></div>
		<div class="row p-3">
			<div class="col">
				<a href="/zzp/profile/${dto.userid}">
				   <img src="/upload/profile/${dto.profile_img}" width="50" height="50"></a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="/zzp/profile/${dto.userid}">${dto.userid}</a>
			</div>
		</div>
		<div class="row p-3">
			<div class="col">
				<img src="/upload/challenge/${dto.chall_img}" class="img"
					onerror="this.src='/zzp/resources/images/challenge/uploadarea.png'" width="600" height="600">
			</div>
		</div>
		<div class="row p-2 text-center">
			<div class="col" id="liked_area">
				<img src="/zzp/resources/images/challenge/like.png" width="40" height="40" class="liked">
				${dto.chall_liked}
			</div>
			<div class="col">
				<img src="/zzp/resources/images/challenge/bubble.png" width="37" height="35"> <span
					id="commentsNum">${dto.chall_comments}</span>
			</div>
		</div>
		

		<div class="row p-4" style="height: 100px;">
			${dto.chall_content}
		</div>
		
		<div class="row pt-5 pl-5 pb-5">
		  <div class="col-6 m-0 text-center">
			<img src="/upload/challenge/${dto.stamp_img}" class="thumb-stamp uploadBtn-stamp" id="uploadarea-stamp" width="300" height="300">
		  
		  </div>
		  <div class="col-6 m-0 my-auto">
		    <div>${dto.stamp_name}</div>
		    <div class="mt-3">${dto.stamp_content}</div>
		  </div>
		</div>
		
	</div>
</div>