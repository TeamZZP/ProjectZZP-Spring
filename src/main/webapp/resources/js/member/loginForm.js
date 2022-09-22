$(document).ready(function() {
	
	//아이디 비밀번호 필수
	$("#loginForm").submit(function() {
		if ($("#userid").val().length == 0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("아이디를 입력해주세요!");
			event.preventDefault();
		} else if ($("#passwd").val().length == 0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("비밀번호를 입력해주세요!");
			event.preventDefault();
		}
	});
	
});