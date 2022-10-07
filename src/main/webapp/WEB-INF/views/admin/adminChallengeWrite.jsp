<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<style>
#challDetailContent {
	width: 700px;
	margin: 0 auto;
	align-items: center;
	position: relative;
}
.uploadBtn:hover, #deleteBtn:hover, .uploadBtn-stamp:hover {
	cursor: pointer;
	filter: opacity(70%);
}
#updateBtn {
	position: absolute;
	top: 655px;
    left : 85px; 
}
#deleteBtn {
	position: absolute;
	top: 655px;
	left : 160px; 
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

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		
		//글쓰기 취소
		$(".cancelBtn").on("click", function () {
			if (confirm("페이지를 나가시겠습니까?")) {
				history.back();
			}
		});
		//수정하기 클릭시 주소 변경
		$('.update').on("click", function () {
			$('form').attr('action', '/zzp/admin/challenge/${dto.chall_id}')
		});
		//폼 제출시 조건 검사
		$("form").on("submit", function () {
			if ($("#chall_title").val().length == 0) {
				event.preventDefault();
				//alert("제목을 입력해 주세요.");
				$("#modalBtn").trigger("click");
				$("#mesg").text("제목을 입력해 주세요.");
			} else if (($("#old_file").val() == "null" || $("#old_file").val().length == 0) 
						&& $("#chall_img")[0].files[0] == null) {
				event.preventDefault();
				//alert("사진을 업로드해 주세요.");
				$("#modalBtn").trigger("click");
				$("#mesg").text("사진을 업로드해 주세요.");
			} else if (($("#old_stamp").val() == "null" || $("#old_stamp").val().length == 0) 
						&& $("#stamp_img")[0].files[0] == null) {
				event.preventDefault();
				//alert("도장 사진을 업로드해 주세요.");
				$("#modalBtn").trigger("click");
				$("#mesg").text("도장 사진을 업로드해 주세요.");
			} else if ($("#chall_img").val() != 0 && !checkFileExtension()) {
				event.preventDefault();
			} else if ($("#stamp_img").val() != 0 && !checkStampExtension()) {
				event.preventDefault();
			} else if ($("#chall_content").val().length == 0) {
				event.preventDefault();
				//alert("본문을 입력해 주세요.");
				$("#modalBtn").trigger("click");
				$("#mesg").text("본문을 입력해 주세요.");
			} else if ($("#stamp_name").val().length == 0) {
				event.preventDefault();
				//alert("도장 이름을 입력해 주세요.");
				$("#modalBtn").trigger("click");
				$("#mesg").text("도장 이름을 입력해 주세요.");
			} else if ($("#stamp_content").val().length == 0) {
				event.preventDefault();
				//alert("도장 설명을 입력해 주세요.");
				$("#modalBtn").trigger("click");
				$("#mesg").text("도장 설명을 입력해 주세요.");
			}
		});
		//파일업로드 이미지 클릭시 input type="file" 클릭
		$("#challDetailContent").on("click", ".uploadBtn", function () {
			$("#chall_img").trigger("click");
		});
		//파일업로드 취소
		$("#challDetailContent").on("click", "#deleteBtn", function () {
			$("#chall_img").val("");
			$("#old_file").val("");
			
			let preview = $(".thumb");
			preview.attr("src", "/zzp/resources/images/challenge/uploadarea.png");
			
			$("#uploadarea").addClass("uploadBtn");
			$("#updateBtn").css("display", "none");
			$("#deleteBtn").css("display", "none");
		});
		//이미지 미리보기
		$("#challDetailContent").on("change", "#chall_img", function (e) {
			console.log("변경감지");
			console.log($(this).val().length);
			if ($(this).val().length!=0 && checkFileExtension()) {
				let preview = $(".thumb");
				preview.attr("src", URL.createObjectURL(e.target.files[0]));
				
				preview.on("load", function () {
					URL.revokeObjectURL(preview.attr("src"));
					console.log("메모리에서 해제됨");
				});
				
				$("#uploadarea").removeClass("uploadBtn");
				$("#updateBtn").css("display", "");
				$("#deleteBtn").css("display", "");
				
				$("#old_file").val("");
			}
		});
		
		//도장 파일업로드 이미지 클릭시 input type="file" 클릭
		$("#challDetailContent").on("click", ".uploadBtn-stamp", function () {
			$("#stamp_img").trigger("click");
		});
		//도장 이미지 미리보기
		$("#challDetailContent").on("change", "#stamp_img", function (e) {
			console.log("변경감지");
			console.log($(this).val().length);
			if ($(this).val().length!=0 && checkStampExtension()) {
				let preview = $(".thumb-stamp");
				preview.attr("src", URL.createObjectURL(e.target.files[0]));
				
				preview.on("load", function () {
					URL.revokeObjectURL(preview.attr("src"));
					console.log("메모리에서 해제됨");
				});
				
				$("#old_stamp").val("");
			}
		});
		
	//이미지 확장자 검사
	function checkFileExtension(){ 
		let fileValue = $("#chall_img").val(); 
		let reg = /(.*?)\.(jpg|jpeg|png|gif)$/;
		if (fileValue.match(reg)) {
			return true;
		} else {
			//alert("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
			$("#modalBtn").trigger("click");
			$("#mesg").text("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
			return false;
		}
	}
	//도장 이미지 확장자 검사
	function checkStampExtension(){ 
		let fileValue = $("#stamp_img").val(); 
		let reg = /(.*?)\.(jpg|jpeg|png|gif)$/;
		if (fileValue.match(reg)) {
			return true;
		} else {
			//alert("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
			$("#modalBtn").trigger("click");
			$("#mesg").text("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
			return false;
		}
	}
		
	
	});//end ready
