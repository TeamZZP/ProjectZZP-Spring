$(document).ready(function () {
		$("#nTittle").focus();
		$("#noticeInsert").click(function () {
			var nTittle = $("#nTittle").val();
			var nContent = $("#nContent").val();
			if (nTittle.length == 0) {
				alert("제목을 입력하십시오");
				evnet.preventDefault();
			} else if (nContent.length == 0) {
				alert("내용을 입력하십시오");
				evnet.preventDefault();
			} else {
				$("form").attr("action","/zzp/notice");
			}
		});
		$("#noticeList").click(function () {
			history.back();
			event.preventDefault();
		});
});;//end ready