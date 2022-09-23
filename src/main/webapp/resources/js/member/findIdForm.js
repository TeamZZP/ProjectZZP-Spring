$(document).ready(function() {
	
	//라디오 선택 시 전화번호, 이메일 전환
	$(".type").click(function() {
		var chkvalue = $(".type:checked").val();
		if (chkvalue=='email') {
			$("#username").val("");
			$("#email1").val("");
			$("#email2").val("");
			$("#username").focus();
			$("#phonediv").css("display","none");
			$("#email").css("display","");
		} else {
			$("#username").val("");
			$("#phone").val("");
			$("#username").focus();
			$("#email").css("display","none");
			$("#phonediv").css("display","");
		}
	});
	
	//미입력 값 확인
	$("#btn").click(function() {
		var username = $("#username").val();
		var phone = $("#phone").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var chkvalue = $(".type:checked").val();
		if (chkvalue=='phone') {
			if (username.length==0) {
				$("#check").text("이름을 입력해주세요 :)");
				$("#username").focus();
			} else if (phone.length==0) {
				$("#check").text("전화번호를 입력해주세요 :)");
				$("#phone").focus();
			}
			if (username.length!=0&&phone.length!=0) {
				$("form").submit();
			} 
		} else if (chkvalue=='email') {
			if (username.length==0) {
				$("#check").text("이름을 입력해주세요 :)");
				$("#username").focus();
			} else if (email1.length==0) {
				$("#check").text("이메일을 입력해주세요 :)");
				$("#email1").focus();
			} else if (email2.length==0) {
				$("#check").text("이메일을 입력해주세요 :)");
				$("#email2").focus();
			} 
			if (username.length!=0&&email1.length!=0&&email2.length!=0) {
				$("form").submit();
			} 
		}
	});
	
});