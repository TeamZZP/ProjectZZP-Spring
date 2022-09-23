$(document).ready(function() {
			$("#qTittle").focus();
			$("#questionInsert").click(function() {
				var qtittle = $("#qTittle").val();
				var qContent = $("#qContent").val();
				if (qtittle.length == 0) {
					alert("제목을 입력하십시오");
					event.preventDefault();
				} else if (qContent.length == 0) {
					alert("내용을 입력하십시오");
					event.preventDefault();
				}
			});
			
			$("#questionList").click(function () {
				$("#questionForm").attr("action", "QuestionListServlet");
			})
			$("#questionInsert").click(function () {
				$("#questionForm").attr("action", "../qna");
			})
			$("#pID").click(function () {
				var url = "/zzp/qna/pop"
				window.open(url,"","width=400px height=500px");
			});
			function checkFileExtension(){ 
				let fileValue = $("#qFile").val(); 
				let reg = /(.*?)\.(jpg|jpeg|png|gif)$/;
				if (fileValue.match(reg)) {
					return true;
				} else {
					alert("jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
					return false;
				}
			}
		});//end ready