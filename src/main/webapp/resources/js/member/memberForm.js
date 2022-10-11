$(document).ready(function() {
	
	//form 서브밋//전체 값 미입력 시 submit X
	 $("form").submit(function() {
	 	var userid = $("#userid").val();
	 	var passwd = $("#passwd").val();
	 	var passwd2 = $("#passwd2").val();
		var username = $("#username").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var phone = $("#phone").val();
		var sample4_postcode = $("#sample4_postcode").val();
		var sample4_roadAddress = $("#sample4_roadAddress").val();
		var sample4_jibunAddress = $("#sample4_jibunAddress").val();
		var mesg = $("#result4").text();
		var mesg2 = $("#result3").text();
		var mesg3 = $("#result5").text();
		
		var idChk = /^(?=.*[a-zA-Z])(?=.*[0-9]).{4,12}$/; 
		var pwChk = /^(?=.*[a-zA-Z])(?=.*[!@#$%^&*+=-_])(?=.*[0-9]).{8,25}$/;
		var nameChk = /^(?=.*[가-힣a-zA-Z]).{2,30}$/;
		var numChk = /^01(0|1[6-9])(\d{3,4})(\d{4})$/; 
		
		if (userid.length==0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("아이디를 입력해주세요 :)");
			event.preventDefault();
		} else if (passwd.length==0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("비밀번호를 입력해주세요 :)");
			event.preventDefault();
		} else if (passwd2.length==0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("비밀번호를 확인해주세요 :)");
			event.preventDefault();
		}  else if (username.length==0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("이름을 입력해주세요 :)");
			event.preventDefault();
		} else if (email1.length==0 || email2.length==0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("이메일을 입력해주세요 :)");
			event.preventDefault();
		} else if (phone.length==0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("전화번호를 입력해주세요 :)");
			event.preventDefault();
		} else if (sample4_postcode.length==0||sample4_roadAddress.length==0||sample4_jibunAddress.length==0) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("주소를 입력해주세요 :)");
			event.preventDefault();
		}
		//아이디 유효성 검사
		else if (!idChk.test(userid)) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("아이디를 형식에 맞게 입력해주세요 :)");
			$("#userid").val("");
			event.preventDefault();
		}
		//비밀번호 유효성 검사
		else if (!pwChk.test(passwd)) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("비밀번호를 형식에 맞게 입력해주세요 :)");
			$("#passwd").val("");
			event.preventDefault();
		}
		//이름 유효성 검사
		else if (!nameChk.test(username) || username.length>3) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("이름을 확인해주세요 :)");
			$("#username").val("");
			event.preventDefault();
		}
		//전화번호 유효성 검사
		else if (!numChk.test(phone)) {
			$("#modalBtn").trigger("click");
			$("#mesg").text("전화번호를 형식에 맞게 입력해주세요 :)");
			$("#phone").val("");
			event.preventDefault();
		}
		//비밀번호 오류 검사
		else if (mesg2=="비밀번호 불일치 :(") {
			$("#modalBtn").trigger("click");
			$("#mesg").text("비밀번호가 일치하지 않습니다 :(");
			$("#passwd2").val("");
			event.preventDefault();
		}
		//아이디 중복 검사
		else if (mesg=="중복된 아이디입니다 :(") {
			$("#modalBtn").trigger("click");
			$("#mesg").text("아이디를 확인해주세요 :(");
			$("#userid").val("");
			event.preventDefault();
		}
		else if (mesg=="해당 아이디를 사용할 수 없습니다:(") {
			$("#modalBtn").trigger("click");
			$("#mesg").text("아이디를 확인해주세요 :(");
			$("#userid").val("");
			event.preventDefault();
		}
		//전화번호 중복 검사
		else if (mesg3=="이미 가입된 번호 :(") {
			$("#modalBtn").trigger("click");
			$("#mesg").text("전화번호를 확인해주세요 :(");
			$("#phone").val("");
			event.preventDefault();
		}
		else if (mesg3=="번호 미입력 :(") {
			$("#modalBtn").trigger("click");
			$("#mesg").text("전화번호를 입력해주세요 :(");
			$("#phone").val("");
			event.preventDefault();
		};
	 });
		
	 
	//비번확인//키 이벤트 발생시 패스워드 일치여부 검사 
	 $("#passwd").keyup(function() {
		 var passwd = this.value;
		 var passwd2 = $("#passwd2").val();
		 var mesg = "";
		 if (passwd2!=null && passwd2.length!=0) {
			if (passwd==passwd2) {
				mesg = "비밀번호 일치 :)";
			} else {
				mesg = "비밀번호 불일치 :(";
			}
		} else {
			mesg=" ";
		}
		 $("#result3").text(mesg);
	 });
	 
	//비번확인//키 이벤트 발생시 패스워드 일치여부 검사 
	 $("#passwd2").keyup(function() {
		 var mesg = "비밀번호 불일치 :(";
		 if ($("#passwd").val()==this.value) {
			mesg = "비밀번호 일치 :)";
		}
		 $("#result3").text(mesg);
	 });

	//이메일 선택 시 값 입력
	$("#emailSel").change(function() {
		$("#email2").val(this.value);
	});

	//아이디 중복 검사
	$("#useridBtn").click(function() {
		console.log($("#modalUserid").val());
		$.ajax({
			type: "get",
			url: "join/id",
			dataType: "text",
			data: {
				userid: $("#modalUserid").val()
			},
			success: function(responseData, status, xhr) {
				//모달 span태그에 id 중복 여부 출력
				$("#result4").text(responseData);
				//사용하기 버튼 data-id 속성 추가
				$("#useId").attr("data-id",$("#modalUserid").val());
			},
			error: function(xhr, status, error) {
				console.log(error);
			}
		}); 
	});

	//아이디 중복 확인
	$("#useId").click(function() {
		var mesg = $("#result4").text();
		if (mesg=="중복된 아이디입니다 :(") {
			$("#result4").text("해당 아이디를 사용할 수 없습니다:(");
		} else if ($("#result4").text()=="사용 가능한 아이디입니다 :)") {
			$(this).attr("data-bs-dismiss", "modal");
			$("#userid").val($(this).attr("data-id")); //userid 자동 입력
			$("#checkIdmodal").modal("hide"); //모달 닫기
			$("#modalUserid").val(""); //모달 내용 삭제
			$("#result4").text(""); //모달 내용 삭제
		}
	});
	
	//전봐번호 중복 확인
	$("#phone").keyup(function() {
		let phone = $(this).val();
		$.ajax({
			type: "get",
			url: "join/phone",
			dataType: "text",
			data: {
				phone: phone
			},
			success: function(responseData, status, error) {
				$("#result5").text(responseData);
			},
			error: function(xhr, status, error) {
				console.log(error);
			}
		});
	 });
	
});