</script>





<div class="container pt-5">
<div id="challDetailContent">

<form action="/zzp/admin/challenge" method="post" enctype="multipart/form-data">
<input type="hidden" name="chall_id" value="${dto.chall_id}">
<input type="hidden" name="userid" value="${login.userid}">
<input type="hidden" name="old_file" id="old_file" value="${dto.chall_img}">
<input type="hidden" name="old_stamp" id="old_stamp" value="${dto.stamp_img}">

  <div class="row pt-3 pl-5 pb-3">
  <span style="text-align: left; font-weight: bold; font-size: large;">이 달의 챌린지 등록하기</span>
  <hr>
  </div>
  
  <div class="row">
	<div class="d-flex w-25">
		<select name="chall_category" id="chall_category" class="form-select">
	 	  <option>이 달의 챌린지</option>
		</select>
	</div>
	<div class="w-75">
		<input type="text" name="chall_title" id="chall_title" class="form-control" placeholder="제목"
			<c:if test="${!empty dto.chall_title}">value="${dto.chall_title}"</c:if>>
	</div>
  </div>
  <div class="row">
    <div class="p-4 text-center">
	  <c:choose>
        <c:when test="${empty dto}">
	  		<img src="/zzp/resources/images/challenge/uploadarea.png" class="thumb uploadBtn" id="uploadarea" width="600" height="600" />
	  		<img src="/zzp/resources/images/challenge/reload.png" class="uploadBtn" id="updateBtn" width="50" title="사진 다시 올리기" style="display: none;">
	 		<img src="/zzp/resources/images/challenge/trash.png" class="deleteBtn" id="deleteBtn" width="50" title="사진 삭제하기" style="display: none;">
	  	</c:when>
	    <c:otherwise>
	 		<img src="/upload/challenge/${dto.chall_img}" class="thumb" id="uploadarea" width="600" height="600">
	 		<img src="/zzp/resources/images/challenge/reload.png" class="uploadBtn" id="updateBtn" width="50" title="사진 다시 올리기">
	 		<img src="/zzp/resources/images/challenge/trash.png" class="deleteBtn" id="deleteBtn" width="50" title="사진 삭제하기">
	  	</c:otherwise>
	  </c:choose>
	  		<input type="file" accept="image/*" name="chall_img" id="chall_img" style="display: none;">
	</div>
  </div>
  <div>
  	<textarea class="form-control" rows="10" name="chall_content" id="chall_content" placeholder="본문 입력">
<c:if test="${!empty dto}">${dto.chall_content}</c:if></textarea>
  </div>
  
  <br>
  <div class="row pt-5 pl-5 pb-3">
  <span style="text-align: left; font-weight: bold; font-size: large;">도장 등록하기</span>
  <hr>
  </div>
  <div class="row pt-2 pl-5 pb-5">
	  <div class="col-6 m-0 text-center">
	  <c:choose>
        <c:when test="${empty dto}">
			<img src="/zzp/resources/images/challenge/stamp.png" class="thumb-stamp uploadBtn-stamp" id="uploadarea-stamp" width="300" height="300">
	  	</c:when>
	    <c:otherwise>
	    	<img src="/upload/challenge/${dto.stamp_img}" class="thumb-stamp uploadBtn-stamp" id="uploadarea-stamp" width="300" height="300">
	  	</c:otherwise>
	  </c:choose>
	  	<input type="file" accept="image/*" name="stamp_img" id="stamp_img" style="display: none;">
	  </div>
	  <div class="col-6 m-0 my-auto">
	    <input type="text" class="form-control" name="stamp_name" id="stamp_name" 
	    		<c:if test="${!empty dto}">value="${dto.stamp_name}"</c:if> placeholder="도장 이름 입력">
	    <textarea class="form-control mt-3" rows="5" name="stamp_content" id="stamp_content" placeholder="도장 설명 입력"
	    	><c:if test="${!empty dto}">${dto.stamp_content}</c:if></textarea>
	  </div>
  </div>
	  
  <div class="row pt-5">
    <div class="col">
	  <a class="cancelBtn btn btn-success">취소</a>
	</div>
	<div class="col">
	  <div class="float-end">
	  <c:choose>
        <c:when test="${empty dto}">
	 		<input type="submit" class="btn btn-success" value="글쓰기">
	  	</c:when>
	    <c:otherwise>
	  		<input type="submit" class="btn btn-success update" value="수정하기">
	  	</c:otherwise>
	  </c:choose>
	  </div>
	</div>
  </div>

</form>
</div>
</div>

<!-- 모달 -->
<div class="modal" id="checkVal" data-bs-backdrop="static">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">ZZP</h5>
      </div>
      <div class="modal-body">
        <p id="mesg"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#checkVal">modal</button>