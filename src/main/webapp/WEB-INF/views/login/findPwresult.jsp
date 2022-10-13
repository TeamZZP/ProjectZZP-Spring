<%@page import="com.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script type="text/javascript" src="/zzp/resources/js/member/findPwresult.js"> -->
<script type="text/javascript">
$(document).ready(function() {
	
	//reset 시 pw focus
	$("#btn2").click(function() {
		$("#passwd").focus();
	});
	
	//비번확인1//키 이벤트 발생시 패스워드 일치여부 검사 
	 $("#passwd").keyup(function() {
		 var passwd = this.value;
		 var changedPasswd = $("#changedPasswd").val();
		 var mesg = "";
		 if (changedPasswd!=null && changedPasswd.length!=0) {
			if (passwd==changedPasswd) {
				mesg = "비밀번호 일치 :)";
			} else {
				mesg = "비밀번호 불일치 :(";
			}
		} else {
			mesg=" ";
		}
		 $("#check").text(mesg);
	 });
	 
	//비번확인2//키 이벤트 발생시 패스워드 일치여부 검사 
	 $("#changedPasswd").keyup(function() {
		 var mesg = "비밀번호 불일치 :(";
		 if ($("#passwd").val()==this.value) {
			mesg = "비밀번호 일치 :)";
		}
		 $("#check").text(mesg);
	 });

	//유효성 검사 및 미입력 값 확인
	$("#btn").click(function() {
		var passwd = $("#passwd").val();
		var passwd2 = $("#changedPasswd").val();
		//비밀번호 유효성 검사
		var pwChk = /^(?=.*[a-zA-Z])(?=.*[!@#$%^&*+=-_])(?=.*[0-9]).{8,25}$/;
		if (!pwChk.test(passwd)) {
			var mesg = "비밀번호를 형식에 맞게 입력해주세요 :)";
			$("#check").text(mesg);
			$("#passwd").val("");
			$("#passwd").focus();
			event.preventDefault();
		}
	//미입력 값 확인
		else if (passwd.length==0) {
			$("#check").text("비밀번호를 입력해주세요 :)");
			$("#passwd").focus();
		} else if (changedPasswd.length==0) {
			$("#check").text("비밀번호를 확인해주세요 :)");
			$("#changedPasswd").focus();
		} 
		if (passwd.length!=0 && changedPasswd.length!=0 && 
				$("#check").text()!=mesg && $("#check").text()!="비밀번호 불일치 :(" ) {
			$("form").submit();
		} 
});
	
});
</script>   
	
<div id="container" cellpadding="0" cellspacing="0" marginleft="0" margintop="0" width="100%" height="100%" align="center">
	<div class="card align-middle" id="div1">
		<div class="card-title" id="div2">
			<h2 class="card-title" id="h2tag"><img alt="로고" src="/zzp/resources/images/header/main.png" width="50" height="50">
			<span id="main" style="color: green;">ZZP</span> </h2>
		</div>
	      <form action="/zzp/passwd/check" class="find" method="POST">
	        <div class="card-body" style="font-weight: bold;">비밀번호 재설정</div>
			  <div class="card-body">
			  	 <input type="text" name="userid" id="userid" class="form-control" value="${pwDTO.userid}" readonly="readonly"><BR>
		       	 <input type="password" name="passwd" id="passwd" class="form-control" placeholder="영문자,숫자,특수문자를 포함 8~25자리" autofocus ><BR>
		       	 <div id="phonediv">
		       	 <input type="password" name="changedPasswd" id="changedPasswd" class="form-control" placeholder="비밀번호 확인"><br>
		       	 </div>
		       	 <p id="check" class="check"></p><br/>
		       <button type="button" id="btn" class="btn btn-lg  btn btn-success" style="margin-bottom: 30px;">비밀번호 변경</button>
		       <button type="reset" id="btn2" class="btn btn-lg  btn btn-success" style="margin-bottom: 30px;">취소</button>
		      </div>
	      </form>
	   </div>
        <div class="links">
            <a class="atag" href="/zzp/login">로그인</a> | <a class="atag" href="/zzp/join">회원가입</a> | <a class="atag" href="/zzp/id">아이디 찾기</a>
        </div>
</div> 