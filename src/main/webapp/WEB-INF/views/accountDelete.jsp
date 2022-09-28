<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<%
	MemberDTO dto=(MemberDTO) session.getAttribute("login");
	String passwd=dto.getPasswd();
	String userid=dto.getUserid();
	String username=dto.getUsername();

	System.out.println(userid);
%>
<html>
<head>
<meta charset="UTF-8">
<title>ZZP</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#passwd").focus();
		
		$("#cancle").on("click", function() {
			alert("메인 페이지로 돌아갑니다.");
			location.href="MainServlet";//취소 후 메인페이지 이동
		});//end fn
		
		$("form").on("submit", function() {
			event.preventDefault();
			console.log("예 클릭");
			//비밀번호 확인
			if ($("#passwd").val() != "<%= passwd %>") {
				event.preventDefault();
				alert("비밀번호가 일치하지 않습니다.");
				$("#passwd").val("");
				$("#passwd").focus();
			} else {
				event.preventDefault();
				//*****ajax
				$.ajax({
					type : "post",
					url : "AccountDeleteServlet",//페이지 이동 없이 해당 url에서 작업 완료 후 데이터만 가져옴
					dataType : "text",
					data : {//서버에 전송할 데이터
						userid : $("#userid").val(),
						passwd : $("#passwd").val()
					},
					success : function(data, status, xhr) {
						alert("회원 탈퇴가 완료되었습니다.");
						location.href="LogoutServlet";//탈퇴, 로그아웃 후 메인페이지 이동
					},
					error: function(xhr, status, error) {
						console.log(error);
					}						
				});//end ajax
			}
		});//end fn
	});//end ready
</script>
</head>
<body>
<jsp:include page="common/header.jsp" flush="true"></jsp:include><br>

<div style = "padding: 15px 5px 5px 20px;">
<form action="AccountDeleteServlet" method="post">
<input type="hidden" name="userid" id="userid" value="<%= userid %>">
<h4><%= username %>님 정말로 회원 정보를 삭제하시겠습니까?</h4><br>
<h6><b>비밀번호를 입력해 주십시오</b></h6>
<input type="password" name="passwd" id="passwd">
<br><br>
<button class="btn btn-success">예</button>&nbsp;&nbsp;
<button type="button" id="cancle" class="btn btn-success">아니오</button>
</form>
</div>

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
        <button type="button" class="btn btn-outline-success" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="common/footer.jsp" flush="true"></jsp:include><br>
</body>
</html>