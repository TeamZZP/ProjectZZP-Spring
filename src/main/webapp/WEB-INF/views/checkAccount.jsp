<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#passwd").focus();
		
		//회원 탈퇴 클릭--비밀번호 인증
		if ("${accountDelete}".length != 0) {
			console.log("계정 삭제 인증 ${accountDelete}");
			$("h4").html("<b>${login.userid}</b>님의 회원 정보가 삭제됩니다.<br>비밀번호를 입력해 주십시오.<br>");
			$("input[name=_method]").val("delete");//method delete 요청
		}
		
		$("#formConfirm").on("click", function() {
 			if ($("#passwd").val() != "${login.passwd}") {
				event.preventDefault();
				console.log("비밀번호 불일치");
				console.log("${login.passwd}");
				$("#openModal").trigger("click");
				$("#modalMesg").text("비밀번호를 확인하세요.");
				$("#passwd").val("");
				$("#passwd").focus();//작동 안 함
			} else {
				$("form").submit();
			}
		});//end fn
		
		$("#cancle").on("click", function() {
			$("#openModal").trigger("click");
			$("#modalMesg").text("마이페이지 홈으로 돌아갑니다.");
			$("#confirm").on("click", function() {
				location.href="${contextPath}/mypage/${login.userid}";
			});//end fn
		});//end fn
	});//end ready
</script>
</head>
<body>
<jsp:include page="common/header.jsp" flush="true"></jsp:include><br>

<form action="${contextPath}/mypage/${login.userid}/user" method="post">
<input type="hidden" name="_method" value="">
<div class="container col-md-6">
	<div class="justify-content-center">
		<div class="col-md-12" style="text-align: center;">
			<h4><b>${login.username}</b>님 비밀번호를 입력해 주십시오</h4>
			<div style="padding-bottom: 45px"></div>
				<input type="password" name="passwd" id="passwd" style="padding-bottom: 3px;">
				<button type="button" id="formConfirm" class="btn btn-success" style="margin-left: 20px;">확인</button>
				<button type="button" id="cancle" class="btn btn-outline-success">취소</button>
			<div style="padding-bottom: 45px"></div>
		</div>
	</div>
</div>
</form>
<!-- Button trigger modal -->
<button type="button" id="openModal" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#mypageModal" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade" id="mypageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="text-align: center;">
        <span id="modalMesg"></span>
      </div>
      <div class="modal-footer">
        <button type="button" id="confirm" class="btn btn-outline-success" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include><br>
</body>
</html>