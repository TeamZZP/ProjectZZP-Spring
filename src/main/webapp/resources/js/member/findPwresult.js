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
		if (userid.length!=0 && passwd.length!=0 && changedPasswd.length!=0 && 
				$("#check").text()!=mesg && $("#check").text()!="비밀번호가 일치하지 않습니다:(" ) {
			$("form").submit();
		} 
});
	
});